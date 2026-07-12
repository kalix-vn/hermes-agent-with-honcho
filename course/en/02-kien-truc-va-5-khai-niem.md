# Module 02 — Architecture & the 5 core concepts

> **Duration:** ~12 minutes · **Level:** Beginner
> **Goal:** Grasp the 5 foundational concepts of Hermes so that every later action makes sense — you'll always know "why".
> **Prerequisites:** [Module 01](./01-hermes-agent-la-gi.md)

## 🎯 Outcomes after this lesson
- Name and explain the **5 concepts**: Memory · Skills · Soul · Crons · Self-improvement.
- Understand the **directory structure** of a Hermes agent and the meaning of the important files.
- Understand **progressive disclosure** — why Hermes saves tokens.

---

## 🧭 Context / framing

〔Say〕 "Before we build, we need to understand the 5 pieces that make up Hermes. Once you get
these 5, every later action will make sense — you'll always know what you're adjusting and why."

**Screen action:** show the diagram of the 5 concepts.

```
        ┌──────────────────────── HERMES AGENT ────────────────────────┐
        │  ① MEMORY     ② SKILLS     ③ SOUL     ④ CRONS   ⑤ SELF-IMPROVE │
        │  (remembers)  (abilities) (personality)(scheduled)(self-upgrade)│
        └───────────────────────────────┬──────────────────────────────┘
                                         ▼
                                   LLM (the brain)
```

---

## 🪜 Lesson content

### ① Memory

When you install Hermes, you get a **directory structure** with markdown files, config, environment
variables, and a `memory/` folder. The two most important files:

| File | Contains |
|------|---------|
| `user.md` | Information about **you**: name, age, location, interests, the style you want |
| `memory.md` | **Long-term facts** the agent should always remember when talking with you |

〔Say〕 "You **don't need to edit** these files yourself — Hermes updates them automatically. But
knowing they exist helps you understand the 'behind the scenes'."

> 📌 **The key point of this course:** In stock Hermes, memory is local `.md` files. In this course
> we **replace/augment** it with **Honcho** — a far more powerful memory layer: it doesn't just
> store text but also *reasons* and *models* you. Details in [Module 03](./03-honcho-la-gi.md).

### ② Skills

**A skill = a markdown file** describing: *what the skill is*, *when to use it*, and *the steps to perform*.

〔Say〕 "Instead of you rewriting the 5 steps of 'how to check email' every time, we have an
*email skill* ready to go. You say 'check email', the agent looks up the skill and follows it —
consistent and predictable."

- Hermes has **~90 built-in skills** + **500+ community skills** + you can **create your own**.
- **Progressive disclosure:** at startup, the agent only loads the **name + description** of each
  skill, **not the full content**. Only when a skill is actually needed does it load that skill in full.

〔Say〕 "This way the agent doesn't have to cram hundreds of thousands of characters into every
run → **saves tokens, saves money**."

`【SCREENSHOT: example of a skill .md file with the 'when to use' + 'steps' sections】`

### ③ Soul — personality / persona

**A soul = a markdown file describing how the agent behaves**: serious or friendly, uses emoji or
not, how it addresses you, what tone it uses.

〔Say〕 "You **don't need to write** this file yourself. Just say 'adjust your soul to always be
concise, direct, and educational' — the agent updates it itself." *(We'll practice this in [Module 10](./10-onboarding-user-va-soul.md).)*

### ④ Crons — scheduled tasks (automations)

〔Say〕 "This is where Hermes starts to become truly useful. You schedule it to do work on a
timetable: every morning send an email summary, every evening remind you to take your medicine,
every Sunday run a security audit…"

- **A reactive agent** = waits for you to command it.
- **A proactive agent** = runs in the background on a schedule. Crons turn Hermes proactive.

*(Practice in [Module 15](./15-tu-dong-hoa-cron.md).)*

### ⑤ Self-improvement loop

〔Say〕 "This is the most important point, what sets Hermes apart from OpenClaw. As you work, the
agent learns about you, saves it to memory, and **builds new skills in the background** — without
you asking. Repeat a task a few times and it creates a skill to remember *how you like it done*."

> 💡 In this course, that loop is **amplified by Honcho**: Honcho runs a background 'deriver' to
> continuously update its understanding of you after every conversation turn.

---

## ⚠️ Common errors/misconceptions
| Misconception | Reality |
|----------|---------|
| "I have to write user.md/soul.md/skills by hand" | No — say it in words, the agent creates/updates them. |
| "Enabling many skills always makes the agent slow/expensive" | No — progressive disclosure only loads a skill when needed. |
| "Crons can only run daily" | No — hourly/weekly/monthly/any expression works. |

## ✅ Learner checklist
- [ ] Can name the 5 concepts and give a one-line description of each.
- [ ] Can explain progressive disclosure.
- [ ] Understand the roles of `user.md` and `memory.md` (and know Honcho will replace/upgrade this area).

## 🧠 Recap
5 pieces: **Memory** (remember) · **Skills** (abilities, loaded on demand) · **Soul** (personality) ·
**Crons** (scheduled) · **Self-improvement** (self-upgrade). All are just files managed around the
LLM. This course upgrades the "Memory" piece with Honcho.

## ➡️ Next up
[Module 03 — What is Honcho & why pair it with Hermes](./03-honcho-la-gi.md)
