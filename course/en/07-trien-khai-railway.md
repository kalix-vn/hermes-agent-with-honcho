# Module 07 — Path B: Deploy to Railway (1-click + build the template yourself)

> **Duration:** ~20 minutes · **Level:** Intermediate
> **Goal:** Put the system on the cloud so it runs 24/7 — both the fast way (1-click) and the
> hands-on 9-step template so you understand every service.
> **Prerequisites:** [Module 05](./05-chuan-bi-moi-truong.md) (a Railway account + an OpenAI key)

## 🎯 What you'll have after this lesson
- A Hermes dashboard running on a public URL `https://<name>.up.railway.app`, protected by login.
- An understanding of the environment configuration of **each** service and why it's set that way.
- The knowledge to expose only Hermes and keep Honcho/DB/Redis on the internal network.

---

## 🧭 Context / setup

〔Say〕 "Railway lets you run multiple services from **one repo** (a monorepo). We'll have PostgreSQL,
Redis, the Honcho API, the Honcho Deriver and Hermes — all wired together on the internal network.
There are two ways: click the 1-click button for speed, or build it yourself for deeper understanding.
We'll do both."

---

## 🪜 PART 1 — The fast way: 1-click Deploy

### Step 1 — Click the Deploy button

**Action:** open [`../README.md`](../README.md), click **Deploy on Railway**, or open:
```
https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c
```

### Step 2 — Fill in the prompted values

- `LLM_OPENAI_API_KEY` — OpenAI key (**required**). Reused across every service → enter it **once**.
- A **username & password** for the dashboard.

> ⚠️ **Setting a dashboard login is mandatory.** Since the June 2026 security tightening, a public
> bind **must** have auth. Not setting `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` + `..._PASSWORD` = **you
> can't open the dashboard**.

`【SCREENSHOT: Railway deploy form asking for API key + dashboard login】`

### Step 3 — Wait for provisioning & grab the URL

