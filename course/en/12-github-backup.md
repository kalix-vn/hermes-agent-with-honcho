# Module 12 — Automatic backup to GitHub

> **Duration:** ~10 minutes · **Level:** Intermediate
> **Goal:** Have the agent automatically back up its config/skills/memory to a **private** GitHub repo,
> so you don't lose your work when the server dies, and can "roll back" to a previous version.
> **Prerequisites:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md); a GitHub account

## 🎯 What you'll have after this lesson
- A **private** repo + a **fine-grained PAT** with only `contents: read/write` permission on exactly that repo.
- The token set the right way (`hermes config set GITHUB_TOKEN ...`), **not** pasted into the chat.
- The ability to instruct the agent to back up and enable **auto-commit** on important changes.

---

## 🧭 Context / setup

〔Say〕 "The more you use it, the more valuable the agent becomes — it accumulates memory, skills, config.
If you lose the VPS/container without a backup, you lose everything. GitHub is both a **backup** and a
**version history** to roll back to when the agent 'loses its edge'."

---

## 🪜 Steps

### Step 1 — Create a **private** GitHub repo

**Action:** GitHub → **New repository** → name it e.g. `hermes-agent-backup` → **Visibility: Private**
→ **Create repository**. Leave it empty, keep this tab open.

> ⚠️ **Private is mandatory.** The backup may contain sensitive information.

`【SCREENSHOT: creating a private repo】`

### Step 2 — Create a Fine-grained Personal Access Token (least-privilege)

**Action:** GitHub → profile picture → **Settings → Developer settings → Personal access tokens →
Fine-grained tokens → Generate new token**:
- **Name:** `hermes-backup-repo`
- **Expiration:** set an expiry (e.g. 90 days) — more secure than "no expiration".
- **Repository access:** **Only select repositories** → pick the exact `hermes-agent-backup` repo.
- **Permissions → Repository permissions → Contents → Read and write**.
- **Generate token** → copy it (shown only once).

〔Say〕 "We grant **exactly one permission, on exactly one repo** — least-privilege, as we learned in
Module 04. If it leaks, the damage is minimal, and you can revoke it immediately."

`【SCREENSHOT: configuring a PAT with contents read/write on one repo】`

### Step 3 — Set the token into Hermes (THE RIGHT WAY)

**Open the Hermes shell** then:
```bash
hermes config set GITHUB_TOKEN <paste-the-PAT-here>
```
> ⚠️ **Don't** paste the PAT into the chat box. This command stores the token in Hermes's secret env, not
> in the log/LLM.

`【SCREENSHOT: 'hermes config set GITHUB_TOKEN' reports it was saved】`

### Step 4 — Run the first backup

**Action (from the dashboard/Telegram):** send a prompt with the repo URL:
> "I've granted you a GitHub fine-grained PAT with permission on **one** repo. Here's the URL:
> `https://github.com/<user>/hermes-agent-backup`. Please **back up the current Hermes config and state**
> to this repo, and **DO NOT** push any secret/API key/sensitive information."

The agent will clone the repo, select the files, and push. (It may ask for command approval — choose
"Always" for the clone/push operations on this backup repo.)

`【SCREENSHOT: the GitHub repo after the backup — with skills/state/memory/cron/config】`

### Step 5 — Review the repo (safety)

**Action:** open the repo, check that **no secret slipped in** (env, token, key). If you find one → ask the
agent to delete that file and commit again.

> 💡 The Docker/Railway backup differs from a VPS: many secrets live in the service env (not in the agent
> directory), so leak risk is lower — but you still must review.

### Step 6 — Enable auto-commit on changes

**Action:** send:
> "From now on, **whenever there's an important change** (memory, skills, config), create a new commit to
> this backup repo yourself. And still absolutely never push secrets."

From here the agent checkpoints itself in the background. Review the history via the repo's **Commits** tab.

---

## ⚠️ Common problems
| Symptom | Cause | Fix |
|---------|-------|-----|
| `403`/`permission denied` on push | PAT missing `contents:write` or wrong repo | Recreate the PAT with the right permission/repo |
| Backup empty/incomplete | Agent didn't understand what to back up | Spell it out: skills, memory, config, cron |
| Accidentally a secret in the repo | Agent pushed the wrong env file | Delete the file + rotate the leaked secret immediately |
| Token expires after a few months | You set an expiration | Create a new PAT, `hermes config set` again |

## ✅ Learner checklist
- [ ] Backup repo is **private**.
- [ ] Fine-grained PAT: only `contents: read/write` on the exact repo.
- [ ] Token set via `hermes config set GITHUB_TOKEN` (not via chat).
- [ ] Ran the first backup and **reviewed that no secret leaked**.
- [ ] Enabled auto-commit on changes.

## 🧠 Summary
Private repo + least-privilege PAT + `hermes config set` = safe backup. Instruct a backup, review, then
enable auto-commit. Now every evolution of the agent has a history and is reversible.

## ➡️ Next
[Module 13 — Voice, images & browser automation](./13-voice-image-browser.md)
