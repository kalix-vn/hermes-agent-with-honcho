# Module 00 — Overview & how to use these scripts

> **Duration:** ~8 minutes · **Level:** Beginner
> **Goal:** Help learners know where the course is headed, what to prepare, and how to use this script set.
> **Prerequisites:** None.

## 🎯 Outcomes after this lesson
- Grasp the **big picture**: by the end of the course you'll have a self-hosted AI assistant with Honcho memory.
- Know the **two deployment paths** (Docker local / Railway) and be able to pick the right one for you.
- Understand the **presentation conventions** so you don't get lost in later modules.

---

## 🧭 Context / framing

〔Say〕 "Welcome to the Hermes Agent + Honcho course. Unlike tutorials that just spin up a
chatbot and stop there, here we build an **AI assistant that truly has memory** — it remembers who
you are, what you like, what you told it last week, even after the server restarts. The secret is
**Honcho** — the memory layer we'll pair with Hermes. By the end you'll build, configure,
connect Gmail/Telegram, and have it run automated tasks every day, all with your own hands."

〔Say〕 "I'll start **from zero**. You don't need to know how to code. But you will type a few
commands — I'll explain what each command does, so don't worry."

---

## 🪜 Lesson content

### 1. What does the end of the course look like? (opening demo)

〔Say〕 "Before diving into the details, here's the final result."

**Screen action:** Open an already-running Hermes dashboard, type into the chat:
> "Last week I told you I'm learning Japanese — do you still remember?"

and let the agent answer correctly — proving **cross-session memory** (this is what Honcho delivers).

`【SCREENSHOT: dashboard correctly answering information from an old session】`

> 💡 This is the "wow moment", so put it right at the start of the course to create motivation. If
> you don't yet have a running system to record the demo, you can record this segment **after**
> finishing module 09 and splice it into the beginning.

### 2. Two components, two roles

| Component | Role | Metaphor |
|-----------|---------|-------|
| **Hermes Agent** | The action brain: calls the LLM, uses skills/tools, runs crons, has a dashboard | "The hands & skill set" |
| **Honcho** | The memory layer: models the user, dialectic reasoning, long-term memory | "Memory & understanding" |

〔Say〕 "Hermes knows how to *act*. Honcho helps it *understand and remember you*. Put them
together and you get an assistant that understands you more the more you use it."

### 3. The course map (5 parts)

Open [`README.md`](./README.md) and show the table of contents:
- **A — Foundations** (00–04): understand the concepts + security.
- **B — Deployment** (05–08): build the system.
- **C — Honcho memory** (09, 10, 16): the differentiator.
- **D — Connections & automation** (11–15): make it useful.
- **E — Operations** (17–19): master & extend.

### 4. Choose your deployment path

〔Say〕 "There are two ways to build. You only need to **pick one**."

| | **Docker local (Module 06)** | **Railway (Module 07)** |
|---|---|---|
| Best for | Learning/experimenting on your own machine | Running 24/7 in the cloud |
| Infra cost | Free (your machine) | A few dollars/month |
| Requirements | Install Docker | A Railway account |
| Runs when your machine is off? | No | Yes |

> 💡 Suggestion: beginners should **do module 06 (Docker local) first** to understand the system,
> then move to Railway in module 07 when they want to really run it 24/7.

### 5. How to read each module

Quickly show the "Shared conventions" section in the README: each module has a 🎯 goal, 🪜 steps,
⚠️ common errors, ✅ checklist. Learners **watch while opening the file to follow along, and can
rewind freely**.

---

## ✅ Learner checklist
- [ ] Understand what you'll have by the end (an AI assistant with Honcho memory).
- [ ] Can distinguish the roles of Hermes vs Honcho.
- [ ] Have tentatively chosen a deployment path (Docker or Railway).
- [ ] Know how to follow the modules (the 🎯/🪜/⚠️/✅ frame).

## 🧠 Recap
Hermes = action; Honcho = memory. The course has 5 parts and 2 deployment paths. In the next
modules we start understanding each piece deeply before we roll up our sleeves and build.

## ➡️ Next up
[Module 01 — What is Hermes Agent & why use it](./01-hermes-agent-la-gi.md)
