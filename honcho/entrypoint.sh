#!/bin/sh
set -e

echo "🔧 Honcho Server Starting..."
echo "   Mode: ${HONCHO_MODE:-api}"

# Run database migrations
echo "📦 Running database migrations..."
uv run alembic upgrade head
echo "✅ Migrations complete"

# Determine which service to run
case "${HONCHO_MODE:-api}" in
  api)
    echo "🚀 Starting Honcho API server on port ${PORT:-8000}..."
    exec uv run uvicorn src.main:app \
      --host 0.0.0.0 \
      --port "${PORT:-8000}" \
      --workers "${WORKERS:-1}" \
      --log-level "${LOG_LEVEL:-info}"
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
