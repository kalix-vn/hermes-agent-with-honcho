# Module 14 — Connecting real tools with Composio

> **Duration:** ~14 minutes · **Level:** Intermediate
> **Goal:** Let the agent touch real accounts (Gmail, Google Calendar, Notion…) through
> **Composio** — a single connection gateway — and teach it to pick the right tool.
> **Prerequisites:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md), plus the security reading in [Module 04](./04-bao-mat-va-guardrails.md)

## 🎯 What you'll achieve
- Create a Composio account and connect **Gmail + Google Calendar** (least-privilege).
- Wire Composio into Hermes and issue commands to operate on real email/calendar.
- Teach the agent to **prefer the right skill** (Composio) when working with those accounts.

---

## 🧭 Context / lead-in

〔Say〕 "An agent is only truly useful when it can **do real work**: draft emails, check the calendar,
save receipts. Instead of integrating each service one by one, we use **Composio** — a gateway to
thousands of apps. You connect an account in the Composio dashboard, then wire Composio into Hermes
once."

> ⚠️ **Security first:** this is the moment you grant access to real data. Apply least-privilege
> (Module 04): consider using a **separate/burner account** while learning, and start with read-only access.

---

## 🪜 Steps to follow

### Step 1 — Create a Composio account

**Action:** open <https://app.composio.dev> (dashboard) → create a free account.

〔Say〕 "Composio free gives ~20,000 tool calls/month — more than enough for learning and personal use."

### Step 2 — Connect apps (Connect Apps)

**Action:** Composio → **Connect Apps** → find **Gmail** → **Connect** → sign in with your Google
account (prefer a **burner** while learning) → grant permissions.
- Repeat for **Google Calendar** (can be the same account).

〔Say〕 "Granting full permissions in Composio is safe because you **limit which tools the agent may use
in a later step**. You can connect **multiple** accounts (several emails, several Drives…)."

`【SCREENSHOT: Composio with Gmail + Google Calendar connected, showing the tool list】`

### Step 3 — Get the install instructions for the agent

**Action:** Composio → **Install** → find the **OpenClaw** section (Hermes is compatible with
OpenClaw-style instructions) → **copy** the instructions/config snippet.

> 💡 No dedicated "Hermes" section? Use the **OpenClaw** instructions — it's essentially the same mechanism.

### Step 4 — Wire Composio into Hermes

**Action (from dashboard/Telegram):** paste the instruction snippet and say:
> "Please run the following steps to **connect me with Composio**: [paste instructions]. Help me log
> in to Composio."

The agent will provide a **URL to authorize** → open the URL → **Authorize** → return to the chat and
say "approved." Expected: the agent confirms **"Composio connected"**.

`【SCREENSHOT: agent reporting that Composio is connected】`

### Step 5 — Try a real operation

**Action:** try a read command (safest first):
> "Show me the subjects of the **2 most recent emails** in my inbox."

Then try the calendar:
> "Create a calendar event named 'Learn Hermes' at 8 PM tonight for me."

`【SCREENSHOT: agent listing emails / creating a calendar event】`

### Step 6 — Teach the agent to pick the right skill (very important)

〔Say〕 "At first the agent may use the wrong skill — e.g. trying to use the 'Google Workspace skill'
when it should use the 'Composio skill'. We teach it."

**Action:** send:
> "**From now on, whenever you need to work with email/calendar, use Composio** (not any other skill).
> Remember this preference."

Thanks to the self-improvement loop + Honcho, the agent will remember this preference for next time.

> 💡 If Composio reports "Gmail not linked" even though you connected it → the agent usually provides a
> **link to re-link**; clicking it fixes it. This is a common first-time connection hiccup, not your fault.

---

## ⚠️ Common issues
| Symptom | Cause | Fix |
|---------|-------|-----|
| "Gmail not linked" | First-time connection not fully completed | Click the re-link link the agent provides |
| Agent uses the wrong skill | Not taught the preference | Command it to "always use Composio for email/calendar" |
| Can't authorize | Wrong account / popup blocked | Open the correct URL, sign in with the correct account |
| Worried about overly broad permissions | Tools not restricted | Disable extra tools in Composio; start read-only |

## ✅ Student checklist
- [ ] Have a Composio account, connected Gmail + Calendar.
- [ ] Wired Composio into Hermes (agent reports connected).
- [ ] Performed 1 read operation (email) and 1 write operation (create event).
- [ ] Taught the agent to prefer Composio for email/calendar.

## 🧠 Summary
Composio = one gateway to every app. Connect in the Composio dashboard, wire it into Hermes once, then
command it in plain language. Remember least-privilege + teach the agent to pick the right skill. Now
the agent can do **real work** — ready to automate on a schedule.

## ➡️ Next
[Module 15 — Scheduled tasks (Crons/Automations)](./15-tu-dong-hoa-cron.md)
