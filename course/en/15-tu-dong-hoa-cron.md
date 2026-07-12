# Module 15 — Scheduled tasks (Crons/Automations)

> **Duration:** ~14 minutes · **Level:** Intermediate
> **Goal:** Make the agent **proactive** — run tasks on a schedule by itself (email triage, morning
> brief, security audit) with just plain language, and know how to view/edit those crons.
> **Prerequisites:** [Module 14](./14-ket-noi-cong-cu-composio.md) (so crons can touch email/calendar)

## 🎯 What you'll achieve
- Create at least 2 crons using natural language.
- Know where crons are stored (`cron/jobs.json`) and be able to inspect them.
- Understand how cron + Honcho + self-improvement make the output fit you better over time.

---

## 🧭 Context / lead-in

〔Say〕 "So far the agent is only **reactive** — it waits for you to message. Cron makes it **proactive**:
it does work on a schedule without you commanding it every time. This is when it truly 'runs for you 24/7'."

---

## 🪜 Steps to follow

### Step 1 — Create cron #1: Email triage every morning at 7 AM

**Action:** send a prompt (customize to your needs):
> "Create a **recurring email triage task**. Run it **every day at 7:00 AM**: read all emails from the
> **past 24 hours**, filter out what's important / has action items, and send me a **short, tidy summary**
> right here in this chat."

The agent creates the cron and usually **runs it once** so you can see a sample output.

`【SCREENSHOT: agent confirming the email triage cron was created】`

### Step 2 — Create cron #2: Security audit on Sunday

**Action:**
> "Create a task that runs **every Sunday at 00:00**: check the system for any unusual activity, and
> send me a report with suggestions to improve security."

### Step 3 — View & verify the created crons

Crons are stored as a file. **How to view:**
- **Via GitHub backup** (if enabled in Module 12): open the repo → `cron/jobs.json` → see the prompt + schedule.
- **Via shell:**
  ```bash
  docker compose exec hermes sh
  # find the cron file in the Hermes data directory (e.g. $HERMES_HOME/cron/jobs.json)
  ```
- **Via dashboard:** the **Crons/Tasks** section (if present) lists the jobs.

`【SCREENSHOT: cron/jobs.json showing the schedule and prompt of a job】`

### Step 4 — Edit crons with plain language

〔Say〕 "No need to edit the file by hand. To change the time/content, just say so."
> "Move the email triage to **6:30 AM** and add a 'top 3 things to do today' section at the end of the summary."

The agent updates the cron (and auto-backs up if auto-commit is enabled).

### Step 5 — Cron idea bank (suggestions for students)

| Cron | Description | Connections needed |
|------|-------------|--------------------|
| **Morning brief / digest** | Gather multiple sources → morning action items | Gmail/Calendar/… |
| **Automated bookkeeping** | New email is a receipt → save to Drive/receipts folder | Gmail + Drive |
| **Calendar optimization** | Review calendar, suggest arrangements, insert workout/meal/focus blocks | Calendar |
| **Daily wrap-up** | End of day: what you did, what got done, what to improve | (optional) |
| **Habit tracker / language learning** | Each day teach 5 words + quiz, in the exact format you want | (none) |

〔Say〕 "This is not magic that makes you rich overnight. But set up right, it saves you a lot of time
every day. The key is **knowing what you want to automate**."

### Step 6 — Why the crons in this course are "smarter"

〔Say〕 "Every time a cron runs and you give feedback ('shorter', 'add this section'), the agent **learns**
and **updates its own skill**, while **Honcho** remembers your formatting preferences. So next week's
morning brief will fit you better than this week's — automatically."

---

## ⚠️ Common issues
| Symptom | Cause | Fix |
|---------|-------|-----|
| Cron runs but can't read email | Composio not connected or missing permissions | Complete [Module 14](./14-ket-noi-cong-cu-composio.md) |
| Cron doesn't trigger at the right time | Wrong timezone | State the timezone clearly ("7:00 VN time"); check `jobs.json` |
| Output too long / off-target | Vague cron prompt | Adjust with plain language: format, length, required sections |
| Agent (local build) doesn't run when machine is off | Local Docker isn't 24/7 | Move to Railway ([Module 07](./07-trien-khai-railway.md)) |

## ✅ Student checklist
- [ ] Created ≥2 crons with plain language.
- [ ] Viewed the crons in `cron/jobs.json` (via GitHub/shell/dashboard).
- [ ] Edited a cron with plain language.
- [ ] Have at least 1 cron that's genuinely useful for your work.

## 🧠 Summary
Cron makes the agent proactive. Create/edit with plain language, stored in `cron/jobs.json`. Combined
with Composio (real work) + Honcho + self-improvement, the recurring briefs fit you better over time.
To truly run 24/7, you need the Railway build.

## ➡️ Next
[Module 16 — Advanced Honcho: tuning & multi-agent](./16-honcho-nang-cao.md)
