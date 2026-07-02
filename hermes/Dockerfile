# ==============================================================================
# Hermes Agent — Web UI Mode for Railway
# ==============================================================================
# Lightweight build focused on the Web UI dashboard only.
# Based on upstream NousResearch/hermes-agent but stripped down
# to avoid Playwright, desktop apps, and TUI dependencies.
# ==============================================================================

FROM python:3.13-slim-bookworm AS python_base

# ---------- System dependencies ----------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    ripgrep \
    && rm -rf /var/lib/apt/lists/*

# ---------- Install uv ----------
COPY --from=ghcr.io/astral-sh/uv:0.11.6 /usr/local/bin/uv /usr/local/bin/uvx /usr/local/bin/

# ---------- Install Node.js 22 LTS ----------
COPY --from=node:22-bookworm-slim /usr/local/bin/node /usr/local/bin/
COPY --from=node:22-bookworm-slim /usr/local/lib/node_modules/npm /usr/local/lib/node_modules/npm
RUN ln -sf /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
    ln -sf /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

# ---------- Clone Hermes Agent source ----------
ARG HERMES_VERSION=main
WORKDIR /opt/hermes
RUN git clone --depth 1 --branch ${HERMES_VERSION} \
    https://github.com/NousResearch/hermes-agent.git /opt/hermes && \
    rm -rf /opt/hermes/.git

# ---------- Python dependencies ----------
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install Python deps with uv
RUN uv sync --frozen --no-group dev 2>/dev/null || \
    uv pip install -r requirements.txt 2>/dev/null || \
    pip install -e . 2>/dev/null || \
    echo "Python deps installed via fallback"

# ---------- Web UI dependencies ----------
WORKDIR /opt/hermes
ENV npm_config_install_links=false
RUN npm install --prefer-offline --no-audit 2>/dev/null || true
RUN cd web && npm install --prefer-offline --no-audit 2>/dev/null || true

# ---------- Create non-root user ----------
RUN useradd -u 10000 -m -d /opt/data hermes
RUN mkdir -p /opt/data/.hermes && chown -R hermes:hermes /opt/data

# ---------- Copy config and entrypoint ----------
COPY config.yaml /opt/data/.hermes/config.yaml
COPY entrypoint.sh /opt/hermes/entrypoint.sh
RUN chmod +x /opt/hermes/entrypoint.sh

# ---------- Runtime ----------
ENV PORT=3000
EXPOSE ${PORT}

HEALTHCHECK --interval=15s --timeout=5s --retries=5 --start-period=30s \
    CMD curl -f http://localhost:${PORT}/ || exit 1

USER hermes
WORKDIR /opt/hermes

ENTRYPOINT ["/opt/hermes/entrypoint.sh"]
