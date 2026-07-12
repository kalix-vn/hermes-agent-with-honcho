# Module 05 — Prepare environment & accounts

> **Duration:** ~10 minutes · **Level:** Beginner
> **Goal:** Prepare enough accounts, keys, and tools so that 100% of the later modules run smoothly on
> the first try.
> **Prerequisites:** [Module 04](./04-bao-mat-va-guardrails.md)

## 🎯 Outcomes after this lesson
- Have an **OpenAI API key** (with a spend limit set) and know where to paste it.
- Have a **GitHub**, **Railway** (if deploying to cloud), and **Telegram** account ready.
- Have **Docker** installed (if deploying locally) and the **repo cloned**.

---

## 🧭 Context / framing

〔Say〕 "Before we build, we gather all the 'ingredients'. Clean up this step and the later modules
won't have to stop midway to go create an account."

---

## 🪜 Steps to perform

### Step 1 — Get an OpenAI API key (required)

**Action:** go to <https://platform.openai.com> → **API keys** → **Create new secret key** → copy it.

〔Say〕 "This key is used for **both Hermes (chat) and Honcho (memory extraction)** — in this repo
you only enter it **once**, and the other services reference it."

> ⚠️ **Set a spend limit right now** (a reminder from Module 04): **Settings → Limits → Usage limits** →
> set a monthly cap (e.g. $10–20 while learning). Avoid a surprise bill.

`【SCREENSHOT: the API key creation page + the usage limit page】`

> 💡 **OpenAI is not required:** the repo supports OpenAI-compatible endpoints (OpenRouter, DeepSeek,
> Together AI, local vLLM…) via `OPENAI_BASE_URL`. Beginners should just use OpenAI for simplicity;
> for the advanced option see [Module 07](./07-trien-khai-railway.md) (Step 7) and [Module 18](./18-van-hanh-chi-phi-troubleshooting.md).

### Step 2 — GitHub account (required)

- Needed to **clone the repo** and set up **auto-backup** ([Module 12](./12-github-backup.md)).
- If you don't have one: create it for free at <https://github.com>.

### Step 3 — Choose your deployment path → prepare accordingly

| If you choose… | What to prepare |
|-----------|-------------|
| **Docker local (Module 06)** | Install **Docker Desktop / Docker Engine** + Docker Compose: <https://docs.docker.com/get-docker/> |
| **Railway cloud (Module 07)** | A **Railway** account: <https://railway.com> (log in with GitHub) |

〔Say〕 "If you're not sure which to pick, just install Docker and try local first — it's light and free."

### Step 4 — Telegram account (for Module 11)

- Install the Telegram app on your phone/computer and log in.
- No need to create a bot yet — we'll do that in [Module 11](./11-ket-noi-telegram.md).

### Step 5 — Clone the repo to your machine

**Command:**
```bash
git clone https://github.com/Avanix-AI/hermes-agent-with-honcho.git
cd hermes-agent-with-honcho
```

**Action:** open the repo folder and show the structure so learners get familiar with it:
```
hermes-agent-with-honcho/
├── docker-compose.yml     # builds the 5 services locally (Module 06)
├── .env.example           # environment variable template → copy to .env
├── hermes/                # the Hermes service (Dockerfile, config.yaml, entrypoint)
├── honcho/                # the Honcho service (api + deriver)
├── README.md              # bilingual documentation
└── course/                # 👈 the course scripts (what you're reading)
```

`【SCREENSHOT: the repo directory tree in VS Code】`

### Step 6 — Create the `.env` file from the template

**Command:**
```bash
cp .env.example .env
```
Open `.env` and at minimum fill in:
```bash
OPENAI_API_KEY=sk-...            # the key from Step 1
# (optional) change the local dashboard login:
# HERMES_DASHBOARD_USERNAME=admin
# HERMES_DASHBOARD_PASSWORD=change-to-a-strong-password
```

> ⚠️ `.env` is **already in `.gitignore`** — never commit it. Verify:
> ```bash
> git status        # .env must NOT appear in the list of changes
> ```

---

## ⚠️ Common errors
| Symptom | Cause | Fix |
|-------------|-------------|----------|
| `git: command not found` | Git not installed | Install Git: <https://git-scm.com> |
| `docker: command not found` | Docker not installed/started | Install & open Docker Desktop |
| OpenAI reports `insufficient_quota` | No credit / limit exhausted | Add credit + check the usage limit |
| `.env` appears in `git status` | `.gitignore` was modified | Don't commit; restore `.gitignore` |

## ✅ Learner checklist
- [ ] Have `OPENAI_API_KEY` and **have set a spend limit**.
- [ ] Have a GitHub account (+ Railway if deploying to cloud).
- [ ] Have installed Docker (if deploying locally).
- [ ] Have `git clone`d the repo and created `.env` with `OPENAI_API_KEY`.
- [ ] Confirmed `.env` does **not** appear in `git status`.

## 🧠 Recap
Ingredients: OpenAI key (with a spend limit), GitHub, and Docker *or* Railway. Clone the repo,
create `.env`. Once this step is done you're ready to build the system in the next module.

## ➡️ Next up
- Deploy locally: [Module 06 — Docker Compose](./06-trien-khai-local-docker.md)
- Deploy to cloud: [Module 07 — Railway](./07-trien-khai-railway.md)
