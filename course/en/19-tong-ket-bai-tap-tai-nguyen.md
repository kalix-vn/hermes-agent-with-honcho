# Module 19 — Wrap-up, exercises & resources

> **Duration:** ~8 minutes · **Level:** All
> **Goal:** Tie together the whole journey, assign a "graduation" project, and point the way forward.
> **Prerequisites:** Completed parts A–D.

## 🎯 What you'll achieve
- Self-assess with the **graduation checklist**.
- Complete a **project** that combines many of the skills you've learned.
- Know the resources for going further.

---

## 🧭 Looking back over the whole journey

〔Say〕 "Congratulations! From zero, you now have a self-hosted AI assistant with real Honcho memory, chats
via Telegram, can touch Gmail/calendar, runs automated tasks, backs itself up and self-improves."

An overview of everything you've built:
```
You ──(Telegram/Dashboard)──► HERMES ──► tools: web, browser, Composio(Gmail/Calendar), cron
                                 │
                                 ├──► HONCHO (API + Deriver) ──► Postgres(pgvector) + Redis
                                 │        └─ remembers you across sessions, models you, dialectic
                                 └──► GitHub backup (auto-commit, version rollback)
```

---

## ✅ "Graduation" checklist

**Foundations & security**
- [ ] Can explain Hermes vs Honcho, and the 5 core concepts.
- [ ] Never paste secrets into chat; expose only Hermes.

**Deployment**
- [ ] Built the system (Docker *or* Railway) with 5 healthy services.
- [ ] Dashboard has login; the deriver has no HTTP healthcheck.

**Honcho memory**
- [ ] Demonstrated cross-session memory (the wow moment).
- [ ] Tuned ≥1 Honcho knob (cadence/mode/strategy).

**Connections & automation**
- [ ] Telegram works, with an allowlist.
- [ ] GitHub backup runs automatically.
- [ ] Connected Composio (Gmail/Calendar) and did real work.
- [ ] Have ≥2 useful crons.

**Operations**
- [ ] Know how to view logs, control cost, troubleshoot, and the emergency procedure.

> 🎓 Got them all = you've mastered the Hermes + Honcho system.

---

## 📝 Capstone project (pick 1)

### Project 1 — A complete "morning assistant"
Build a **7 AM morning brief** cron that combines: important emails from the last 24 hours + today's
calendar + top 3 things to do. Requirements: use Composio, a format you define, and go through **2 feedback
rounds** so the agent self-improves its length/content. **Submit:** screenshots of the day-1 vs day-3 brief
(showing the improvement) + `cron/jobs.json`.

### Project 2 — A "personalized tutor"
A nightly language-learning cron: teach 5 words + quiz on yesterday's words, and **have Honcho remember**
the words you often get wrong so it can repeat them. **Submit:** proof that a new session remembers your
level/frequently-missed words correctly (a Module 09-style test).

### Project 3 — A "multi-user family bot"
Let 2 people message the bot via Telegram, configure **peer mapping** (Module 16) so Honcho **doesn't mix
profiles**. **Submit:** proof that each person is answered according to their own profile.

---

## 📚 Resources for going further

- **Course repo:** [`Avanix-AI/hermes-agent-with-honcho`](https://github.com/Avanix-AI/hermes-agent-with-honcho) — read `README.md`, `docker-compose.yml`, `hermes/`, `honcho/`.
- **Hermes Agent:** <https://github.com/NousResearch/hermes-agent>
- **Honcho integration docs (Hermes):** [features/honcho.md](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md)
- **Honcho (Plastic Labs):** <https://github.com/plastic-labs/honcho> · <https://honcho.dev>
- **Composio:** <https://app.composio.dev>
- **Railway:** <https://railway.com>
- **Original video script (for context reference):** [`../plan.md`](../plan.md)

### Suggested extensions
- Add a **Slack** channel (good for work) alongside Telegram.
- Use **multi-model**: a cheap model for light tasks, a strong model for deep reasoning.
- Connect **Notion/Drive/Sheets** for more complex workflows.
- Enable **Honcho auth (JWT)** if you need to expose the API to external clients.
- Upgrade the browser to **Browserbase/Firecrawl** when doing lots of web automation.

---

## 🧠 Closing words

〔Say〕 "This isn't magic. But set up right, it saves you hours every week and understands you better and
better thanks to Honcho. The real power lies in you **inventing your own use cases** and then just using
it and giving feedback. Happy building your awesome assistant!"

## ➡️ Back
[Course table of contents](./README.md)
