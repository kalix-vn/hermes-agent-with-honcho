<p align="center">
  <h1 align="center">🧠 Hermes Agent + Honcho Memory</h1>
  <p align="center">
    <strong>AI Agent with persistent, dialectic memory — Deploy to Railway in one click</strong>
  </p>
</p>

<p align="center">
  <a href="https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c&utm_medium=integration&utm_source=template&utm_campaign=generic">
    <img src="https://railway.com/button.svg" alt="Deploy on Railway" />
  </a>
</p>

<p align="center">
  <b>🇬🇧 <a href="#english">English</a></b>
  &nbsp;·&nbsp;
  <b>🇻🇳 <a href="#tieng-viet">Tiếng Việt</a></b>
</p>

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Railway Project                       │
│                                                         │
│  ┌──────────────┐     ┌──────────────┐                  │
│  │ Hermes Agent │────▶│  Honcho API  │                  │
│  │ (Web Dashbd) │     │  (Memory)    │                  │
│  └──────────────┘     └──────┬───────┘                  │
│        :3000                 │                          │
│                        ┌─────┴─────┐                    │
│                        ▼           ▼                    │
│                 ┌──────────┐ ┌──────────┐               │
│                 │ PostgreSQL│ │  Redis   │               │
│                 │ (pgvector)│ │ (cache)  │               │
│                 └──────────┘ └──────────┘               │
│                        ▲                                │
│                        │                                │
│                 ┌──────────────┐                        │
│                 │   Deriver    │                        │
│                 │  (bg worker) │                        │
│                 └──────────────┘                        │
└─────────────────────────────────────────────────────────┘
```

| Service | Description | Source |
|---------|-------------|--------|
| **hermes-agent** | Web dashboard chat interface | [NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent) |
| **honcho-api** | Honcho memory API server | [plastic-labs/honcho](https://github.com/plastic-labs/honcho) |
| **honcho-deriver** | Background worker for memory extraction | [plastic-labs/honcho](https://github.com/plastic-labs/honcho) |
| **PostgreSQL** | Database with pgvector | Railway managed |
| **Redis** | Cache layer | Railway managed |

---

<a id="english"></a>

## 🇬🇧 English

### What is this?

This template deploys [Hermes Agent](https://github.com/NousResearch/hermes-agent) (by NousResearch) together with [Honcho](https://github.com/plastic-labs/honcho) (by Plastic Labs) as a self-hosted memory backend, all on [Railway](https://railway.com).

- **Hermes Agent** is an AI agent that grows with you — it learns your preferences, communication style, and goals over time, and exposes a web dashboard for chatting and managing config.
- **Honcho** provides the memory layer — dialectic reasoning, multi-agent user modeling, and deep personalization that goes beyond simple key-value storage.

The Hermes service is built **on top of the official `nousresearch/hermes-agent` image** (which already ships the pre-built dashboard), then launched with `hermes dashboard`. The Honcho services are built from upstream source.

### 🚀 Deploy to Railway (one click)

Click the **Deploy on Railway** button above, or open:

```
https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c
```

You'll be prompted for:
- `LLM_OPENAI_API_KEY` — your OpenAI API key (**required**). It is reused by every service, so you only enter it once.
- A dashboard username & password (see the note below).

> ⚠️ **The dashboard requires a login.** Since the June 2026 security hardening, any public (non-loopback) bind of the Hermes dashboard **must** have an auth provider — the old `--insecure` bypass is now a no-op. Set `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` and `HERMES_DASHBOARD_BASIC_AUTH_PASSWORD` on the `hermes` service or you will not be able to open the dashboard.

### 🛠️ Local development

**Prerequisites:** [Docker](https://docs.docker.com/get-docker/) with Docker Compose, and an OpenAI API key.

```bash
# 1. Clone
git clone https://github.com/kalix-vn/hermes-agent-with-honcho.git
cd hermes-agent-with-honcho

# 2. Configure (at minimum set OPENAI_API_KEY)
cp .env.example .env

# 3. Build & start everything
docker compose up -d --build

