# Module 08 — First run & a tour of the Dashboard

> **Duration:** ~14 minutes · **Level:** Beginner → Intermediate
> **Goal:** Get comfortable with the dashboard, send your first message, and understand the key agent
> settings (iterations, tool progress, context compression, session reset).
> **Prerequisites:** [Module 06](./06-trien-khai-local-docker.md) **or** [Module 07](./07-trien-khai-railway.md)

## 🎯 What you'll have after this lesson
- Sent a "hello world" and received a reply from the agent.
- An understanding of what **max iterations, tool progress mode, context compression, session reset** mean.
- The ability to adjust these settings via the **dashboard Config** or `hermes setup` (in a container/shell).

---

## 🧭 Context / setup

〔Say〕 "The system is up. Now let's get familiar with the 'cockpit'. In this repo, Hermes serves as a
**web dashboard** (not a terminal TUI like some other builds). But the *configuration concepts* are the
same — I'll walk through each one so that later you can tune things deliberately."

---

## 🪜 Steps

### Step 1 — Log in & send your first message

**Action:** open the dashboard (localhost:3000 or your Railway URL), log in, and type:
> `Hello world — are you running?`

Expected: the agent replies. The first run may take a few seconds to initialize.

`【SCREENSHOT: "hello world" chat and its reply】`

> ⚠️ If there's no reply / an error shows → it's almost certainly because the **OpenAI key** isn't valid.
> Set a real key (in `.env` then `docker compose up -d`, or on the dashboard's **Config page** / Railway
> env variable).

### Step 2 — Tour the main areas of the dashboard

**Action:** open and describe each in turn:
- **Chat** — the main conversation area.
- **Config / Settings** — where you set the LLM key, pick a model, tune agent parameters.
- **Skills** — the list of skills (built-in + enabled). *(Details in Module 02.)*
- **Memory** — memory status; in this build it's tied to **Honcho** *(Module 09)*.
- **Crons / Tasks** — scheduled tasks *(Module 15)*.

`【SCREENSHOT: dashboard sidebar with Chat/Config/Skills/Memory/Crons items】`

### Step 3 — Understand the key agent settings

〔Say〕 "These are the 'knobs' you'll run into most. You don't need to change them all — I'll explain so
you know which one affects what, especially **cost** and **memory**."

| Setting | Meaning | Recommendation for beginners |
|---------|---------|------------------------------|
| **Max iterations** | Max number of LLM calls for **one** request | Leave at default (~90). Higher = deeper/longer runs but **more tokens** |
| **Tool progress mode** | Shows what the agent is doing: `off` / `new` / `all` / `verbose` | Leave at **`all`** — enough visibility without clutter |
| **Context compression** | Compression threshold when the context is nearly full (0.0–1.0) | Set **`0.8`** — remembers longer before compressing |
| **Session reset mode** | When a new session is created | **`inactivity + daily reset`** — keeps context lean, lowers cost |
| **Model** | The LLM used for chat | The strongest recent model you have access to (e.g. the latest GPT line) |

**Deeper explanation (talking track):**
- 〔Context compression 0.8〕 "An LLM has a limited context window. `0.8` means it only compresses into a
  summary once the context is ~80% full before continuing — remembers longer than `0.5`."
- 〔Session reset〕 "Each channel/device is a *session*. `inactivity + daily reset` = after a period of
  silence or on a new day it spins up a fresh session. Important memories **are still saved by Honcho** —
  so resetting a session doesn't lose long-term memory." *(This is the strength of having Honcho — [Module 09](./09-kiem-chung-bo-nho-honcho.md).)*

### Step 4 — Where do you change the config?

There are 2 places:
1. **Dashboard → Config** (recommended for beginners): change the key, model, and parameters right in the web UI.
2. **`hermes setup` in a container/shell** (advanced): rerun the full configuration wizard.

**Open a shell into the Hermes container (Docker build):**
```bash
docker compose exec hermes sh
# inside the container:
hermes setup            # opens the config wizard (provider/model/iterations/...)
hermes --help           # see the commands
```
> 💡 On Railway, use the **"Shell"/"Connect"** button on the `hermes` service to get in the same way.

> ⚠️ **Don't paste your API key into the chat box** (recalling Module 04). Set the key via Config/env/`hermes config set`.

### Step 5 — (Optional) Set a secret via CLI

When you need to set a secret variable from the shell:
```bash
hermes config set OPENAI_API_KEY sk-...      # example
```
The secret is saved into Hermes's own env directory, **not** into the chat log.

---

## ⚠️ Common problems
| Symptom | Cause | Fix |
|---------|-------|-----|
| Chat silent / model error | Wrong key, out of quota, or a model you don't have access to | Check the key + usage; change the model in Config |
| Config change doesn't take effect | Not saved/redeployed | Save Config; the Railway build needs a redeploy if you changed env |
| Agent runs very long/costly | Max iterations too high / vague prompt | Lower iterations to default; give clear instructions |
| "Forgets" mid-way through a long conversation | Context compression too low | Set `0.8` |

## ✅ Learner checklist
- [ ] Sent & received your first message.
- [ ] Know where Chat/Config/Skills/Memory/Crons live.
- [ ] Can explain iterations, tool progress, compression `0.8`, session reset.
- [ ] Know the 2 ways to adjust config (dashboard vs `hermes setup`).

## 🧠 Summary
The dashboard is the cockpit. Four key knobs: iterations (cost), tool progress (`all`), compression
(`0.8`), session reset (`inactivity+daily`). Resetting a session does **not** lose long-term memory
because Honcho is there — we'll prove it in the next module.

## ➡️ Next
[Module 09 — Verify that Honcho memory works](./09-kiem-chung-bo-nho-honcho.md)
