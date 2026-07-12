# Module 07 — Cách B: Deploy lên Railway (1-click + tự build template)

> **Thời lượng:** ~20 phút · **Mức độ:** Trung cấp
> **Mục tiêu:** Đưa hệ thống lên cloud chạy 24/7 — cả cách nhanh (1-click) lẫn cách tự dựng
> template 9 bước để hiểu từng service.
> **Yêu cầu trước:** [Module 05](./05-chuan-bi-moi-truong.md) (có tài khoản Railway + OpenAI key)

## 🎯 Kết quả sau bài học
- Có một Hermes dashboard chạy trên URL public `https://<tên>.up.railway.app`, có đăng nhập.
- Hiểu cấu hình biến môi trường của **từng** service và vì sao đặt như vậy.
- Biết chỉ expose Hermes, giữ Honcho/DB/Redis ở mạng nội bộ.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Railway cho phép chạy nhiều service từ **một repo** (monorepo). Ta sẽ có PostgreSQL,
Redis, Honcho API, Honcho Deriver và Hermes — tất cả tự nối mạng nội bộ. Có hai cách: bấm nút
1-click cho nhanh, hoặc tự dựng để hiểu sâu. Mình làm cả hai."

---

## 🪜 PHẦN 1 — Cách nhanh: Deploy 1-click

### Bước 1 — Bấm nút Deploy

**Thao tác:** mở [`../README.md`](../README.md), bấm **Deploy on Railway**, hoặc mở:
```
https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c
```

### Bước 2 — Nhập thông tin được hỏi

- `LLM_OPENAI_API_KEY` — OpenAI key (**bắt buộc**). Dùng lại cho mọi service → chỉ nhập **1 lần**.
- **Username & password** cho dashboard.

> ⚠️ **Bắt buộc đặt login dashboard.** Từ đợt siết bảo mật 6/2026, bind công khai **phải** có
> auth. Không đặt `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` + `..._PASSWORD` = **không mở được dashboard**.

`【SCREENSHOT: form deploy Railway hỏi API key + dashboard login】`

### Bước 3 — Chờ provision & lấy URL

