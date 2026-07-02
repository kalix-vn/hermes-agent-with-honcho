<p align="center">
  <h1 align="center">🧠 Hermes Agent + Honcho Memory</h1>
  <p align="center">
    <strong>AI Agent with persistent, dialectic memory — Deploy to Railway in one click</strong>
  </p>
</p>

<p align="center">
  <a href="https://railway.com/template/YOUR_TEMPLATE_ID">
    <img src="https://railway.com/button.svg" alt="Deploy on Railway" />
  </a>
</p>

---

## What is this?

This template deploys [Hermes Agent](https://github.com/NousResearch/hermes-agent) (by NousResearch) with [Honcho](https://github.com/plastic-labs/honcho) (by Plastic Labs) as a self-hosted memory backend, all on [Railway](https://railway.com).

**Hermes Agent** is an AI agent that grows with you — it learns your preferences, communication style, and goals over time.

**Honcho** provides the memory layer — dialectic reasoning, multi-agent user modeling, and deep personalization that goes beyond simple key-value storage.

### Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Railway Project                       │
│                                                         │
│  ┌──────────────┐     ┌──────────────┐                  │
│  │ Hermes Agent │────▶│  Honcho API  │                  │
│  │  (Web UI)    │     │  (Memory)    │                  │
│  └──────────────┘     └──────┬───────┘                  │
│        :3000                 │                          │
│                        ┌─────┴─────┐                    │
│                        ▼           ▼                    │
│                 ┌──────────┐ ┌──────────┐               │
│                 │ PostgreSQL│ │  Redis   │               │
│                 │ (pgvector)│ │ (cache)  │               │
│                 └──────────┘ └──────────┘               │
│                        ▲                                │
│                        │                                │
│                 ┌──────────────┐                        │
│                 │   Deriver    │                        │
│                 │  (bg worker) │                        │
│                 └──────────────┘                        │
└─────────────────────────────────────────────────────────┘
```

### Services

| Service | Description | Source |
|---------|-------------|--------|
| **hermes-agent** | Web UI chat interface | [NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent) |
| **honcho-api** | Honcho memory API server | [plastic-labs/honcho](https://github.com/plastic-labs/honcho) |
| **honcho-deriver** | Background worker for memory extraction | [plastic-labs/honcho](https://github.com/plastic-labs/honcho) |
| **PostgreSQL** | Database with pgvector | Railway managed |
| **Redis** | Cache layer | Railway managed |

---

## 🚀 Deploy to Railway (One Click)

### Option 1: Railway Template (Recommended)

Click the "Deploy on Railway" button above, or go to:

```
https://railway.com/template/YOUR_TEMPLATE_ID
```

You'll be prompted to fill in:
- `OPENAI_API_KEY` — Your OpenAI API key (required)
- Other optional API keys (Anthropic, Google)

### Option 2: Deploy from GitHub

1. **Fork this repo** to your GitHub account
2. Go to [railway.com](https://railway.com) → **New Project** → **Deploy from GitHub Repo**
3. Select your forked repo
4. Follow the [Railway Template Setup Guide](#-railway-template-setup-guide) below to configure services

---

## 🛠️ Local Development

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) with Docker Compose
- An OpenAI API key (or other LLM provider)

### Quick Start

```bash
# Clone the repo
git clone https://github.com/kalix-vn/hermes-agent-with-honcho.git
cd hermes-agent-with-honcho

# Configure environment
cp .env.example .env
# Edit .env with your API keys (at minimum, set OPENAI_API_KEY)

# Build and start all services
docker compose up -d --build

# Check service status
docker compose ps

# View logs
docker compose logs -f
```

### Access Points

| Service | URL | Description |
|---------|-----|-------------|
| Hermes Web UI | http://localhost:3000 | Chat interface |
| Honcho API | http://localhost:8000 | Memory API |
| Honcho Health | http://localhost:8000/health | Health check |

### Verify Memory is Working

```bash
# Check Honcho API health
curl http://localhost:8000/health

# Open the Web UI
open http://localhost:3000

# Chat with the agent, then restart and chat again
# The agent should remember context from previous sessions
```

### Stop Services

```bash
docker compose down        # Stop services (keep data)
docker compose down -v     # Stop services AND delete data
```

---

## 📋 Railway Template Setup Guide

> This section guides you through creating a Railway Template from scratch,
> so others can deploy your setup with one click.

### Step 1: Create a New Template

1. Go to [railway.com](https://railway.com) → Sign in
2. Navigate to **Account Settings** → **Templates** → **Create Template**
3. Give it a name: `Hermes Agent + Honcho Memory`

### Step 2: Add PostgreSQL Service

1. Click **+ Add Service** → **Database** → **PostgreSQL**
2. Railway will auto-provision the database
3. Note: Railway's PostgreSQL supports pgvector out of the box

### Step 3: Add Redis Service

1. Click **+ Add Service** → **Database** → **Redis**
2. Railway will auto-provision Redis

### Step 4: Add Honcho API Service

1. Click **+ Add Service** → **GitHub Repo**
2. Select this repository: `kalix-vn/hermes-agent-with-honcho`
3. **Settings**:
   - **Root Directory**: `honcho`
   - **Builder**: Dockerfile
4. **Environment Variables**:

```bash
# Service mode
HONCHO_MODE=api

# Database (reference Railway PostgreSQL)
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}

