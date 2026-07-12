# 🧠 Course: Hermes Agent + Honcho Memory (from zero to real-world operation)

> A set of **detailed teaching scripts** for the entire course. Each module is a standalone
> Markdown file, written in a structure that is "both for the instructor to record/teach and for
> learners to open, follow along, and rewind". Every command, action, and common error is written
> out explicitly.

---

## 🎯 Who is this course for?

- People who are **complete beginners** to AI agents, no programming required.
- People who want to **self-host an AI assistant running 24/7** with **real long-term memory**
  (not a chatbot that forgets everything).
- People who want to understand **why Hermes + Honcho** is more powerful than an ordinary chatbot:
  Hermes handles *action & skills*, Honcho handles *memory & user modeling*.

## 🧩 What will learners have by the end?

A self-hosted Hermes Agent, connected to the Honcho memory layer, that can:
- Remember you **across sessions, across devices, across restarts**.
- Message via **Telegram / web dashboard**.
- Connect to **Gmail, Google Calendar…** via Composio.
- Run **scheduled tasks** (email triage, morning brief, security audit…).
- **Auto-backup** to GitHub and **self-improve** its skills over time.

---

## 🗺️ Roadmap & table of contents

The course is split into **5 parts**. The minutes are suggested durations for the video/lecture version.

### PART A — Foundations (understand before doing)
| # | Module | Duration | Core content |
|---|--------|-----------|------------------|
| 00 | [Overview & how to use these scripts](./00-tong-quan-va-lo-trinh.md) | 8' | Course map, conventions, mindset prep |
| 01 | [What is Hermes Agent & why use it](./01-hermes-agent-la-gi.md) | 10' | Agent vs chatbot, vs OpenClaw/Claude Code |
| 02 | [Architecture & the 5 core concepts](./02-kien-truc-va-5-khai-niem.md) | 12' | Memory · Skills · Soul · Crons · Self-improvement |
| 03 | [What is Honcho & why pair it with Hermes](./03-honcho-la-gi.md) | 14' | Peer/Session/Workspace, dialectic, representation |
| 04 | [Security & guardrails (read before you deploy)](./04-bao-mat-va-guardrails.md) | 10' | Prompt injection, cost, least-privilege, secrets |

### PART B — Deployment (build the system)
| # | Module | Duration | Core content |
|---|--------|-----------|------------------|
| 05 | [Prepare environment & accounts](./05-chuan-bi-moi-truong.md) | 10' | OpenAI key, GitHub, Railway, Telegram, Docker |
| 06 | [Path A — Deploy locally with Docker Compose](./06-trien-khai-local-docker.md) | 18' | 5 services, `docker compose up`, health checks |
| 07 | [Path B — Deploy to Railway (1-click + build your own template)](./07-trien-khai-railway.md) | 20' | One-click, 9-step self build, public domain |
| 08 | [First run & a tour of the Dashboard](./08-cau-hinh-lan-dau-va-dashboard.md) | 14' | Login, Config, iterations/compression/session |

