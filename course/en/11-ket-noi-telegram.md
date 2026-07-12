# Module 11 — Connect Telegram

> **Duration:** ~12 minutes · **Level:** Beginner
> **Goal:** Message the agent from your phone via Telegram, restrict messaging to just you, and know how
> to debug when the bot goes "silent".
> **Prerequisites:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md); a Telegram account (Module 05)

## 🎯 What you'll have after this lesson
- A Telegram bot created with **BotFather** and its **bot token**.
- Hermes configured to use that token and **restrict the user IDs** allowed to message it.
- The ability to message "hello" from Telegram and get a reply; and to fix a gateway failure.

---

## 🧭 Context / setup

〔Say〕 "You won't always want to open a browser to chat. Telegram is the easiest channel to message your
agent from your phone. Security note: you must **restrict who can message it**, otherwise a stranger with
the token could control your agent."

---

## 🪜 Steps

### Step 1 — Create a bot with BotFather

**On Telegram:**
1. Find **`@BotFather`** (the one with the **blue checkmark**).
2. Type `/newbot`.
3. Set a **display name** (e.g. `Hermes Agent`).
4. Set a **username** — it must be **unique** and **end in `_bot`** (e.g. `minh_hermes_92413_bot`).
5. BotFather returns a **token** like `123456:ABC-DEF...`.

> ⚠️ **The token = the bot's key.** Anyone with the token can message your bot. **Don't leak it.**

`【SCREENSHOT: BotFather returns the token (partially masked)】`

### Step 2 — Get your Telegram user ID (to restrict access)

**Action:** on Telegram find **`@userinfobot`** (or a "User Info" bot) → type `/start` → it shows your
**numeric ID** → copy it.

`【SCREENSHOT: userinfobot showing the ID】`

### Step 3 — Configure Telegram for Hermes

〔Say〕 "In this dashboard build there are 2 common ways: (a) via the dashboard's **Config/Integrations**
page if it has a Telegram section; (b) via **`hermes setup`** in the shell."

**The shell way (always available):**
```bash
docker compose exec hermes sh     # (Railway: use the Shell button on the hermes service)
hermes setup                      # go to the 'messaging platform' step → choose Telegram
```
When prompted:
- **Bot token** → paste the token from Step 1.
- **Allowed user IDs** → paste the ID from Step 2 (for multiple people, separate with commas).

> 💡 The token should be set as a **secret**. If Hermes wants it via an env variable, set it with:
> ```bash
> hermes config set TELEGRAM_BOT_TOKEN <token>
> ```
> (Don't paste the token into the chat box — recalling Module 04.)

### Step 4 — Test from Telegram

**Action:** open the bot's link (BotFather gives a link based on the username) → tap **Start** → type `hello`.
Expected: the bot shows "typing…" then replies.

`【SCREENSHOT: a Telegram chat with the bot replying】`

### Step 5 — If the bot is "silent" → debug (very common)

〔Say〕 "On the first connection, the bot sometimes receives messages (shows a checkmark) but doesn't reply.
Don't panic — Hermes's 'superpower' is **fixing itself**."

**Way 1 — ask the agent itself (from the dashboard):**
> "I configured Telegram, but when I message from Telegram the bot receives it (shows a ✓) yet doesn't
> reply / doesn't 'type'. What could be the cause? Help me check and fix it."

Often the agent detects that the **Hermes gateway has stopped** and restarts it for you.

**Way 2 — check manually (logs):**
```bash
docker compose logs -f hermes | grep -i telegram
```
See whether the gateway has connected to Telegram, and whether there are token/permission errors.

`【SCREENSHOT: the agent self-diagnoses and fixes the Telegram gateway】`

---

## ⚠️ Common problems
| Symptom | Cause | Fix |
|---------|-------|-----|
| Bot receives messages but doesn't reply | Telegram gateway has stopped | Ask the agent to restart the gateway, or restart the hermes service |
| "Unauthorized" | Token wrong/revoked | Get a fresh token from BotFather and set it again |
| You message but the bot ignores you | Your user ID isn't in the allowlist | Add the correct ID (Step 2) |
| Strangers can message the bot | No user ID restriction | **Mandatory:** configure allowed IDs |
| Username rejected | Doesn't end in `_bot` or is taken | Pick a different username ending in `_bot` |

## ✅ Learner checklist
- [ ] Have a bot token from BotFather (kept secret).
- [ ] Got your Telegram user ID and added it to the allowlist.
- [ ] Messaged "hello" from Telegram and got a reply.
- [ ] Know the 2 ways to debug when the bot is silent.

## 🧠 Summary
BotFather → token; userinfobot → ID; configure + restrict with an allowlist. Send a test, and if it fails
ask the agent itself to fix the gateway. Now you can chat from your phone — and every message goes into Honcho.

## ➡️ Next
[Module 12 — Automatic backup to GitHub](./12-github-backup.md)
