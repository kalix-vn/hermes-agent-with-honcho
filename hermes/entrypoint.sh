#!/bin/sh
set -e

echo "🧠 Hermes Agent Starting..."
echo "   Mode: Web UI"
echo "   Port: ${PORT:-3000}"
echo "   Honcho URL: ${HONCHO_BASE_URL:-not configured}"

# Create Hermes home directory structure if needed
export HERMES_HOME="${HERMES_HOME:-/opt/data/.hermes}"
mkdir -p "${HERMES_HOME}"

# Write Honcho config dynamically from environment variables
if [ -n "${HONCHO_BASE_URL}" ]; then
  echo "📦 Configuring Honcho memory provider..."
  cat > "${HERMES_HOME}/honcho.json" << EOF
{
  "baseUrl": "${HONCHO_BASE_URL}",
  "token": "${HONCHO_AUTH_TOKEN:-}",
  "appName": "${HONCHO_APP_NAME:-hermes-railway}"
}
EOF
  echo "✅ Honcho config written to ${HERMES_HOME}/honcho.json"
fi

# Write .env file for Hermes from Railway environment variables
cat > "${HERMES_HOME}/.env" << EOF
OPENAI_API_KEY=${OPENAI_API_KEY:-}
ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY:-}
GOOGLE_API_KEY=${GOOGLE_API_KEY:-}
EOF

echo "🚀 Starting Hermes Web UI..."

# Start the web dashboard
# Try different known start commands from upstream
if [ -f "web/package.json" ]; then
  cd web
  exec npm run start -- --port "${PORT:-3000}" --host 0.0.0.0
elif [ -f "run_agent.py" ]; then
  exec python run_agent.py --web --port "${PORT:-3000}" --host 0.0.0.0
else
  echo "⚠️  Could not find Web UI entry point. Attempting npm start..."
  exec npm start
fi