# 4. Check status / logs
docker compose ps
docker compose logs -f
```

| Service | URL | Notes |
|---------|-----|-------|
| Hermes dashboard | http://localhost:3000 | Login: `admin` / `hermes-local` (override via `HERMES_DASHBOARD_USERNAME` / `HERMES_DASHBOARD_PASSWORD` in `.env`) |
| Honcho API | http://localhost:8000 | Memory API |
| Honcho health | http://localhost:8000/health | Should return `200` |

Stop:

```bash
docker compose down       # stop, keep data
docker compose down -v    # stop and delete all data
```

> **Real chat needs a real key.** With a placeholder `OPENAI_API_KEY`, all services still boot and the dashboard serves — but actual chat and memory extraction only work once you set a valid key (in `.env` or from the dashboard's Config page).

### 📋 Railway template setup (build the template yourself)

<details>
<summary>Click to expand the full 9-step walkthrough</summary>

#### Step 1 — Create a template
Go to [railway.com](https://railway.com) → **Account Settings → Templates → Create Template**, name it `Hermes Agent + Honcho Memory`.

#### Step 2 — Add PostgreSQL
**+ Add Service → Database → PostgreSQL**. Railway's Postgres supports `pgvector` out of the box.

#### Step 3 — Add Redis
**+ Add Service → Database → Redis**.

#### Step 4 — Add the Honcho API service
**+ Add Service → GitHub Repo** → this repo. In the service settings set **Root Directory = `honcho`** (Railway auto-detects the `Dockerfile`). Environment variables:

```bash
HONCHO_MODE=api
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true
AUTH_USE_AUTH=false
LLM_OPENAI_API_KEY=        # REQUIRED — mark as required at publish time
```

> **Database URL:** Honcho (SQLAlchemy) requires the `postgresql+psycopg://` driver prefix, but Railway's `DATABASE_URL` is a bare `postgresql://`. The entrypoint rewrites the scheme automatically, so `${{Postgres.DATABASE_URL}}` works as-is. It also falls back to `DATABASE_URL` / `REDIS_URL` if `DB_CONNECTION_URI` / `CACHE_URL` are unset.

Optionally set **Healthcheck Path = `/health`** for this service (Settings → Deploy).

#### Step 5 — Add the Honcho Deriver service
**+ Add Service → GitHub Repo** → this repo, **Root Directory = `honcho`**. Environment variables:

```bash
HONCHO_MODE=deriver
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true
AUTH_USE_AUTH=false
LLM_OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}
```

> **Healthcheck:** The deriver is a background worker with **no HTTP server** — leave its **Healthcheck Path empty**. An HTTP healthcheck would never pass and would fail the deploy.

#### Step 6 — Add the Hermes Agent service
**+ Add Service → GitHub Repo** → this repo, **Root Directory = `hermes`**. Under **Settings → Networking**, click **Generate Domain** to expose the dashboard. Environment variables:

```bash
# Honcho connection (internal Railway networking)
HONCHO_BASE_URL=http://${{honcho-api.RAILWAY_PRIVATE_DOMAIN}}:8000

# LLM key (reused from honcho-api, so it's entered only once)
OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}

# Dashboard auth — REQUIRED for the public domain
HERMES_DASHBOARD_BASIC_AUTH_USERNAME=admin
HERMES_DASHBOARD_BASIC_AUTH_PASSWORD=<choose-a-strong-password>
HERMES_DASHBOARD_BASIC_AUTH_SECRET=<random-32-byte-secret>   # keeps sessions valid across restarts
```

#### Step 7 — Custom LLM base URL (optional)
To use an OpenAI-compatible provider (OpenRouter, DeepSeek, Together AI, local vLLM…) instead of `https://api.openai.com/v1`:
- **Hermes:** set `OPENAI_BASE_URL` (e.g. `https://openrouter.ai/api/v1`).
- **Honcho (api + deriver):** set `DERIVER_MODEL_CONFIG__OVERRIDES__BASE_URL`, `EMBEDDING_MODEL_CONFIG__OVERRIDES__BASE_URL`, and `EMBEDDING_MODEL_CONFIG__MODEL` (e.g. `text-embedding-3-small`).

#### Step 8 — Publish
Mark **`LLM_OPENAI_API_KEY`** (on `honcho-api`) as **Required**. Because the other services reference `${{honcho-api.LLM_OPENAI_API_KEY}}`, the deployer enters the key only once. Click **Publish Template**.