### PART C — Honcho memory (the course's differentiator)
| # | Module | Duration | Core content |
|---|--------|-----------|------------------|
| 09 | [Verify that Honcho memory works](./09-kiem-chung-bo-nho-honcho.md) | 12' | Test cross-session memory, `hermes honcho status` |
| 10 | [Onboarding: User & Soul (the agent's persona)](./10-onboarding-user-va-soul.md) | 12' | user.md, soul.md, teach the agent to understand you |
| 16 | [Advanced Honcho — tuning & multi-agent](./16-honcho-nang-cao.md) | 16' | dialecticCadence/depth, recallMode, peers |

### PART D — Connections & automation (make it *useful*)
| # | Module | Duration | Core content |
|---|--------|-----------|------------------|
| 11 | [Connect Telegram](./11-ket-noi-telegram.md) | 12' | BotFather, restricting who can message, debug gateway |
| 12 | [Auto-backup to GitHub](./12-github-backup.md) | 10' | Fine-grained PAT, `hermes config set`, auto-commit |
| 13 | [Voice, images & browser automation](./13-voice-image-browser.md) | 10' | TTS/STT, reading images, installing a browser agent |
| 14 | [Connect real tools with Composio](./14-ket-noi-cong-cu-composio.md) | 14' | Gmail, Calendar, teach the agent to pick the right skill |
| 15 | [Scheduled tasks (Crons/Automations)](./15-tu-dong-hoa-cron.md) | 14' | Email triage, morning brief, security audit |

### PART E — Operations & mastery
| # | Module | Duration | Core content |
|---|--------|-----------|------------------|
| 17 | [Real-world use cases & the self-improvement loop](./17-use-cases-va-self-improvement.md) | 14' | Automated bookkeeping, habit tracker, daily wrap-up |
| 18 | [Operations, cost & troubleshooting](./18-van-hanh-chi-phi-troubleshooting.md) | 14' | Logs, token cost, common incidents |
| 19 | [Recap, exercises & resources](./19-tong-ket-bai-tap-tai-nguyen.md) | 8' | Graduation checklist, capstone, further reading |

> 💡 **Suggested order:** 00 → 05 in sequence. From module 06 onward pick **one** deployment path
> (A *or* B). Once the system is running (modules 08–09), Part D can be studied on demand, not
> necessarily in sequence.

### 🎁 Course companions
- **🌐 Visual table-of-contents page (HTML):** [`landing.html`](../landing.html) — open it in a browser
  to see all 20 lessons as cards, with light/dark theme and links to the content on GitHub.
- **🎙️ Word-for-word narration scripts (in Vietnamese):** [`../scripts-loi-thoai/`](../scripts-loi-thoai/) — VO
  read straight to camera for the opener ([`vo-00`](../scripts-loi-thoai/vo-00-tong-quan.md)) and the "wow
  moment" lesson ([`vo-09`](../scripts-loi-thoai/vo-09-wow-moment.md)), with timecodes &amp; on-screen cues.
- **🖼️ Images/media:** [`../assets/`](../assets/) — where screenshots live; run `grep -rn "【SCREENSHOT" .`
  to list every image that needs capturing.

---

## 🧾 Shared conventions used in every module

Every module file follows the same frame — learners just scan the headings to know where they are:

- **🎯 Outcomes after this lesson** — what you can do afterward (measurable).
- **🧭 Context / framing** — suggested talking track for the instructor.
- **🪜 Steps to perform** — screen actions + commands + talking track + screenshot cues `【SCREENSHOT】`.
- **⚠️ Common errors** — a symptom → cause → fix table.
- **✅ Learner checklist** — to self-verify you did it right.
- **🧠 Recap** and **➡️ Next up**.

Symbols:
- `【SCREENSHOT: ...】` = a spot where the instructor should capture/record the screen when making the video.
- `〔Say〕` = suggested line to read to camera.
- `> ⚠️` = an easy-to-get-wrong warning. `> 💡` = a tip.

---

## 🛠️ Source material & references

- Deployment repo (this course follows it closely): [`kalix-vn/hermes-agent-with-honcho`](https://github.com/kalix-vn/hermes-agent-with-honcho)
- Hermes Agent (NousResearch): <https://github.com/NousResearch/hermes-agent>
- Honcho (Plastic Labs): <https://github.com/plastic-labs/honcho> · <https://honcho.dev>
- Honcho integration docs in Hermes: [features/honcho.md](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md)
- Original reference video script (Tech with Tim): see [`../plan.md`](../plan.md)

> 📌 **Important note about the differences:** The original video (`plan.md`) builds Hermes on a **Hostinger VPS** and
> uses the default memory. This course builds Hermes **together with Honcho** on **Docker/Railway** (following the repo).
> So the *concept* part (Part A) reuses ideas from the video, but the *deployment* part
> (Parts B–C) follows **this actual repo** — details in each module.
