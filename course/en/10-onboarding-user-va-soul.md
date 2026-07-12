# Module 10 — Onboarding: User & Soul (the agent's persona)

> **Duration:** ~12 minutes · **Level:** Beginner
> **Goal:** Teach the agent who *you are* (user) and shape *its personality* (soul) using nothing but
> natural language — no editing files by hand.
> **Prerequisites:** [Module 09](./09-kiem-chung-bo-nho-honcho.md)

## 🎯 What you'll have after this lesson
- Written an **onboarding prompt** introducing yourself + your goals.
- Tuned the agent's **soul** (tone, length, style) by talking to it.
- An understanding of how user/soul work together with Honcho to personalize.

---

## 🧭 Context / setup

〔Say〕 "The first time you use it, 'introduce yourself' to the agent: who you are, what you do, how you
want it to behave. You **don't need to edit any files** — just talk, and the agent updates `user.md`,
`soul.md` and writes to Honcho itself. The clearer you are, the better the personalization."

---

## 🪜 Steps

### Step 1 — Onboarding prompt (introduce yourself + your goals)

**Action:** send an introduction message. This is a **template for learners to customize**:

> "Hi, my name is **Minh**. Just call me Minh. I work as a **software engineer**, and I'm interested in
> **AI, Python, and work automation**. My goal in using you: help me manage email, my calendar, and
> create a daily digest. Please update your understanding of me accordingly."

〔Say〕 "It's fine to ramble a little — just talk naturally. The agent will extract the info, save it to
memory and to Honcho."

`【SCREENSHOT: the agent confirms it has updated the user profile】`

### Step 2 — Shape the Soul (personality/tone)

**Action:** send a request to adjust the soul. Template:

> "Please update your **soul.md**: always be **concise, get to the point, and be educational**. Don't
> ramble. When you do something, explain the *why* and the *steps* you follow, so I can learn and debug.
> I like an assistant that's like a teacher — succinct, not long-winded."

The agent will review its skills, adjust the soul, and confirm.

〔Say〕 "The soul is the personality. Whether you want it serious or funny, with emoji or without, how it
addresses you — just say it and it's done. You can adjust it anytime."

`【SCREENSHOT: the agent confirms it has updated the soul】`

### Step 3 — Verify the persona took effect

**Action:** ask any question and observe:
> "Explain briefly for me: what is prompt injection?"

Expected: a **concise, structured, educational** answer — matching the soul you just set.

### Step 4 — Understand how user + soul + Honcho work together

| Layer | Stores what | Who updates it |
|-------|-------------|----------------|
| `user.md` | Facts about you (name, job, interests) | The agent, when you tell it |
| `soul.md` | How the agent behaves | The agent, when you ask |
| **Honcho** | The *inferred model* of you (style, beliefs, goals) — continuously updated | The deriver, automatically after each turn |

〔Say〕 "`user.md`/`soul.md` are the snapshot you *actively* declare. Honcho is the *implicitly learned*
part — it refines its understanding over time. The two complement each other."

### Step 5 — (Recommended) Seed an 'identity' for the AI peer

Because in Honcho **the agent is a peer too**, you can seed an identity for it:
```bash
# in Hermes's shell
hermes honcho identity      # seed/define a peer for the AI
hermes honcho peer          # view/rename the peer
```
This helps Honcho separate "observations about you" from "observations about the agent" (observation mode).
Details in [Module 16](./16-honcho-nang-cao.md).

---

## ⚠️ Common problems
| Symptom | Cause | Fix |
|---------|-------|-----|
| Soul changed but answers are still long-winded | Request too vague / the model ignored it | Be specific ("max 5 sentences", "use bullet points") |
| Agent misremembers personal info | You told it conflicting things across sessions | Restate clearly, ask it to update; Honcho will reconcile |
| No apparent effect from onboarding | Onboarding too generic | Make your goals + desired style concrete |

## ✅ Learner checklist
- [ ] Sent an onboarding prompt (yourself + goals).
- [ ] Adjusted the soul and verified the tone changed.
- [ ] Can explain the role of user.md vs soul.md vs Honcho.
- [ ] (Optional) Seeded an identity for the AI peer.

## 🧠 Summary
Teach the agent to understand you by talking: onboarding (user) + adjusting the soul (persona). Honcho
handles the implicit learning underneath. This trio turns a generic assistant into *your own assistant*.

## ➡️ Next
- Connect a messaging channel: [Module 11 — Telegram](./11-ket-noi-telegram.md)
- (Or learn to fine-tune Honcho now) [Module 16 — Advanced Honcho](./16-honcho-nang-cao.md)
