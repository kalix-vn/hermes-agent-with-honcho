# Module 09 — Verify that Honcho memory works

> **Duration:** ~12 minutes · **Level:** Intermediate
> **Goal:** Prove (not just "believe") that Honcho is remembering you across sessions, and learn the
> Honcho commands/tools for checking its state.
> **Prerequisites:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md), and the concepts from [Module 03](./03-honcho-la-gi.md)

## 🎯 What you'll have after this lesson
- Created a "wow moment" with your own hands: the agent remembers info from a **previous session**.
- The ability to use `hermes honcho status` and knowledge of the `honcho_*` tools.
- The ability to confirm the deriver has reasoned (via logs/Honcho).

---

## 🧭 Context / setup

〔Say〕 "This is the 'prove the value' lesson. Default memory forgets when the session resets. With
Honcho, memories **survive across sessions, across devices, across restarts**. We'll test it directly."

---

## 🪜 Steps

### Step 1 — Confirm Honcho is the active provider

**Open a shell into Hermes** (Docker: `docker compose exec hermes sh`; Railway: the Shell button on the `hermes` service), then:
```bash
hermes honcho status
```
Expected: connection info + configuration (base URL, peer, cadence…).

> 📌 The `hermes honcho ...` command set **only appears when Honcho is the active provider**. If you
> don't see it, check that `config.yaml` has `memory.provider: honcho` and that `HONCHO_BASE_URL` is set
> (Module 06/07).

`【SCREENSHOT: output of 'hermes honcho status'】`

Useful `hermes honcho` commands (for reference, used in Module 16):
```bash
hermes honcho status      # connection & configuration info
hermes honcho peer        # view/update the peer name
hermes honcho sessions    # list session mappings
hermes honcho mode        # view/set the recall mode (hybrid/context/tools)
hermes honcho strategy    # view/set the session strategy
```

### Step 2 — Feed in a "fact" about yourself (session 1)

**Action:** in the chat, state something distinctive and easy to check:
> "Remember this for me: my name is Minh, I'm learning Japanese at N4 level, and I like short
> explanations with examples."

The agent confirms. At this point Honcho stores the message (synchronously) and **enqueues** a reasoning
job for the **deriver**.

〔Say〕 "Right now the deriver is chewing on this in the background to update its 'representation' of me —
without slowing down the chat."

### Step 3 — Watch the deriver work (technical evidence)

**Docker build:**
```bash
docker compose logs -f deriver
```
You'll see the deriver receive and process the reasoning task after you send your message.

`【SCREENSHOT: deriver log processing a task】`

### Step 4 — Create a NEW session and ask again (session 2) — the decisive test

Create a new session in **one** of these ways:
- Wait past the inactivity threshold / into a new day (if set to `inactivity+daily reset`), **or**
- Message from a **different channel** (e.g. Telegram after Module 11), **or**
- Start a brand-new conversation in the dashboard.

Then ask:
> "Do you still remember which foreign language I'm learning and at what level? And how do I like things explained?"

Expected: the agent answers correctly **"Japanese, N4, likes it short with examples"** — even though this
is a different session.

`【SCREENSHOT: the new session answers the old session's info correctly — WOW MOMENT】`

〔Say〕 "That's Honcho. It's not that it remembers the *exact words* — it has **modeled you** and retrieves
that model when needed."

### Step 5 — (Advanced) See the "insight" through Honcho tools

When Honcho is active, the agent has these tools:
| Tool | Function |
|------|----------|
| `honcho_profile` | Read/update your profile card (peer card) |
| `honcho_search` | Semantic search over the context |
| `honcho_context` | Fetch the entire session context |
| `honcho_reasoning` | A synthesized, reasoned answer (adjustable depth) |
| `honcho_conclude` | Create/delete "conclusions" about you |

**Action:** try instructing the agent to use Honcho reasoning:
> "Based on what you know about me, describe my learning and communication style."

The agent will call `honcho_reasoning`/`honcho_profile` to give a grounded answer.

`【SCREENSHOT: the agent uses the honcho_reasoning tool to describe you】`

---

## ⚠️ Common problems
| Symptom | Cause | Fix |
|---------|-------|-----|
| No `hermes honcho` command | Honcho isn't active | Check `memory.provider: honcho` + `HONCHO_BASE_URL` |
| New session **doesn't** remember | Deriver hasn't finished / errored | Check the deriver log; wait a few seconds; verify Postgres/Redis are healthy |
| Remembers the wrong person / mixes people up | Wrong peer mapping (multi-user) | Configure peer/aliases — [Module 16](./16-honcho-nang-cao.md) |
| Deriver reports an LLM error | `LLM_OPENAI_API_KEY` missing on honcho | Set the key for honcho-api & deriver |

## ✅ Learner checklist
- [ ] `hermes honcho status` returns connection info.
- [ ] Saw the deriver process a task in the log after sending a message.
- [ ] A new session answers the old session's info correctly (wow moment).
- [ ] Called a `honcho_*` tool to have the agent describe you.

## 🧠 Summary
Honcho is working when: `hermes honcho status` is OK, the deriver processes in the background, and **a new
session remembers info from the old session**. This is living proof of an "assistant with memory". Next
we'll *actively teach* the agent to understand you through onboarding.

## ➡️ Next
[Module 10 — Onboarding: User & Soul (the agent's persona)](./10-onboarding-user-va-soul.md)
