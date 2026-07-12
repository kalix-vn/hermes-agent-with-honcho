# Module 03 — What is Honcho & why pair it with Hermes

> **Duration:** ~14 minutes · **Level:** Beginner → Intermediate
> **Goal:** Understand what kind of memory layer Honcho is, the Peer/Session/Workspace concepts, and *why*
> pairing it with Hermes is stronger than the default memory.
> **Prerequisites:** [Module 02](./02-kien-truc-va-5-khai-niem.md)

## 🎯 Outcomes after this lesson
- Explain Honcho in one sentence: *"memory that understands people, not a text store"*.
- Grasp 4 concepts: **Workspace · Peer · Session · Message**, and 3 reasoning concepts: **Deriver ·
  Representation · Dialectic/Chat**.
- Understand the 5-service architecture in the repo and the **synchronous (store)** vs **asynchronous (reason)** data flow.

---

## 🧭 Context / framing

〔Say〕 "The default memory of an agent is usually just a *summary of old messages*. Honcho does it
differently: it **builds a model of you** — preferences, beliefs, communication style — and
**continuously updates** that model as it understands you better. It's made by Plastic Labs, open
source, and we're going to **self-host** it."

---

## 🪜 Lesson content

### 1. What problem does Honcho solve?

〔Say〕 "The problem with AI assistants: end the session, it forgets; switch devices, it forgets;
restart the server, it forgets. And even when it remembers, it only remembers *the words said*,
not *what kind of person you are*."

Honcho is **memory infrastructure for stateful agents**. It:
- **Receives the messages** you store (synchronous, fast).
- **Reasons in the background** (asynchronous) to update its understanding of each "peer".
- **Answers queries**: session context, search results, or *natural-language insight*.

### 2. The four storage concepts (Storage — synchronous)

**Screen action:** show the hierarchy diagram.

```
Workspace  (an isolated space — e.g. "hermes-railway")
  └── Peer         (an entity: a USER or the AGENT itself)
        └── Session   (a conversation / thread)
              └── Message  (a message, tagged with its source peer)
```

| Concept | Meaning | Metaphor |
|-----------|-------|-------|
| **Workspace** | A top-level container, isolating data between applications (multi-tenant) | "The building" |
| **Peer** | *Any entity* — a user **or** an AI agent — is a first-class citizen | "A person" |
| **Session** | A set of interactions between peers (thread/conversation) | "A conversation" |
| **Message** | The smallest unit of data, tagged with its source peer, processed asynchronously | "An utterance" |

〔Say〕 "The neat part: both **you and the agent are 'peers'**. This lets Honcho model both and
keep multiple agents/multiple users separate without mixing up context."

### 3. The three reasoning concepts (Insights — asynchronous)

〔Say〕 "This is the 'smart' part. After storing a message, a background process called the
**Deriver** mulls it over and updates its understanding — **without slowing down the chat**."

| Concept | Meaning |
|-----------|-------|
| **Deriver** | A background worker processing a queue: updates the representation, creates session summaries, draws conclusions |
| **Representation** | A *low-latency static snapshot* of what Honcho knows about a peer (can be per-session) |
| **Dialectic / Chat** | Ask Honcho in natural language: *"what learning style does the user prefer?"* → an answer grounded in reasoning |

〔Say〕 "**Dialectic** (dialectic reasoning) is the highlight: instead of returning raw text,
Honcho synthesizes and *reasons* to produce an insight about you."

Example API (just for illustration, learners **do not need to type** this now):
```python
alice = honcho.peer("alice")
session.add_messages([alice.message("I like short explanations with examples")])
# ... deriver processes in the background ...
answer = alice.chat("What explanation style does the user prefer?")
# → "Prefers concise, with concrete examples"
```

### 4. The real architecture in this repo (5 services)

**Screen action:** open [`../../README.md`](../../README.md), the *Architecture* section, and show:

```
Hermes Agent (dashboard :3000) ──► Honcho API (:8000)
                                        │
                              ┌─────────┴─────────┐
                              ▼                   ▼
                        PostgreSQL(pgvector)    Redis(cache)
                              ▲
                              │
                        Honcho Deriver (background worker)
```

| Service | Role |
|---------|---------|
| **hermes-agent** | Chat dashboard + action brain |
| **honcho-api** | Memory API (stores messages, returns context/insight) |
| **honcho-deriver** | Background worker — reasons, updates the representation |
| **PostgreSQL + pgvector** | Stores messages + semantic (vector) search |
| **Redis** | Cache + task queue for the deriver |

> 📌 Remember 2 things you'll meet again when deploying:
> 1. **The deriver has no HTTP server** → don't put an HTTP healthcheck on it (it will fail the deploy).
> 2. Honcho (SQLAlchemy) needs a Postgres URL in the form `postgresql+psycopg://...`; the entrypoint
>    converts it automatically from Railway's `DATABASE_URL`. *(Details in Module 06/07.)*

### 5. How does Hermes "talk to" Honcho?

In the repo, Hermes selects Honcho as its memory provider via config:
```yaml
# hermes/config.yaml
memory:
  provider: honcho
```
and connects using the environment variable `HONCHO_BASE_URL` (+ `HONCHO_API_KEY` if auth is enabled).

When active, Hermes gains extra **Honcho tools**: `honcho_profile`, `honcho_search`,
`honcho_context`, `honcho_reasoning`, `honcho_conclude` — plus the `hermes honcho ...` command set.
*(We use them for real in [Module 09](./09-kiem-chung-bo-nho-honcho.md) and fine-tune them in [Module 16](./16-honcho-nang-cao.md).)*

---

## ⚠️ Common misconceptions
| Misconception | Reality |
|----------|---------|
| "Honcho is just a database that stores chat" | No — it *reasons* and *models* the user, not just stores. |
| "Background reasoning slows down the chat" | No — the deriver runs asynchronously, off the chat path. |
| "Only the user is a peer" | The agent is a peer too → supports multi-agent, separates context. |
| "It runs fine without Redis/Postgres" | No — Honcho needs Postgres(pgvector) + Redis. |

## ✅ Learner checklist
- [ ] Define Workspace/Peer/Session/Message.
- [ ] Explain the Deriver and the Representation.
- [ ] Say how *dialectic/chat* differs from an ordinary query.
- [ ] Can redraw the 5-service diagram.

## 🧠 Recap
Honcho = *memory that understands people*. Store (synchronous): Workspace→Peer→Session→Message.
Understand (asynchronous): Deriver → Representation + Dialectic. The repo runs 5 services; Hermes
attaches Honcho via `memory.provider: honcho` + `HONCHO_BASE_URL`. This is exactly what makes the
assistant "understand you more the more you use it".

## ➡️ Next up
[Module 04 — Security & guardrails (read before you deploy)](./04-bao-mat-va-guardrails.md)