Railway automatically spins up all 5 services. Once done → [Part 3: Expose & log in](#-part-3--expose-to-the-internet--log-in).

---

## 🪜 PART 2 — Build the template yourself (9 steps, for deeper understanding)

> Use this when you want to control each service, or to **teach learners the architecture**. Open the
> *"Railway template setup"* section in [`../README.md`](../README.md) to follow along.

### Step 1 — Create the template
Railway → **Account Settings → Templates → Create Template**, name it `Hermes Agent + Honcho Memory`.

### Step 2 — Add PostgreSQL
**+ Add Service → Database → PostgreSQL**. Railway's Postgres has `pgvector` built in.

### Step 3 — Add Redis
**+ Add Service → Database → Redis**.

### Step 4 — Add the Honcho API
**+ Add Service → GitHub Repo** → this repo. Set **Root Directory = `honcho`**. Environment variables:
```bash
HONCHO_MODE=api
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true
AUTH_USE_AUTH=false
LLM_OPENAI_API_KEY=              # REQUIRED — mark as Required when publishing
```
> 📌 **About the DB URL:** Honcho (SQLAlchemy) needs the `postgresql+psycopg://` prefix, but Railway
> returns a plain `postgresql://`. **The entrypoint rewrites the scheme automatically**, so pasting
> `${{Postgres.DATABASE_URL}}` just works. It also falls back to `DATABASE_URL`/`REDIS_URL` if you
> leave `DB_CONNECTION_URI`/`CACHE_URL` blank.

(Optional) **Healthcheck Path = `/health`** for this service.

### Step 5 — Add the Honcho Deriver
**+ Add Service → GitHub Repo** → this repo, **Root Directory = `honcho`**. Variables:
```bash
HONCHO_MODE=deriver
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true
AUTH_USE_AUTH=false
LLM_OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}
```
> ⚠️ **The deriver has no HTTP server** → **leave the Healthcheck Path blank**. An HTTP healthcheck
> would never pass and would make the deploy fail. (This is the single most common mistake when
> building it yourself!)

### Step 6 — Add the Hermes Agent
**+ Add Service → GitHub Repo** → this repo, **Root Directory = `hermes`**. Go to
**Settings → Networking → Generate Domain**. Variables:
```bash
# Connect to Honcho over Railway's internal network
HONCHO_BASE_URL=http://${{honcho-api.RAILWAY_PRIVATE_DOMAIN}}:8000

# LLM key (reused from honcho-api → entered once)
OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}

# Dashboard auth — REQUIRED for a public domain
HERMES_DASHBOARD_BASIC_AUTH_USERNAME=admin
HERMES_DASHBOARD_BASIC_AUTH_PASSWORD=<strong-password>
HERMES_DASHBOARD_BASIC_AUTH_SECRET=<32-byte-secret-string>   # keeps sessions alive across restarts
```

### Step 7 — (Optional) Custom LLM base URL
Want to use an OpenAI-compatible provider (OpenRouter, DeepSeek, Together AI, local vLLM…):
- **Hermes:** set `OPENAI_BASE_URL` (e.g. `https://openrouter.ai/api/v1`).
- **Honcho (api + deriver):** set `DERIVER_MODEL_CONFIG__OVERRIDES__BASE_URL`,
  `EMBEDDING_MODEL_CONFIG__OVERRIDES__BASE_URL`, and `EMBEDDING_MODEL_CONFIG__MODEL`
  (e.g. `text-embedding-3-small`).

### Step 8 — Publish
Mark `LLM_OPENAI_API_KEY` (on `honcho-api`) as **Required**. Because the other services reference
`${{honcho-api.LLM_OPENAI_API_KEY}}`, whoever deploys enters the key just **once**. Click **Publish Template**.

### Step 9 — Add a deploy button
```markdown
[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c)
```

`【SCREENSHOT: diagram of the 5 services on the Railway canvas, all wired together】`

---

## 🪜 PART 3 — Expose to the Internet & log in

### Step 1 — Assign a domain to **hermes**
Open the **hermes** service → **Settings → Networking → Public Networking → Generate Domain**.
Railway creates `https://<name>.up.railway.app` (HTTPS handled for you). If it asks for a port → enter **`3000`**.

### Step 2 — Log in
Open the URL you just created, log in with `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` / `PASSWORD`.

### Step 3 — (Optional) Custom domain
Same panel → **Custom Domain** → enter `chat.yourdomain.com` → add the **CNAME** record Railway shows.
Railway provisions TLS automatically.

> 🔒 **Expose ONLY Hermes.** **Don't** Generate a Domain for `honcho-api`, `honcho-deriver`, Postgres,
> or Redis. Hermes calls Honcho over the internal network (`RAILWAY_PRIVATE_DOMAIN`). If you absolutely
> must make the Honcho API public → Generate a Domain on port `8000` **and** enable `AUTH_USE_AUTH=true`
> + set up JWT keys first.

`【SCREENSHOT: Networking panel — only hermes has a public domain】`

---

## ⚠️ Common problems
| Symptom | Cause | Fix |
|---------|-------|-----|
| `honcho-deriver` deploy **fails** | A Healthcheck Path was set on the deriver | Clear the deriver's healthcheck |
| Dashboard **rejects/won't log in** | Missing `HERMES_DASHBOARD_BASIC_AUTH_*` | Set username+password, then **redeploy** |
| Honcho API DB connection error | Wrong/missing `DB_CONNECTION_URI` | Use `${{Postgres.DATABASE_URL}}` (the entrypoint fixes the scheme) |
| Changed the variable but login is still wrong | Edited env but **didn't redeploy** | Redeploy the service; the Hermes log prints a fingerprint to compare |
| Chat doesn't work | `LLM_OPENAI_API_KEY` not Required / left blank | Set the key on `honcho-api`; other services inherit it |
| Login session drops after every restart | Missing `..._BASIC_AUTH_SECRET` | Set a fixed secret ≥32 bytes |

## ✅ Learner checklist
- [ ] All 5 services are green; the deriver has **no** HTTP healthcheck.
- [ ] `hermes` has a public domain (port 3000); honcho/DB/redis remain private.
- [ ] You can log into the dashboard via the Railway URL.
- [ ] `LLM_OPENAI_API_KEY` is set to Required, entered once, and inherited by the other services.

## 🧠 Summary
Railway builds the whole stack from a monorepo. Remember 3 things: (1) the deriver has **no** HTTP
healthcheck; (2) expose only Hermes; (3) basic-auth is mandatory for a public dashboard. Complete
this step and you have an assistant running 24/7.

## ➡️ Next
[Module 08 — First run & a tour of the Dashboard](./08-cau-hinh-lan-dau-va-dashboard.md)