# Cache (reference Railway Redis)
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true

# Auth
AUTH_USE_AUTH=false

# LLM Provider (user must fill in)
LLM_OPENAI_API_KEY=  # REQUIRED — ask user to fill in
```

### Step 5: Add Honcho Deriver Service

1. Click **+ Add Service** → **GitHub Repo**
2. Select this repository: `kalix-vn/hermes-agent-with-honcho`
3. **Settings**:
   - **Root Directory**: `honcho`
   - **Builder**: Dockerfile
4. **Environment Variables**:

```bash
# Service mode — deriver (background worker)
HONCHO_MODE=deriver

# Database (reference Railway PostgreSQL)
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}

# Cache
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true

# Auth
AUTH_USE_AUTH=false

# LLM Provider
LLM_OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}
```

### Step 6: Add Hermes Agent Service

1. Click **+ Add Service** → **GitHub Repo**
2. Select this repository: `kalix-vn/hermes-agent-with-honcho`
3. **Settings**:
   - **Root Directory**: `hermes`
   - **Builder**: Dockerfile
   - **Generate Domain**: Yes (this is the public-facing service)
4. **Environment Variables**:

```bash
# Honcho connection (internal Railway networking)
HONCHO_BASE_URL=http://${{honcho-api.RAILWAY_PRIVATE_DOMAIN}}:8000

# LLM Provider (user must fill in)
OPENAI_API_KEY=  # REQUIRED — ask user to fill in
```

### Step 7: Publish the Template

1. Review all services and environment variables
2. Mark `OPENAI_API_KEY` and `LLM_OPENAI_API_KEY` as **required** variables
3. Click **Publish Template**
4. Copy the template URL

### Step 8: Add Deploy Button to README

Replace `YOUR_TEMPLATE_ID` in this README with the actual template ID from Railway:

```markdown
[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/template/YOUR_TEMPLATE_ID)
```

---

## 🔧 Configuration

### Environment Variables

| Variable | Required | Service | Description |
|----------|----------|---------|-------------|
| `OPENAI_API_KEY` | ✅ | hermes | OpenAI API key for chat |
| `LLM_OPENAI_API_KEY` | ✅ | honcho | OpenAI API key for memory extraction |
| `ANTHROPIC_API_KEY` | ❌ | both | Anthropic API key |
| `GOOGLE_API_KEY` | ❌ | both | Google Gemini API key |
| `AUTH_USE_AUTH` | ❌ | honcho | Enable JWT auth (default: false) |
| `AUTH_JWT_SECRET` | ❌ | honcho | JWT secret (required if auth enabled) |
| `LOG_LEVEL` | ❌ | honcho | Log level: DEBUG, INFO, WARNING, ERROR |
| `HONCHO_APP_NAME` | ❌ | hermes | App name for Honcho (default: hermes-railway) |

### Honcho Memory Features

Once deployed, Hermes Agent will use Honcho for:

- **Cross-session persistence** — Memory survives container restarts
- **Dialectic reasoning** — Honcho analyzes conversations and derives insights
- **User modeling** — Learns preferences, habits, goals over time
- **Session summaries** — Context injection for continuity

See [Honcho Memory docs](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md) for full feature documentation.

---

## 📁 Project Structure

```
hermes-agent-with-honcho/
├── README.md                 # This file
├── docker-compose.yml        # Local development compose
├── .env.example              # Environment variables template
├── .gitignore                # Git ignore rules
├── hermes/                   # Hermes Agent service
│   ├── Dockerfile            # Web UI Docker build
│   ├── railway.toml          # Railway deployment config
│   ├── config.yaml           # Hermes configuration
│   └── entrypoint.sh         # Container startup script
└── honcho/                   # Honcho service (API + Deriver)
    ├── Dockerfile            # Honcho Docker build
    ├── railway.toml          # Railway deployment config
    └── entrypoint.sh         # Container startup script
```

---

## 🤝 Contributing

1. Fork this repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## 📄 License

This project is a deployment template that combines:
- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — MIT License
- [Honcho](https://github.com/plastic-labs/honcho) — AGPL-3.0 License

The deployment configuration files in this repository are MIT licensed.

---

## 🙏 Credits

- [NousResearch](https://github.com/NousResearch) — Hermes Agent
- [Plastic Labs](https://github.com/plastic-labs) — Honcho Memory
- [Railway](https://railway.com) — Cloud deployment platform
