# Module 06 — Path A: Deploy locally with Docker Compose

> **Duration:** ~18 minutes · **Level:** Intermediate
> **Goal:** Build all 5 services (Hermes + Honcho API + Deriver + Postgres + Redis) running
> on your machine with a single command, and verify they're healthy.
> **Prerequisites:** [Module 05](./05-chuan-bi-moi-truong.md) (Docker installed, `.env` ready)

## 🎯 Outcomes after this lesson
- All 5 services show `Up`/`healthy` with `docker compose ps`.
- Open the dashboard at <http://localhost:3000> and log in.
- The Honcho API returns `200` at `/health`.

---

## 🧭 Context / framing

〔Say〕 "This is the fastest way to see the whole system run: one `docker compose up` command,
Docker builds the 5 services and wires their internal network together. I'll go service by service
so you understand what each one does."

**Screen action:** open [`../../docker-compose.yml`](../../docker-compose.yml), quickly show the 5 services:
`postgres`, `redis`, `honcho-api`, `deriver`, `hermes`.

---

## 🪜 Steps to perform

### Step 1 — Double-check `.env`

**Command:**
```bash
cd hermes-agent-with-honcho
cat .env | grep -v '^#' | grep .
```
Make sure you at least have `OPENAI_API_KEY=sk-...`. The DB/Redis variables already have defaults
in compose, so they're not required.

> 💡 To change the local dashboard login, add to `.env`:
> ```bash
> HERMES_DASHBOARD_USERNAME=admin
> HERMES_DASHBOARD_PASSWORD=change-this-password
> HERMES_DASHBOARD_SECRET=a-secret-string-of-32-characters-or-more
> ```
> If you don't set these, the defaults are `admin` / `hermes-local`.

### Step 2 — Build & start everything

**Command:**
```bash
docker compose up -d --build
```
〔Say〕 "`-d` = run in the background; `--build` = build the images the first time. The first run
will take a while because it has to build Honcho from source and pull the official Hermes image."

`【SCREENSHOT: terminal building, log 'Successfully built'】`

### Step 3 — Check the status

**Command:**
```bash
docker compose ps
```
Expected: `postgres`, `redis`, `honcho-api`, `hermes` in the **healthy** state; `deriver` in the
**running/Up** state (it has *no* healthcheck — see the note).

> 📌 **Why isn't the deriver "healthy"?** The deriver is a **background worker, it runs no HTTP
> server**, so a healthcheck like `curl /health` would never pass. Compose has **disabled the
> healthcheck** for it (`healthcheck: disable: true`). `Up` is enough.

### Step 4 — Read the logs to confirm everything connects

**Command:**
```bash
docker compose logs -f            # everything (Ctrl+C to exit)
docker compose logs -f hermes     # Hermes only
docker compose logs -f deriver    # Deriver only (watch it process the queue)
```
In the `hermes` log you'll see lines from the entrypoint:
```
🧠 Hermes Agent (Web Dashboard) starting...
   Honcho URL:  http://honcho-api:8000
✅ Memory provider set to honcho (/opt/data/config.yaml)
🔐 Dashboard auth: basic (username/password)
🚀 hermes dashboard --host 0.0.0.0 --port 3000 --no-open --skip-build
```

〔Say〕 "The line '✅ Memory provider set to honcho' is the moment Hermes picks Honcho as its
memory. The 'Honcho URL' line shows it knows where to call Honcho over the internal Docker network."

`【SCREENSHOT: hermes log with the line '✅ Memory provider set to honcho'】`

### Step 5 — Check the Honcho API's health

**Command:**
```bash
curl -i http://localhost:8000/health
```
Expected: `HTTP/1.1 200 OK`.

### Step 6 — Open the dashboard & log in

**Action:** open a browser to <http://localhost:3000>.
- Log in: `admin` / `hermes-local` (or the values you set in `.env`).

`【SCREENSHOT: the login screen + the dashboard after entering】`

### Step 7 — Service & port table (for reference)

| Service | URL/port (local) | Note |
|---------|------------------|---------|
| Hermes dashboard | http://localhost:3000 | Login `admin`/`hermes-local` |
| Honcho API | http://localhost:8000 | Memory API |
| Honcho health | http://localhost:8000/health | Must return `200` |
| PostgreSQL | 127.0.0.1:5432 | Binds loopback only |
| Redis | 127.0.0.1:6379 | Binds loopback only |

> 🔒 Postgres/Redis **bind `127.0.0.1` only** — not exposed to the outside network. This is built-in hardening.

### Step 8 — Stop / clean up

**Command:**
```bash
docker compose down        # stop, KEEP the data (volumes)
docker compose down -v     # stop and WIPE the data (postgres + redis)
```
> ⚠️ `-v` also erases the learned memory. Only use it when you want to start over from scratch.

---

## ⚠️ Common errors
| Symptom | Cause | Fix |
|-------------|-------------|----------|
| `hermes` never becomes `healthy` | Wrong/missing OpenAI key, or can't reach Honcho | Check `docker compose logs hermes`; verify `OPENAI_API_KEY` |
| Dashboard opens but you **can't log in** | Wrong user/pass; or extra whitespace/quotes in the variable | Compare with `.env`; the entrypoint prints a "fingerprint" (len+sha8) in the log to cross-check |
| Chat errors out / won't reply | `OPENAI_API_KEY` is a placeholder | Set a real key in `.env` **or** on the dashboard's Config page, then `docker compose up -d` |
| `deriver` keeps restarting | Can't connect to Postgres/Redis | Ensure `postgres`/`redis` are healthy first; check the deriver log |
| `port is already allocated` (3000/8000/5432) | The port is taken | Stop the process holding the port, or change the mapped port in compose |
| Honcho DB connection error | Wrong DB driver | Compose already sets `postgresql+psycopg://...`; don't change the scheme |

> 💡 **"Real chat needs a real key."** With a placeholder key, all services still boot and the
> dashboard still opens, but chat + memory extraction only work with a valid key.

## ✅ Learner checklist
- [ ] `docker compose ps`: postgres/redis/honcho-api/hermes = healthy; deriver = Up.
- [ ] `curl localhost:8000/health` → 200.
- [ ] Can log in to the dashboard at localhost:3000.
- [ ] The hermes log has the line "✅ Memory provider set to honcho".
- [ ] Sent a test message and got a reply (if you have a real key).

## 🧠 Recap
A single `docker compose up -d --build` builds all 5 services. The deriver is a background worker,
so it not being "healthy" is normal. Verify via `docker compose ps`, `/health`, and the "provider
set to honcho" log line. This is the ideal environment to learn in before going to the cloud.

## ➡️ Next up
- Want to run 24/7 in the cloud: [Module 07 — Railway](./07-trien-khai-railway.md)
- System already running: [Module 08 — First run & a tour of the Dashboard](./08-cau-hinh-lan-dau-va-dashboard.md)
