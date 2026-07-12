# Module 18 — Operations, cost & troubleshooting

> **Duration:** ~14 minutes · **Level:** Intermediate → Advanced
> **Goal:** Keep the system running stably, control costs, and self-diagnose the common issues across
> all 5 services.
> **Prerequisites:** Deployed ([Module 06](./06-trien-khai-local-docker.md) or [07](./07-trien-khai-railway.md))

## 🎯 What you'll achieve
- Read the right service's logs to isolate a fault.
- Apply the levers to reduce token cost.
- Have a **troubleshooting table** for the whole stack.

---

## 🧭 Context / lead-in

〔Say〕 "Building it isn't the end. You need to know how to read logs, cut costs, and fix things fast when
something goes wrong. 90% of issues live in a few familiar places — I've gathered them all here."

---

## 🪜 Lesson content

### 1. Log map — look in the right place

**Docker build:**
```bash
docker compose ps                 # overall status
docker compose logs -f hermes     # UI/agent/gateway (Telegram, dashboard, honcho client)
docker compose logs -f honcho-api # memory API (stores messages, health)
docker compose logs -f deriver    # background reasoning — where Honcho's LLM key errors surface
docker compose logs -f postgres   # DB
docker compose logs -f redis      # cache/queue
```
**Railway build:** each service has its own **Logs/Deployments** tab — view the exact service you suspect.

| Symptom belongs to | Look at log |
|--------------------|-------------|
| Can't log in / chat errors / Telegram silent | `hermes` |
| Doesn't remember / representation not updating | `deriver` |
| Memory API errors, `/health` fails | `honcho-api` |
| Deriver/api crashes on startup | `postgres`, `redis` |

### 2. Cost control (tokens = money)

〔Say〕 "Cost comes from **the number of LLM calls** × **context size**. Here are the levers."

| Lever | How | Module |
|-------|-----|--------|
| Set a **spend limit** at the provider | OpenAI → Usage limits | [05](./05-chuan-bi-moi-truong.md) |
| Lower **max iterations** to the default | Config | [08](./08-cau-hinh-lan-dau-va-dashboard.md) |
| Reasonable **context compression** (`0.8`) | Config | [08](./08-cau-hinh-lan-dau-va-dashboard.md) |
| **Session reset** `inactivity+daily` | Config | [08](./08-cau-hinh-lan-dau-va-dashboard.md) |
| Increase `dialecticCadence`, keep `depth=1` | `hermes honcho` | [16](./16-honcho-nang-cao.md) |
| `recallMode: tools` (only query when needed) | `hermes honcho mode` | [16](./16-honcho-nang-cao.md) |
| Use a cheap model for light tasks | multi-model config | [16](./16-honcho-nang-cao.md) |
| Cheap provider via `OPENAI_BASE_URL` | OpenRouter/DeepSeek… | [07](./07-trien-khai-railway.md) |

> 💡 Honcho has **2 token-consuming sources**: chat (Hermes) *and* the deriver (background reasoning).
> Don't forget Honcho's cadence/depth knobs when optimizing.

### 3. Routine maintenance

- **Rotate secrets** (OpenAI key, GitHub PAT, Telegram token) on a schedule — [04](./04-bao-mat-va-guardrails.md)/[12](./12-github-backup.md).
- **Verify backups** actually run (check the repo's Commits tab) — [12](./12-github-backup.md).
- **Monitor Postgres storage** (messages/representations accumulate). Clean up old data if needed.
- **Update images** when upstream Hermes/Honcho ships security patches (rebuild/redeploy).

### 4. Whole-stack troubleshooting table

| Issue | Isolate to | Fix |
|-------|-----------|-----|
| Dashboard won't open / login fails | `hermes` log | Set `HERMES_DASHBOARD_BASIC_AUTH_*`; compare the "fingerprint" in the log; redeploy after fixing env |
| Chat doesn't respond | `hermes` | Wrong OpenAI key / out of quota; switch model |
| Memory not working | `deriver` | Honcho's LLM key missing; Postgres/Redis down; wait for the deriver to process |
| `honcho-api` /health fails | `honcho-api` | Wrong DB URL; entrypoint auto-fixes the scheme — check `DB_CONNECTION_URI` |
| Deriver deploy fails (Railway) | `deriver` | Remove the Healthcheck Path (the worker has no HTTP) |
| Telegram silent | `hermes` | Gateway stopped → ask the agent to restart / restart the service |
| `port already allocated` (local) | — | Change the port / kill the process holding it |
| Agent runs long, burns tokens | `hermes` | Lower iterations; give clearer commands |
| Changed env but no effect | — | Redeploy the service (Railway) / `up -d` again (Docker) |
| Postgres full | `postgres` | Increase storage / clean up old data |

### 5. The "emergency" button

〔Say〕 "If you suspect a breach or the agent is behaving strangely:"
- **Stop immediately:** `docker compose down` (local) or turn off the `hermes` service on Railway.
- **Revoke secrets:** delete the OpenAI key, GitHub PAT, Telegram token in use.
- **Take the domain down:** remove Hermes's public domain to cut off external access.
- Restore from the GitHub backup once it's safe.

---

## ⚠️ Golden rules recap
- Secrets live in **env**, not in chat/Git.
- Expose **only Hermes**; Honcho/DB/Redis stay private.
- Change env → **redeploy** for it to take effect.
- The deriver has **no** HTTP healthcheck.

## ✅ Student checklist
- [ ] Know how to view each service's logs at the right moment.
- [ ] Applied ≥3 cost-reduction levers.
- [ ] Have the troubleshooting table down (bookmark it).
- [ ] Know the "emergency" procedure for a security incident.

## 🧠 Summary
Operations = looking at the right log + controlling tokens + maintenance + knowing how to troubleshoot.
Remember the emergency button: stop, revoke, take down the domain, restore backup. With this table, you're
in control of the system.

## ➡️ Next
[Module 19 — Wrap-up, exercises & resources](./19-tong-ket-bai-tap-tai-nguyen.md)
