# Module 13 — Voice, images & browser automation

> **Duration:** ~10 minutes · **Level:** Intermediate
> **Goal:** Enable and test 3 multimodal capabilities: voice (TTS/STT), reading images, and browser
> automation (screenshot/read the web).
> **Prerequisites:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md)

## 🎯 What you'll have after this lesson
- Sending/receiving **voice messages** (speech-to-text & text-to-speech).
- Sending **images** to the agent (with a vision-capable model) and having it describe them.
- Installing the **agent browser** so the agent can screenshot + read web page content.

---

## 🧭 Context / setup

〔Say〕 "The agent doesn't just read/write text. It can hear (STT), speak (TTS), see images, and browse the
web. These three capabilities open up many real-world use cases."

---

## 🪜 Steps

### Step 1 — Test voice (STT + TTS)

**Action (Telegram is easiest):** send a **voice message**:
> (spoken) "Can you hear me? Repeat back what I just said."

Expected: the agent **transcribes** it correctly (STT). Then try:
> "Send me a voice message saying 'hello world'."

Expected: the agent returns **voice** (TTS).

〔Say〕 "With the default config, the agent already has basic TTS/STT (free). For a more natural voice you
can switch the TTS provider (e.g. ElevenLabs) in Config — not required."

`【SCREENSHOT: a voice message sent and the agent replying with voice】`

### Step 2 — Send an image to the agent (vision)

**Action:** attach an image (screenshot, invoice, chart…) and ask:
> "What's in this image? Summarize the main points."

> 💡 You need a **vision-capable model** (most modern models have this). If the agent says it can't see the
> image → switch to a vision-capable model in Config.

`【SCREENSHOT: the agent describing the image content】`

### Step 3 — Browser automation: try → usually FAILS the first time

**Action:** send:
> "Go to `example.com`, take a screenshot and tell me what's on the page."

〔Say〕 "The first time **usually errors** — something like 'Chrome/agent browser isn't installed'. This is
normal, not something you did wrong."

`【SCREENSHOT: the 'agent browser is not installed' error】`

### Step 4 — Install the agent browser then retry

**Action:** if the agent doesn't install it itself, instruct it:
> "Please **install the agent browser** then retry the screenshot task for that page."

After installing, the agent can screenshot and describe the content (hero, buttons, sections…).

`【SCREENSHOT: the agent screenshots & describes the web page after installing the browser】`

### Step 5 — Understand the 2 types of "web": Search vs Browser automation

| Type | What it does | Note |
|------|--------------|------|
| **Search** | Web search, retrieving information | Lightweight, enough for most needs |
| **Browser automation** | Drives a real browser: click, screenshot, render JS | Heavier; the local browser is *headless* (won't render complex JS) |

〔Say〕 "The local **headless** browser only pulls HTML, it won't render heavy JS. If you do **a lot** of
complex web-browsing tasks (bypass CAPTCHA, many tabs, multi-region), consider a paid service like
**Browserbase** or **Firecrawl** (~$20/month, with free credits). Otherwise the local browser is enough."

---

## ⚠️ Common problems
| Symptom | Cause | Fix |
|---------|-------|-----|
| "agent browser is not installed" | Browser runtime not installed | Instruct "install the agent browser" then retry |
| Agent can't read the image | Model has no vision | Switch to an image-capable model |
| JS-heavy page reads incomplete content | Local headless browser | Use Browserbase/Firecrawl |
| Voice doesn't work | TTS/STT provider misconfigured | Check Config; keep the free default for testing |

## ✅ Learner checklist
- [ ] Sent & received a voice message.
- [ ] The agent described the content of an image.
- [ ] Installed the agent browser and screenshotted/read a web page.
- [ ] Can distinguish Search vs Browser automation.

## 🧠 Summary
The agent listens, speaks, sees, and browses the web. Voice/images are nearly ready to go; browser
automation needs the **agent browser installed** the first time. For complex web, consider a paid service.
These capabilities are the foundation for real use cases in the next module.

## ➡️ Next
[Module 14 — Connect real tools with Composio](./14-ket-noi-cong-cu-composio.md)
