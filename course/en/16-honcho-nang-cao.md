# Module 16 — Advanced Honcho: tuning & multi-agent

> **Duration:** ~16 minutes · **Level:** Advanced
> **Goal:** Master Honcho's "knobs" to balance **cost ↔ reasoning depth**, choose a session/recall
> strategy, and configure multi-user/multi-agent setups (peers).
> **Prerequisites:** [Module 09](./09-kiem-chung-bo-nho-honcho.md)

## 🎯 What you'll achieve
- Understand the 3 core knobs: **contextCadence · dialecticCadence · dialecticDepth**.
- Choose your **recallMode**, **sessionStrategy**, **observationMode**, and token budget.
- Configure **peer mapping** for a multi-user gateway (Telegram/Slack).

---

## 🧭 Context / lead-in

〔Say〕 "Honcho's defaults are already good. But as you use it more, you'll want to balance: deeper
reasoning (smarter, more expensive) versus cheaper. And if multiple people message the agent, you'll
need to separate their profiles. This module gives you the knobs to take control."

> 📌 See the full reference in [Hermes's Honcho documentation](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md).
> Adjust via `hermes honcho ...` (shell) or the corresponding memory config section.

---

## 🪜 Lesson content

### 1. Three core knobs: cadence & depth (cost ↔ depth)

| Knob | Function | Default | Increasing it means |
|------|----------|:-------:|---------------------|
| `contextCadence` | How many chat turns before calling the API to fetch context once | `1` | Fewer calls → cheaper, "staler" context |
| `dialecticCadence` | How many turns before running LLM reasoning once | `2` | Sparser reasoning → cheaper, slower updates |
| `dialecticDepth` | Number of multi-pass reasoning rounds | `1` | Deeper → smarter, more expensive |

〔Say〕 "To **save money**: increase `dialecticCadence`, keep `dialecticDepth=1`. To be **maximally smart**
for an important use case: increase `dialecticDepth` and `dialecticReasoningLevel`."

### 2. Reasoning depth & token budget

| Knob | Default | Meaning |
|------|:-------:|---------|
| `dialecticReasoningLevel` | `low` | Base reasoning level: `minimal/low/medium/high/max` |
| `contextTokens` | `null` (unlimited) | Token budget for the injected context |
| `dialecticMaxChars` | `600` | Max characters of insight inserted into the system prompt |
| `messageMaxChars` | `25000` | Max characters per message sent to the API |

〔Say〕 "A small `dialecticMaxChars` (600) keeps the system prompt lean — concise insights. Increase it
if you want the agent to 'absorb' more context, but watch out for prompt bloat."

**Related commands:**
```bash
hermes honcho tokens      # view/set token budget
hermes honcho mode        # view/set recall mode
```

### 3. recallMode — how memory is fed into the agent

| Value | Meaning |
|-------|---------|
| `hybrid` (default) | Both **inject** context upfront and let the agent **call tools** when needed |
| `context` (inject-only) | Only inject context, no tool use |
| `tools` (tools-only) | No upfront injection; the agent calls tools itself when needed |

〔Say〕 "`hybrid` is the most balanced for beginners. `tools-only` saves tokens (only queries when needed)
but the agent has to be more proactive."

```bash
hermes honcho mode hybrid   # example: set it
```

### 4. sessionStrategy — what a session maps to

| Value | Meaning |
|-------|---------|
| `per-directory` (default) | Each working directory = 1 session |
| `per-repo` | Each repo = 1 session |
| `per-session` | Each session kept separate |
| `global` | One continuous session throughout |

```bash
hermes honcho strategy       # view/set
hermes honcho sessions       # list the current session mappings
```
〔Say〕 "For a life assistant (chatting via Telegram), `global` or `per-session` usually fits better than
`per-directory` (which suits a coding assistant)."

### 5. observationMode — observing peers

| Value | Meaning |
|-------|---------|
| `directional` (default) | **Directional** observation: A observing B is separate from B observing A |
| `unified` | Merged observation |

〔Say〕 "Directional helps separate 'what Honcho knows about you' and 'what it knows about the agent' —
important in multi-agent setups."

### 6. Multi-agent / multi-user: peer mapping

When deploying a gateway (Telegram/Slack) where **multiple people** message the same agent, you need to
map identities:

| Config | Function |
|--------|----------|
| `pinUserPeer` | `true` → merge all users (not the agent) into **one** peer |
| `userPeerAliases` | Map runtime ID → peer name, e.g. `{"7654321": "alice"}` |
| `runtimePeerPrefix` | Set a namespace for unknown IDs, e.g. `telegram_7654321` |

〔Say〕 "Example: a whole family shares one bot. You do NOT want Honcho to mix up dad's profile with your
sibling's. Use `userPeerAliases` so each Telegram ID maps to its own peer → each person has their own
model, with no context bleed."

**Related commands:**
```bash
hermes honcho peer           # view/update peer name
hermes honcho identity       # seed identity for the AI peer
hermes honcho status         # check the entire config after adjusting
```

`【SCREENSHOT: 'hermes honcho status' showing cadence/mode/strategy/peers after tuning】`

### 7. Self-hosted Honcho: base URL & JWT

Because this repo **self-hosts** Honcho, when the setup wizard asks:
- **Base URL** → `HONCHO_BASE_URL` (internal Docker/Railway).
- **JWT bearer token** (optional) → only needed when `AUTH_USE_AUTH=true` is enabled (signed with the
  server's `AUTH_JWT_SECRET`). The local token is stored at `hosts.<host>.apiKey` in `honcho.json`,
  separate from cloud credentials.

> 💡 Learning/local: leave `AUTH_USE_AUTH=false` for simplicity. Production/exposed: enable auth + JWT.

---

## ⚠️ Common issues
| Symptom | Cause | Fix |
|---------|-------|-----|
| LLM cost spikes | `dialecticDepth`/`ReasoningLevel` too high | Lower to `1`/`low`; increase `dialecticCadence` |
| Multiple people's profiles get mixed | Peer mapping not configured | Use `userPeerAliases`/`runtimePeerPrefix` |
| Injected insight too long / overflows prompt | `dialecticMaxChars` too large | Reduce to ~600 |
| Config changes don't take effect | Not reloaded/redeployed | Re-run `hermes honcho status`; redeploy if changed via env |

## ✅ Student checklist
- [ ] Can explain cadence vs depth and their cost impact.
- [ ] Chose a recallMode + sessionStrategy that fits your use case.
- [ ] (If multi-user) configured peer mapping to separate profiles.
- [ ] Verified with `hermes honcho status`.

## 🧠 Summary
Cadence/Depth = the cost↔intelligence lever. recallMode/sessionStrategy/observationMode = how memory is
remembered and mapped. Peer mapping = separating profiles for multi-user/multi-agent. This is the layer
where you truly master Honcho.

## ➡️ Next
[Module 17 — Real-world use cases & the self-improvement loop](./17-use-cases-va-self-improvement.md)
