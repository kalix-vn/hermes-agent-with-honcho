#!/usr/bin/env python3
"""Build-time patches that make username/password ("basic") dashboard auth work
on the Hermes v2026.7.1 image. See hermes/Dockerfile for the full rationale.

Two independent upstream bugs, both fixed here:

  1. middleware._auto_sso_response auto-redirects the *sole* registered session
     provider to the OAuth route /auth/login — even when that provider is
     password-only. BasicAuthProvider.start_login() then raises
     NotImplementedError, so every unauthenticated page load 500s.

  2. the /auth/login route itself calls provider.start_login() unconditionally.
     Any caller reaching it with a password-only provider hits the same 500.
     We make it redirect to the /login form (which POSTs to
     /auth/password-login) instead.

The script is idempotent (re-running is a no-op) and fails LOUDLY if an anchor
is missing, so a future image bump can never silently disable the fix.
"""
import sys


def patch(path: str, anchor: str, replacement: str, marker: str) -> None:
    with open(path, encoding="utf-8") as fh:
        src = fh.read()
    if marker in src:
        print(f"[skip] already patched: {path}")
        return
    if anchor not in src:
        sys.exit(
            f"[FAIL] anchor not found in {path!r} — upstream image changed; "
            "re-check hermes/patch-basic-auth.py"
        )
    with open(path, "w", encoding="utf-8") as fh:
        fh.write(src.replace(anchor, replacement, 1))
    print(f"[ok] patched: {path}")


# --- Bug 1: don't auto-SSO a password-only provider into the OAuth route ------
patch(
    "/opt/hermes/hermes_cli/dashboard_auth/middleware.py",
    "    providers = list_session_providers()\n",
    '    providers = [p for p in list_session_providers() '
    'if not getattr(p, "supports_password", False)]\n',
    'if not getattr(p, "supports_password", False)]',
)

# --- Bug 2: /auth/login on a password-only provider -> redirect to /login -----
_ANCHOR = (
    "    try:\n"
    "        ls = p.start_login(redirect_uri=_redirect_uri(request))\n"
)
_GUARD = (
    '    if getattr(p, "supports_password", False):\n'
    "        # Password-only provider has no OAuth redirect flow; send the user\n"
    "        # to the /login form (which POSTs to /auth/password-login) instead\n"
    "        # of calling start_login() and 500ing.\n"
    '        return RedirectResponse(url=f"{_prefix(request)}/login", status_code=302)\n'
    "\n"
)
patch(
    "/opt/hermes/hermes_cli/dashboard_auth/routes.py",
    _ANCHOR,
    _GUARD + _ANCHOR,
    "Password-only provider has no OAuth redirect flow; send the user",
)

print("basic-auth patches applied successfully")
