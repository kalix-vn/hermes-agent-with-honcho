# Deploy and Host Hermes Agent + Honcho Memory on Railway

[Hermes Agent + Honcho Memory](https://github.com/kalix-vn/hermes-agent-with-honcho) is an advanced AI agent system featuring a self-hosted cognitive architecture. Combining the tool-calling power of Hermes with Honcho's dialectic reasoning engine, it constructs a persistent, evolving user profile that summarizes sessions, reconciles conversations, and delivers a deeply personalized, contextual AI experience.

## About Hosting Hermes Agent + Honcho Memory

Hosting a self-hosted cognitive agent involves orchestrating multiple interconnected services. A standard deployment requires a frontend Web UI (Hermes Agent) to interact with users, an API server (Honcho API) to manage cognitive states, and an asynchronous worker (Honcho Deriver) to process complex dialectic reasoning via LLMs in the background. Supporting this stack requires a PostgreSQL database with the `pgvector` extension for semantic search over historical context and conclusions, and a Redis instance for caching. Deploying this manually would require complex networking, database provisioning, and env configuration, but a containerized template automates the entire orchestration.

## Common Use Cases

*   **Deeply Personalized Coding Assistant**: Creates a developer profile that remembers coding styles, project context, and preferences across sessions.
*   **Continuous Personal AI Companion**: A virtual assistant that remembers past conversations, learns from them over time, and adapts its personality to your feedback.
*   **Stateful Multi-Agent Workflows**: Run multiple isolated agent personas that interact with the same user while keeping separate, secure context profiles.

## Dependencies for Hermes Agent + Honcho Memory Hosting

*   **LLM Provider API Key**: An API key from OpenAI, Anthropic, or Google Gemini to drive chat generation and background memory extraction.
*   **PostgreSQL Database with pgvector**: For storing relational memory observations and executing vector-based semantic search.
*   **Redis Cache**: A fast in-memory key-value store for session state and background worker task queue management.

### Deployment Dependencies

*   [NousResearch/hermes-agent Repository](https://github.com/NousResearch/hermes-agent) — The upstream repository for the core agent.
*   [plastic-labs/honcho Repository](https://github.com/plastic-labs/honcho) — The upstream repository for the Honcho memory server.
*   [pgvector/pgvector Docker Image](https://hub.docker.com/r/pgvector/pgvector) — PostgreSQL image bundled with vector similarity search capabilities.

### Implementation Details

This template packages the services in a monorepo structure, allowing Railway to deploy the API, Deriver, and Web UI as distinct services from a single GitHub repository using custom entrypoints:

```bash
# Honcho API Entrypoint (HONCHO_MODE=api)
uv run uvicorn src.main:app --host 0.0.0.0 --port $PORT

# Honcho Deriver Entrypoint (HONCHO_MODE=deriver)
uv run python -m src.deriver

# Hermes Web UI Entrypoint
npm run start -- --port $PORT --host 0.0.0.0
```

## Why Deploy Hermes Agent + Honcho Memory on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Hermes Agent + Honcho Memory on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
