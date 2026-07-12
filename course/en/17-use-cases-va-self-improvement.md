# Module 17 — Real-world use cases & the self-improvement loop

> **Duration:** ~14 minutes · **Level:** Intermediate
> **Goal:** Turn the system into something *genuinely useful* through concrete use cases, and understand
> how to leverage the self-improvement loop (Hermes skills + Honcho).
> **Prerequisites:** [Module 14](./14-ket-noi-cong-cu-composio.md), [Module 15](./15-tu-dong-hoa-cron.md)

## 🎯 What you'll achieve
- Deploy ≥1 end-to-end use case (e.g. automated bookkeeping).
- Know how to "train" the agent through feedback so it self-improves.
- Develop the mindset to pick use cases worth automating (time ROI).

---

## 🧭 Context / lead-in

〔Say〕 "Many tutorials stop at 'it's built'. This part is where the value is: **putting it to real work**.
I'll walk through a few use cases that I've found genuinely save time, and how the agent gets better the
more you use it."

---

## 🪜 Lesson content

### 1. Use case A — Automated bookkeeping (receipts)

**Goal:** any email that's a receipt → automatically save to Google Drive, in the `receipts` folder.

**Action — create a cron:**
> "Whenever I receive a new email, check whether it's a receipt/invoice. If so, download the attachment
> and **save it to Google Drive, in the `receipts` folder**, naming it `YYYY-MM-DD_<vendor>`. At the end
> of the day, send me a list of saved receipts."

**Needs:** Composio (Gmail + Drive) — [Module 14](./14-ket-noi-cong-cu-composio.md).

`【SCREENSHOT: the Drive receipts folder auto-filled by the agent】`

### 2. Use case B — Multi-source morning brief

> "Every morning at 7 AM: compile important emails from the past 24 hours + today's calendar events +
> (optional) industry news I care about. Return the **top action items** as bullet points, max 10 lines."

〔Say〕 "The more sources you connect, the more valuable the brief. Start small, add gradually."

### 3. Use case C — Calendar optimization

> "Review this week's calendar, point out the gaps, and propose inserting 3 blocks: exercise, deep work,
> study. If I agree, create the corresponding events."

### 4. Use case D — Habit tracker / language learning

> "Every day at 9 PM: teach me **5 Japanese N4 words**, with example sentences. Then quiz me on 3 words
> from yesterday. Remember which words I often get wrong so you can repeat them."

〔Say〕 "This is where Honcho shines: it remembers **which words you often get wrong**, your level — so the
lessons get personalized over time."

### 5. Use case E — Daily wrap-up

> "At the end of each day at 10 PM: ask me what I did, compile what got done (from email/calendar), and
> suggest 1 improvement for tomorrow."

### 6. The self-improvement loop — how to leverage it

**Principle:** *short, specific, repeated feedback → the agent fixes its own skill + Honcho records preferences.*

Example loop with the morning brief:
1. Day 1: the brief is a bit long. You say: *"Shorter, max 5 lines, drop the weather section."*
2. The agent updates the `morning-brief` skill + Honcho records 'user likes short briefs'.
3. Day 2: the brief is more on-target — **no need to remind it again**.

〔Say〕 "That's the core difference from other frameworks: you **don't have to** write skills yourself or
remind it every day. You *use it and give feedback*, and it *evolves on its own*."

`【SCREENSHOT: agent updating a skill after your feedback】`

### 7. Choosing use cases worth doing (ROI mindset)

| Self-check question | Why |
|---------------------|-----|
| Do I do this **repeatedly** daily/weekly? | Repetition = worth automating |
| Does it take significant **manual time**? | High ROI |
| Do I have the **data/accounts** for the agent to touch? | Without connections, the cron is useless |
| Is the **risk acceptable** if the agent gets it wrong? | Start with low-risk tasks |

〔Say〕 "Don't try to automate everything. Pick the 2–3 most repetitive, time-consuming tasks — doing a
few well beats doing a dozen poorly."

---

## ⚠️ Common issues
| Symptom | Cause | Fix |
|---------|-------|-----|
| Agent does it but the result is bland | Vague use-case prompt | Specify input/output/format clearly |
| No "improvement" visible | Generic feedback ("do it better") | Give specific, measurable feedback |
| Automating low-value work | Picked the wrong use case | Apply the ROI table in section 7 |
| Afraid the agent will act wrongly | Granted write access too early | Read-only first; confirm before sending/deleting |

## ✅ Student checklist
- [ ] Deployed ≥1 end-to-end use case (run for real).
- [ ] Ran 1 feedback loop and saw the agent improve.
- [ ] Picked 2–3 high-ROI use cases of your own.

## 🧠 Summary
The value is in real use cases: bookkeeping, briefs, calendar, learning, wrap-up. Leverage the
self-improvement loop with specific feedback — Hermes fixes the skill, Honcho records preferences. Pick
repetitive, time-consuming, low-risk tasks to start.

## ➡️ Next
[Module 18 — Operations, cost & troubleshooting](./18-van-hanh-chi-phi-troubleshooting.md)
