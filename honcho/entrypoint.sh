#!/bin/sh
set -e

echo "🔧 Honcho Server Starting..."
echo "   Mode: ${HONCHO_MODE:-api}"

# -----------------------------------------------------------------------------
# Database connection URI
# -----------------------------------------------------------------------------
# Honcho (SQLAlchemy) REQUIRES the "postgresql+psycopg://" driver prefix.
# Railway's managed Postgres exposes DATABASE_URL as "postgresql://..." (and some
# providers use the legacy "postgres://..."), so we must rewrite the scheme.
# We also fall back to Railway's DATABASE_URL when DB_CONNECTION_URI isn't set,
# so linking the Postgres plugin "just works".
: "${DB_CONNECTION_URI:=${DATABASE_URL}}"

if [ -n "${DB_CONNECTION_URI}" ]; then
  case "${DB_CONNECTION_URI}" in
    postgresql+psycopg://*)
      : # already correct
      ;;
    postgresql://*)
      DB_CONNECTION_URI="postgresql+psycopg://${DB_CONNECTION_URI#postgresql://}"
      ;;
    postgres://*)
      DB_CONNECTION_URI="postgresql+psycopg://${DB_CONNECTION_URI#postgres://}"
      ;;
  esac
  export DB_CONNECTION_URI
  # Print the scheme only (never the credentials) for debugging.
  echo "   DB scheme: $(echo "${DB_CONNECTION_URI}" | sed 's|://.*|://***|')"
else
  echo "⚠️  No DB_CONNECTION_URI or DATABASE_URL set — migrations will fail."
fi

# -----------------------------------------------------------------------------
# Cache (Redis) URL
# -----------------------------------------------------------------------------
# Fall back to Railway's REDIS_URL when CACHE_URL isn't explicitly provided.
: "${CACHE_URL:=${REDIS_URL}}"
if [ -n "${CACHE_URL}" ]; then
  export CACHE_URL
fi

# Run database migrations
echo "📦 Running database migrations..."
uv run alembic upgrade head
echo "✅ Migrations complete"

# Determine which service to run
case "${HONCHO_MODE:-api}" in
  api)
    # uvicorn's --log-level only accepts lowercase (info/debug/...), but users
    # commonly set LOG_LEVEL=INFO. Lowercase it just for this flag.
    UVICORN_LOG_LEVEL=$(echo "${LOG_LEVEL:-info}" | tr '[:upper:]' '[:lower:]')
    echo "🚀 Starting Honcho API server on port ${PORT:-8000}..."
    exec uv run uvicorn src.main:app \
      --host 0.0.0.0 \
      --port "${PORT:-8000}" \
      --workers "${WORKERS:-1}" \
      --log-level "${UVICORN_LOG_LEVEL}"
    ;;
  deriver)
    echo "🔧 Starting Honcho Deriver (background worker)..."
    exec uv run python -m src.deriver
    ;;
  *)
    echo "❌ Unknown HONCHO_MODE: ${HONCHO_MODE}"
    echo "   Valid modes: api, deriver"
    exit 1
    ;;
esac