Railway tự dựng đủ 5 service. Sau khi xong → [Phần 3: Expose & đăng nhập](#phần-3--expose-ra-internet--đăng-nhập).

---

## 🪜 PHẦN 2 — Tự dựng template (9 bước, để hiểu sâu)

> Dùng khi muốn kiểm soát từng service, hoặc để **dạy học viên hiểu kiến trúc**. Mở phần
> *"Railway template setup"* trong [`../README.md`](../README.md) để bám sát.

### Bước 1 — Tạo template
Railway → **Account Settings → Templates → Create Template**, đặt tên `Hermes Agent + Honcho Memory`.

### Bước 2 — Thêm PostgreSQL
**+ Add Service → Database → PostgreSQL**. Postgres của Railway hỗ trợ sẵn `pgvector`.

### Bước 3 — Thêm Redis
**+ Add Service → Database → Redis**.

### Bước 4 — Thêm Honcho API
**+ Add Service → GitHub Repo** → repo này. Đặt **Root Directory = `honcho`**. Biến môi trường:
```bash
HONCHO_MODE=api
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true
AUTH_USE_AUTH=false
LLM_OPENAI_API_KEY=              # BẮT BUỘC — đánh dấu Required khi publish
```
> 📌 **Về DB URL:** Honcho (SQLAlchemy) cần prefix `postgresql+psycopg://`, nhưng Railway trả
> `postgresql://` thuần. **Entrypoint tự ghi lại scheme** nên dán `${{Postgres.DATABASE_URL}}` là
> chạy. Nó cũng fallback về `DATABASE_URL`/`REDIS_URL` nếu để trống `DB_CONNECTION_URI`/`CACHE_URL`.

(Tùy chọn) **Healthcheck Path = `/health`** cho service này.

### Bước 5 — Thêm Honcho Deriver
**+ Add Service → GitHub Repo** → repo này, **Root Directory = `honcho`**. Biến:
```bash
HONCHO_MODE=deriver
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
CACHE_URL=${{Redis.REDIS_URL}}
CACHE_ENABLED=true
AUTH_USE_AUTH=false
LLM_OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}
```
> ⚠️ **Deriver không có HTTP server** → **để trống Healthcheck Path**. Healthcheck HTTP sẽ không
> bao giờ pass và làm deploy fail. (Đây là lỗi phổ biến nhất khi tự dựng!)

### Bước 6 — Thêm Hermes Agent
**+ Add Service → GitHub Repo** → repo này, **Root Directory = `hermes`**. Vào
**Settings → Networking → Generate Domain**. Biến:
```bash
# Kết nối Honcho qua mạng nội bộ Railway
HONCHO_BASE_URL=http://${{honcho-api.RAILWAY_PRIVATE_DOMAIN}}:8000

# Key LLM (dùng lại từ honcho-api → nhập một lần)
OPENAI_API_KEY=${{honcho-api.LLM_OPENAI_API_KEY}}

# Auth dashboard — BẮT BUỘC cho domain công khai
HERMES_DASHBOARD_BASIC_AUTH_USERNAME=admin
HERMES_DASHBOARD_BASIC_AUTH_PASSWORD=<mật-khẩu-mạnh>
HERMES_DASHBOARD_BASIC_AUTH_SECRET=<chuỗi-bí-mật-32-byte>   # giữ phiên qua restart
```

### Bước 7 — (Tùy chọn) LLM base URL tùy chỉnh
Muốn dùng provider tương thích OpenAI (OpenRouter, DeepSeek, Together AI, vLLM local…):
- **Hermes:** đặt `OPENAI_BASE_URL` (vd. `https://openrouter.ai/api/v1`).
- **Honcho (api + deriver):** đặt `DERIVER_MODEL_CONFIG__OVERRIDES__BASE_URL`,
  `EMBEDDING_MODEL_CONFIG__OVERRIDES__BASE_URL`, và `EMBEDDING_MODEL_CONFIG__MODEL`
  (vd. `text-embedding-3-small`).

### Bước 8 — Publish
Đánh dấu `LLM_OPENAI_API_KEY` (trên `honcho-api`) là **Required**. Vì các service khác tham chiếu
`${{honcho-api.LLM_OPENAI_API_KEY}}`, người deploy chỉ nhập key **một lần**. Bấm **Publish Template**.

### Bước 9 — Thêm nút deploy
```markdown
[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/hermes-agent-honcho-memory?referralCode=KqbI8c)
```

`【SCREENSHOT: sơ đồ 5 service trên canvas Railway đã nối với nhau】`

---

## 🪜 PHẦN 3 — Expose ra Internet & đăng nhập

### Bước 1 — Cấp domain cho **hermes**
Mở service **hermes** → **Settings → Networking → Public Networking → Generate Domain**.
Railway tạo `https://<tên>.up.railway.app` (tự lo HTTPS). Nếu hỏi cổng → nhập **`3000`**.

### Bước 2 — Đăng nhập
Mở URL vừa tạo, đăng nhập bằng `HERMES_DASHBOARD_BASIC_AUTH_USERNAME` / `PASSWORD`.

### Bước 3 — (Tùy chọn) Domain riêng
Cùng panel → **Custom Domain** → nhập `chat.tenmien.com` → thêm bản ghi **CNAME** Railway hiển thị.
Railway tự cấp TLS.

> 🔒 **CHỈ expose Hermes.** **Đừng** Generate Domain cho `honcho-api`, `honcho-deriver`, Postgres,
> Redis. Hermes gọi Honcho qua mạng nội bộ (`RAILWAY_PRIVATE_DOMAIN`). Nếu buộc phải public Honcho
> API → Generate Domain cổng `8000` **và** bật `AUTH_USE_AUTH=true` + khóa JWT trước.

`【SCREENSHOT: panel Networking — chỉ hermes có public domain】`

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| Deploy `honcho-deriver` **fail** | Đặt Healthcheck Path cho deriver | Xóa trống healthcheck của deriver |
| Mở dashboard bị **reject/không login** | Thiếu `HERMES_DASHBOARD_BASIC_AUTH_*` | Đặt username+password rồi **redeploy** |
| Honcho API lỗi kết nối DB | Sai/thiếu `DB_CONNECTION_URI` | Dùng `${{Postgres.DATABASE_URL}}` (entrypoint tự sửa scheme) |
| Đổi biến rồi vẫn login sai | Sửa env nhưng **chưa redeploy** | Redeploy service; log Hermes in fingerprint để so khớp |
| Chat không chạy | `LLM_OPENAI_API_KEY` chưa Required / để trống | Đặt key trên `honcho-api`, các service khác kế thừa |
| Session đăng nhập rớt sau mỗi restart | Thiếu `..._BASIC_AUTH_SECRET` | Đặt secret ≥32 byte cố định |

## ✅ Checklist học viên
- [ ] 5 service đều xanh; deriver **không** có healthcheck HTTP.
- [ ] `hermes` có public domain (cổng 3000); honcho/DB/redis vẫn private.
- [ ] Đăng nhập được dashboard qua URL Railway.
- [ ] `LLM_OPENAI_API_KEY` đặt Required, nhập một lần, các service kế thừa.

## 🧠 Tổng kết
Railway dựng cả stack từ monorepo. Nhớ 3 điều: (1) deriver **không** healthcheck HTTP; (2) chỉ
expose Hermes; (3) bắt buộc basic-auth cho dashboard public. Xong bước này bạn có trợ lý chạy 24/7.

## ➡️ Tiếp theo
[Module 08 — Chạy lần đầu & tham quan Dashboard](./08-cau-hinh-lan-dau-va-dashboard.md)
