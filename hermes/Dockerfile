# ==============================================================================
# Hermes Agent — Web Dashboard for Railway
# ==============================================================================
# Based on the OFFICIAL upstream image, which already ships:
#   - the Python venv + all runtime deps (FastAPI/uvicorn "web" extra)
#   - the pre-built web dashboard bundle (HERMES_WEB_DIST)
#   - the s6-overlay supervisor + main-wrapper that routes the CMD to `hermes`
#     and drops privileges to the non-root `hermes` user
#
# We only add what the upstream image intentionally leaves out:
#   1. the Honcho SDK (lazy installs are disabled in the image), and
#   2. a start script that seeds config from env and launches the dashboard.
# ==============================================================================
FROM nousresearch/hermes-agent:v2026.7.1

# ---------- Honcho memory provider dependency ----------
# The image sets HERMES_DISABLE_LAZY_INSTALLS=1 and does NOT bundle the Honcho
# SDK, so the honcho memory provider would fail on `from honcho import Honcho`.
# Bake it into the venv (matches Hermes' own `honcho` extra pin). The venv is
# uv-managed and has no pip, so install with uv.
RUN uv pip install --python /opt/hermes/.venv/bin/python --no-cache "honcho-ai==2.0.1"

# ---------- Config + start script ----------
# /opt/data is a VOLUME, so config.yaml is seeded at runtime by the start
# script (see entrypoint.sh) — we stage the canonical copy outside the volume.
COPY config.yaml /opt/hermes/railway-config.yaml
COPY entrypoint.sh /opt/hermes/railway-entrypoint.sh
RUN chmod +x /opt/hermes/railway-entrypoint.sh

# Default port (Railway overrides via $PORT).
ENV PORT=3000
EXPOSE 3000

# Keep the image's ENTRYPOINT ["/init", ".../main-wrapper.sh"] intact so
# s6 init + privilege-drop still run. main-wrapper treats an executable CMD[0]
# as a bare command and execs it as the hermes user with the venv active.
CMD ["/opt/hermes/railway-entrypoint.sh"]