#### Step 9 — Add the deploy button
```markdown
[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c)
```

</details>

### 🌐 Public access (expose to the internet)

By default every Railway service is only reachable on the project's **private network**. To let people open the Hermes dashboard from a browser, give the **`hermes`** service a public URL:

1. Open the **hermes** service → **Settings → Networking**.
2. Under **Public Networking**, click **Generate Domain**. Railway creates a free `https://<name>.up.railway.app` address with HTTPS handled for you.
3. If asked for a port, enter **`3000`** (the dashboard's `PORT`). Railway routes external `:443` → your container's `:3000`.
4. Open the generated URL and log in with your `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` / `PASSWORD`.

**Custom domain:** in the same panel pick **Custom Domain**, enter e.g. `chat.yourdomain.com`, then add the **CNAME** record it shows you at your DNS provider. Railway issues the TLS certificate automatically.

> 🔒 **Only expose Hermes.** Do **not** generate a domain for `honcho-api`, `honcho-deriver`, Postgres, or Redis. Hermes reaches Honcho over the **private** network (`${{honcho-api.RAILWAY_PRIVATE_DOMAIN}}`), so the memory API and databases should stay internal. If you genuinely need the Honcho API public (e.g. external SDK clients), generate its domain on port `8000` **and** enable `AUTH_USE_AUTH=true` with JWT keys first.

> ⚠️ **Public = a login is mandatory.** A public domain makes the dashboard reachable by anyone on the internet, so the `HERMES_DASHBOARD_BASIC_AUTH_*` credentials must be set (see the deploy note above).

### 🔧 Configuration — environment variables

| Variable | Required | Service | Description |
|----------|:---:|---------|-------------|
| `LLM_OPENAI_API_KEY` | ✅ | honcho | OpenAI API key for memory extraction (reused everywhere) |
| `OPENAI_API_KEY` | ✅ | hermes | OpenAI API key for chat |
| `HONCHO_BASE_URL` | ✅ | hermes | URL of the Honcho API service |
| `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` | ✅ | hermes | Dashboard login username (required on a public bind) |
| `HERMES_DASHBOARD_BASIC_AUTH_PASSWORD` | ✅ | hermes | Dashboard login password (required on a public bind) |
| `HERMES_DASHBOARD_BASIC_AUTH_SECRET` | ❌ | hermes | 32+ byte secret to keep sessions valid across restarts |
| `DB_CONNECTION_URI` | ✅ | honcho | Postgres URL (scheme auto-normalized to `postgresql+psycopg://`) |
| `CACHE_URL` | ✅ | honcho | Redis URL |
| `OPENAI_BASE_URL` | ❌ | hermes | Custom OpenAI-compatible endpoint |
| `ANTHROPIC_API_KEY` | ❌ | both | Anthropic API key |
| `GOOGLE_API_KEY` | ❌ | both | Google Gemini API key |
| `AUTH_USE_AUTH` | ❌ | honcho | Enable Honcho JWT auth (default: `false`) |
| `LOG_LEVEL` | ❌ | honcho | `DEBUG` / `INFO` / `WARNING` / `ERROR` |

### 🧠 How memory works

Once deployed, Hermes uses Honcho for:
- **Cross-session persistence** — memory survives container restarts.
- **Dialectic reasoning** — Honcho analyzes conversations and derives insights.
- **User modeling** — learns preferences, habits, and goals over time.
- **Session summaries** — context injection for continuity.

See the [Honcho feature docs](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md).

---

<a id="tieng-viet"></a>

## 🇻🇳 Tiếng Việt

### Đây là gì?

Template này triển khai [Hermes Agent](https://github.com/NousResearch/hermes-agent) (của NousResearch) cùng với [Honcho](https://github.com/plastic-labs/honcho) (của Plastic Labs) làm bộ nhớ tự lưu trữ, tất cả chạy trên [Railway](https://railway.com).

- **Hermes Agent** là một AI agent “lớn lên” cùng bạn — học sở thích, phong cách giao tiếp và mục tiêu của bạn theo thời gian, đồng thời cung cấp một **web dashboard** để chat và quản lý cấu hình.
- **Honcho** là tầng bộ nhớ — suy luận biện chứng (dialectic), mô hình hóa người dùng đa tác tử, cá nhân hóa sâu vượt xa kiểu lưu key-value đơn giản.

Service Hermes được build **trên nền image chính thức `nousresearch/hermes-agent`** (đã có sẵn dashboard build sẵn), rồi khởi động bằng `hermes dashboard`. Các service Honcho được build từ mã nguồn upstream.

### 🚀 Triển khai lên Railway (một cú click)

Bấm nút **Deploy on Railway** ở trên, hoặc mở:

```
https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c
```

Bạn sẽ được yêu cầu nhập:
- `LLM_OPENAI_API_KEY` — OpenAI API key của bạn (**bắt buộc**). Key này được dùng lại cho mọi service nên bạn chỉ phải nhập **một lần**.
- Tên đăng nhập & mật khẩu cho dashboard (xem lưu ý bên dưới).

> ⚠️ **Dashboard bắt buộc phải đăng nhập.** Từ đợt siết bảo mật 6/2026, mọi lần bind công khai (không phải loopback) của dashboard Hermes **bắt buộc** phải có cơ chế xác thực — cờ `--insecure` cũ nay đã vô hiệu. Hãy đặt `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` và `HERMES_DASHBOARD_BASIC_AUTH_PASSWORD` cho service `hermes`, nếu không bạn sẽ không mở được dashboard.

### 🛠️ Chạy thử ở máy local

**Yêu cầu:** [Docker](https://docs.docker.com/get-docker/) kèm Docker Compose, và một OpenAI API key.

```bash
# 1. Clone
git clone https://github.com/kalix-vn/hermes-agent-with-honcho.git
cd hermes-agent-with-honcho

# 2. Cấu hình (tối thiểu đặt OPENAI_API_KEY)
cp .env.example .env

# 3. Build & khởi động tất cả
docker compose up -d --build

# 4. Kiểm tra trạng thái / log
docker compose ps
docker compose logs -f
```

| Service | URL | Ghi chú |
|---------|-----|---------|
| Hermes dashboard | http://localhost:3000 | Đăng nhập: `admin` / `hermes-local` (đổi qua `HERMES_DASHBOARD_USERNAME` / `HERMES_DASHBOARD_PASSWORD` trong `.env`) |
| Honcho API | http://localhost:8000 | API bộ nhớ |
| Honcho health | http://localhost:8000/health | Trả về `200` là đạt |

Dừng lại:

```bash
docker compose down       # dừng, giữ dữ liệu
docker compose down -v    # dừng và xóa toàn bộ dữ liệu
```

> **Chat thật cần key thật.** Với `OPENAI_API_KEY` giả, mọi service vẫn khởi động và dashboard vẫn phục vụ — nhưng chat và trích xuất bộ nhớ chỉ hoạt động khi bạn đặt key hợp lệ (trong `.env` hoặc ở trang Config của dashboard).

### 📋 Tự tạo Railway Template

<details>
<summary>Bấm để mở hướng dẫn đầy đủ 9 bước</summary>

#### Bước 1 — Tạo template
Vào [railway.com](https://railway.com) → **Account Settings → Templates → Create Template**, đặt tên `Hermes Agent + Honcho Memory`.

#### Bước 2 — Thêm PostgreSQL
**+ Add Service → Database → PostgreSQL**. Postgres của Railway hỗ trợ sẵn `pgvector`.

#### Bước 3 — Thêm Redis
**+ Add Service → Database → Redis**.

#### Bước 4 — Thêm service Honcho API
**+ Add Service → GitHub Repo** → chọn repo này. Trong cài đặt service, đặt **Root Directory = `honcho`** (Railway tự nhận `Dockerfile`). Biến môi trường:

```bash
HONCHO_MODE=api
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true
AUTH_USE_AUTH=false
LLM_OPENAI_API_KEY=        # BẮT BUỘC — đánh dấu required khi publish
```

> **Về database URL:** Honcho (SQLAlchemy) yêu cầu prefix `postgresql+psycopg://`, nhưng `DATABASE_URL` của Railway lại là `postgresql://` thuần. Entrypoint tự động ghi lại scheme nên dán `${{Postgres.DATABASE_URL}}` là chạy được. Nó cũng tự fallback về `DATABASE_URL` / `REDIS_URL` nếu `DB_CONNECTION_URI` / `CACHE_URL` bị bỏ trống.

Tùy chọn: đặt **Healthcheck Path = `/health`** cho service này (Settings → Deploy).

#### Bước 5 — Thêm service Honcho Deriver
**+ Add Service → GitHub Repo** → repo này, **Root Directory = `honcho`**. Biến môi trường:

```bash
HONCHO_MODE=deriver
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true
AUTH_USE_AUTH=false
LLM_OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}
```

> **Healthcheck:** Deriver là worker chạy nền, **không có HTTP server** — hãy **để trống Healthcheck Path**. Nếu đặt healthcheck HTTP, nó sẽ không bao giờ pass và làm deploy thất bại.

#### Bước 6 — Thêm service Hermes Agent
**+ Add Service → GitHub Repo** → repo này, **Root Directory = `hermes`**. Vào **Settings → Networking**, bấm **Generate Domain** để mở dashboard ra ngoài. Biến môi trường:

```bash
# Kết nối Honcho (mạng nội bộ Railway)
HONCHO_BASE_URL=http://${{honcho-api.RAILWAY_PRIVATE_DOMAIN}}:8000

# Key LLM (dùng lại từ honcho-api nên chỉ nhập một lần)
OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}

# Xác thực dashboard — BẮT BUỘC cho domain công khai
HERMES_DASHBOARD_BASIC_AUTH_USERNAME=admin
HERMES_DASHBOARD_BASIC_AUTH_PASSWORD=<mật-khẩu-mạnh>
HERMES_DASHBOARD_BASIC_AUTH_SECRET=<chuỗi-bí-mật-32-byte>   # giữ phiên đăng nhập qua các lần restart
```

#### Bước 7 — Dùng LLM base URL tùy chỉnh (tùy chọn)
Muốn dùng nhà cung cấp tương thích OpenAI (OpenRouter, DeepSeek, Together AI, vLLM local…) thay cho `https://api.openai.com/v1`:
- **Hermes:** đặt `OPENAI_BASE_URL` (vd. `https://openrouter.ai/api/v1`).
- **Honcho (api + deriver):** đặt `DERIVER_MODEL_CONFIG__OVERRIDES__BASE_URL`, `EMBEDDING_MODEL_CONFIG__OVERRIDES__BASE_URL`, và `EMBEDDING_MODEL_CONFIG__MODEL` (vd. `text-embedding-3-small`).

#### Bước 8 — Publish
Đánh dấu **`LLM_OPENAI_API_KEY`** (trên `honcho-api`) là **Required**. Vì các service khác tham chiếu `${{honcho-api.LLM_OPENAI_API_KEY}}`, người deploy chỉ phải nhập key một lần. Bấm **Publish Template**.

#### Bước 9 — Thêm nút deploy
```markdown
[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c)
```

</details>

### 🌐 Mở ra Internet (public access)

Mặc định mọi service trên Railway chỉ truy cập được trong **mạng nội bộ** của project. Muốn người dùng mở dashboard Hermes từ trình duyệt, hãy cấp cho service **`hermes`** một URL công khai:

1. Mở service **hermes** → **Settings → Networking**.
2. Ở mục **Public Networking**, bấm **Generate Domain**. Railway tạo miễn phí một địa chỉ `https://<tên>.up.railway.app`, tự lo HTTPS luôn.
3. Nếu bị hỏi cổng, nhập **`3000`** (chính là `PORT` của dashboard). Railway sẽ route `:443` bên ngoài → `:3000` trong container.
4. Mở URL vừa tạo và đăng nhập bằng `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` / `PASSWORD` của bạn.

**Domain riêng:** cũng ở panel đó chọn **Custom Domain**, nhập ví dụ `chat.tenmien.com`, rồi thêm bản ghi **CNAME** mà Railway hiển thị vào nhà cung cấp DNS của bạn. Railway tự cấp chứng chỉ TLS.

> 🔒 **Chỉ mở mỗi Hermes.** **Đừng** Generate Domain cho `honcho-api`, `honcho-deriver`, Postgres hay Redis. Hermes gọi Honcho qua **mạng nội bộ** (`${{honcho-api.RAILWAY_PRIVATE_DOMAIN}}`), nên API bộ nhớ và database cứ để private là an toàn nhất. Nếu thật sự cần Honcho API public (vd. client SDK bên ngoài), hãy Generate Domain ở cổng `8000` **và** bật `AUTH_USE_AUTH=true` kèm khóa JWT trước.

> ⚠️ **Public = bắt buộc có đăng nhập.** Domain công khai khiến bất kỳ ai trên Internet cũng vào được dashboard, nên **bắt buộc** phải đặt bộ `HERMES_DASHBOARD_BASIC_AUTH_*` (xem lưu ý ở phần deploy phía trên).

### 🔧 Cấu hình — biến môi trường

| Biến | Bắt buộc | Service | Mô tả |
|------|:---:|---------|-------|
| `LLM_OPENAI_API_KEY` | ✅ | honcho | OpenAI key cho trích xuất bộ nhớ (dùng lại mọi nơi) |
| `OPENAI_API_KEY` | ✅ | hermes | OpenAI key cho chat |
| `HONCHO_BASE_URL` | ✅ | hermes | URL của service Honcho API |
| `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` | ✅ | hermes | Tên đăng nhập dashboard (bắt buộc khi bind công khai) |
| `HERMES_DASHBOARD_BASIC_AUTH_PASSWORD` | ✅ | hermes | Mật khẩu dashboard (bắt buộc khi bind công khai) |
| `HERMES_DASHBOARD_BASIC_AUTH_SECRET` | ❌ | hermes | Chuỗi bí mật ≥32 byte để giữ phiên qua các lần restart |
| `DB_CONNECTION_URI` | ✅ | honcho | URL Postgres (scheme tự chuẩn hóa về `postgresql+psycopg://`) |
| `CACHE_URL` | ✅ | honcho | URL Redis |
| `OPENAI_BASE_URL` | ❌ | hermes | Endpoint tương thích OpenAI tùy chỉnh |
| `ANTHROPIC_API_KEY` | ❌ | cả hai | Anthropic API key |
| `GOOGLE_API_KEY` | ❌ | cả hai | Google Gemini API key |
| `AUTH_USE_AUTH` | ❌ | honcho | Bật JWT auth của Honcho (mặc định: `false`) |
| `LOG_LEVEL` | ❌ | honcho | `DEBUG` / `INFO` / `WARNING` / `ERROR` |

### 🧠 Bộ nhớ hoạt động thế nào

Sau khi triển khai, Hermes dùng Honcho để:
- **Giữ ngữ cảnh xuyên phiên** — bộ nhớ sống sót qua các lần restart container.
- **Suy luận biện chứng** — Honcho phân tích hội thoại và rút ra insight.
- **Mô hình hóa người dùng** — học sở thích, thói quen, mục tiêu theo thời gian.
- **Tóm tắt phiên** — bơm ngữ cảnh để giữ mạch liên tục.

Xem thêm [tài liệu tính năng Honcho](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md).

---

## 📁 Project structure

```
hermes-agent-with-honcho/
├── README.md                 # This file
├── docker-compose.yml        # Local development compose
├── .env.example              # Environment variables template
├── hermes/                   # Hermes Agent service
│   ├── Dockerfile            # FROM the official nousresearch/hermes-agent image
│   ├── railway.toml          # Railway deploy config (healthcheck /api/status)
│   ├── config.yaml           # Selects the honcho memory provider
│   └── entrypoint.sh         # Seeds config + runs `hermes dashboard`
└── honcho/                   # Honcho service (API + Deriver)
    ├── Dockerfile            # Built from upstream source
    ├── railway.toml          # Railway deploy config
    └── entrypoint.sh         # Normalizes DB URL, migrates, runs api/deriver
```

---

## 📄 License

This project is a deployment template that combines:
- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — MIT License
- [Honcho](https://github.com/plastic-labs/honcho) — AGPL-3.0 License

The deployment configuration files in this repository are MIT licensed.

---

## 🙏 Credits

- [NousResearch](https://github.com/NousResearch) — Hermes Agent
- [Plastic Labs](https://github.com/plastic-labs) — Honcho Memory
- [Railway](https://railway.com) — Cloud deployment platform
