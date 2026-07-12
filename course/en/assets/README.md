# Course image/media folder

Place screenshots, diagrams, and illustrative GIFs here, then embed them in the modules.

## Naming convention
`m<NN>-<short-description>.png` — for example:
- `m06-docker-compose-ps.png`
- `m09-wow-moment-cross-session.png`
- `m11-telegram-botfather-token.png`

## How to embed in a module
```markdown
![Image description](./assets/m06-docker-compose-ps.png)
```

## List of images to capture
Every spot marked `【SCREENSHOT: ...】` in the modules is an image worth capturing while recording/authoring.
Quickly find all the spots that need a screenshot:
```bash
grep -rn "【SCREENSHOT" ..
```
