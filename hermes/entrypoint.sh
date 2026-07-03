#!/bin/sh
# =============================================================================
# Hermes Agent — Railway/Compose start script
# =============================================================================
# Runs as the non-root `hermes` user, launched by the official image's
# main-wrapper (s6-overlay). At this point:
#   - the Python venv is activated (PATH includes /opt/hermes/.venv/bin)
#   - HERMES_HOME=/opt/data (a VOLUME, so we seed config here at RUNTIME)
# =============================================================================
set -e

HERMES_HOME="${HERMES_HOME:-/opt/data}"
PORT="${PORT:-3000}"

echo "🧠 Hermes Agent (Web Dashboard) starting..."
echo "   Port:        ${PORT}"
echo "   Honcho URL:  ${HONCHO_BASE_URL:-<not set>}"

# ---------------------------------------------------------------------------
# 1. Select Honcho as the memory provider.
#    /opt/data is a Docker VOLUME, so a config.yaml baked into the image would
#    be shadowed at runtime — we must write it here on every boot.
# ---------------------------------------------------------------------------
if [ -f /opt/hermes/railway-config.yaml ]; then
  cp /opt/hermes/railway-config.yaml "${HERMES_HOME}/config.yaml"
else
  printf 'memory:\n  provider: honcho\n' > "${HERMES_HOME}/config.yaml"
fi
echo "✅ Memory provider set to honcho (${HERMES_HOME}/config.yaml)"

# ---------------------------------------------------------------------------
# 2. Seed ~/.hermes/.env from provided environment variables.
#    Hermes reads LLM keys and the Honcho connection from here / the env.
#    (HONCHO_BASE_URL alone is enough for a self-hosted Honcho with auth off.)
# ---------------------------------------------------------------------------
ENV_FILE="${HERMES_HOME}/.env"
: > "${ENV_FILE}"
for var in OPENAI_API_KEY OPENAI_BASE_URL ANTHROPIC_API_KEY GOOGLE_API_KEY \
           HONCHO_BASE_URL HONCHO_API_KEY HONCHO_ENVIRONMENT; do
  eval val="\${$var:-}"
  if [ -n "${val}" ]; then
    echo "${var}=${val}" >> "${ENV_FILE}"
  fi
done
echo "✅ Wrote ${ENV_FILE}"

# ---------------------------------------------------------------------------
# 3. Dashboard auth. A non-loopback (0.0.0.0) bind ALWAYS requires an auth
#    provider since the June 2026 hardening — `--insecure` is a no-op now.
#    Basic auth (username+password) or OAuth satisfies it.
# ---------------------------------------------------------------------------
if [ -n "${HERMES_DASHBOARD_BASIC_AUTH_USERNAME}" ] && \
   { [ -n "${HERMES_DASHBOARD_BASIC_AUTH_PASSWORD}" ] || \
     [ -n "${HERMES_DASHBOARD_BASIC_AUTH_PASSWORD_HASH}" ]; }; then
  echo "🔐 Dashboard auth: basic (username/password)"
elif [ -n "${HERMES_DASHBOARD_OAUTH_CLIENT_ID}" ]; then
  echo "🔐 Dashboard auth: OAuth (Nous Portal)"
else
  echo "⚠️  No dashboard auth configured. A public (0.0.0.0) bind will REJECT"
  echo "    requests. Set HERMES_DASHBOARD_BASIC_AUTH_USERNAME and"
  echo "    HERMES_DASHBOARD_BASIC_AUTH_PASSWORD (or configure OAuth)."
fi

# ---------------------------------------------------------------------------
# 4. Launch the dashboard. --skip-build serves the pre-built web_dist that
#    ships in the image (no npm at runtime).
# ---------------------------------------------------------------------------
echo "🚀 hermes dashboard --host 0.0.0.0 --port ${PORT} --no-open --skip-build"
exec hermes dashboard --host 0.0.0.0 --port "${PORT}" --no-open --skip-build
