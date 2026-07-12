# Module 01 — What is Hermes Agent & why use it

> **Duration:** ~10 minutes · **Level:** Beginner
> **Goal:** Understand the essence of an "AI agent", distinguish it from a chatbot, and know when you *should/shouldn't* use Hermes.
> **Prerequisites:** [Module 00](./00-tong-quan-va-lo-trinh.md)

## 🎯 Outcomes after this lesson
- Be able to explain **how an agent differs from a chatbot** (it knows how to *act*, not just *answer*).
- Be able to state the **3 reasons** Hermes is popular (self-learning, runs 24/7, multi-LLM).
- Be able to self-assess **whether your use case fits Hermes**.

---

## 🧭 Context / framing

〔Say〕 "Picture Hermes Agent as a **personal AI assistant** running 24/7. It doesn't just answer
like ChatGPT — it **does work**: writes reports, researches, drafts emails, checks your calendar,
searches the web. And most importantly: **it learns about you as you use it**, so it fits you
better over time."

---

## 🪜 Lesson content

### 1. Chatbot vs Agent — the core difference

**Screen action:** draw/show a simple diagram.

```
CHATBOT:   you ask ──► LLM ──► an answer (then forgets)

AGENT:     you assign a task ──► LLM ──► pick a tool (web, code, email...)
                              ▲            │
                              └── observe the result, repeat until done
                                           │
                                    write to memory
```

〔Say〕 "A chatbot just *talks*. An agent *acts* — it has tools, it has memory, and it **loops
across many LLM calls** until it accomplishes the goal. That's the whole 'magic': a piece of
software wrapped around an LLM, managing context + tools + memory, then calling the LLM over and
over."

`【SCREENSHOT: chatbot vs agent diagram】`

### 2. At its core, Hermes is just software wrapped around an LLM

〔Say〕 "An LLM (GPT, Claude, Gemini…) can only do one thing: text in → text out. Hermes is the
software layer that **manages context** (the information fed into the LLM), **provides tools**
(browser, code…), and **manages memory/sessions**. It calls the LLM many times to reach a goal."

Emphasize: **the LLM is an outsourced brain** — you can swap OpenAI ↔ Anthropic ↔ Gemini ↔ a local
model and the agent still runs. (In this repo, OpenAI is the default for both chat and memory extraction.)

### 3. Why Hermes is popular — 3 strengths

1. **Self-learning loop.** This is what separates Hermes from frameworks like OpenClaw:
   Hermes **builds skills in the background** based on how you use it, without you having to ask.
   The more you use it, the better it gets. *(Details in [Module 02](./02-kien-truc-va-5-khai-niem.md).)*
2. **Runs 24/7, proactive.** Put it on a server → always on, can run scheduled tasks (cron)
   without you having to command it. *(Module 15.)*
3. **Multi-LLM.** Not locked into a single provider.

### 4. When should you NOT use Hermes?

> ⚠️ Say it plainly so learners pick the right tool:
- If you only need **a single, fixed automation** (e.g. "whenever a new form comes in, save it to a Sheet")
  → a simple workflow (Zapier/n8n) or a script will be cleaner.
- Hermes fits people who **converse frequently and assign many kinds of tasks**, who want an
  assistant that "lives" alongside them and understands them over time.

### 5. How is Hermes in this course different from the original?

〔Say〕 "The version out there online uses Hermes' default memory. This course adds **Honcho** — a
much deeper memory layer. We'll explore why, and what Honcho is, in Module 03."

---

## ⚠️ Common misconceptions
| Misconception | Reality |
|----------|---------|
| "An agent is smart out of the box, plug it in and it works perfectly" | No. It needs you to configure it, provide tools, and *teach* it over time. |
| "This is a self-hosted ChatGPT" | No. ChatGPT just chats; Hermes *acts* and *remembers*. |
| "More iterations is always better" | No. More iterations = more tokens/money. The default is enough. |
| "Self-learning means I don't have to teach it anything" | It learns *from how you use it*. The clearer you are, the better it learns. |

## ✅ Learner checklist
- [ ] Can distinguish chatbot vs agent in your own words.
- [ ] Can state the 3 strengths of Hermes.
- [ ] Can determine whether your personal use case fits Hermes.

## 🧠 Recap
Hermes = software wrapped around an LLM, providing tools + memory + a loop, so it can **act** rather
than just answer. It stands out for being **self-learning**, **running 24/7**, and being
**multi-LLM**. This course also adds Honcho for stronger memory.

## ➡️ Next up
[Module 02 — Architecture & the 5 core concepts](./02-kien-truc-va-5-khai-niem.md)
