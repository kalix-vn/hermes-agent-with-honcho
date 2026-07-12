# Module 06 — Cách A: Deploy local bằng Docker Compose

> **Thời lượng:** ~18 phút · **Mức độ:** Trung cấp
> **Mục tiêu:** Dựng toàn bộ 5 service (Hermes + Honcho API + Deriver + Postgres + Redis) chạy
> trên máy bạn bằng một lệnh, và xác minh chúng khỏe mạnh.
> **Yêu cầu trước:** [Module 05](./05-chuan-bi-moi-truong.md) (đã cài Docker, có `.env`)

## 🎯 Kết quả sau bài học
- Cả 5 service chạy `Up`/`healthy` với `docker compose ps`.
- Mở được dashboard tại <http://localhost:3000> và đăng nhập.
- Honcho API trả `200` tại `/health`.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Đây là cách nhanh nhất để thấy toàn hệ thống chạy: một lệnh `docker compose up`, Docker
tự dựng 5 service, tự nối mạng nội bộ giữa chúng. Mình sẽ đi từng service để bạn hiểu cái nào làm gì."

**Thao tác màn hình:** mở [`../docker-compose.yml`](../docker-compose.yml), chiếu nhanh 5 service:
`postgres`, `redis`, `honcho-api`, `deriver`, `hermes`.

---

## 🪜 Các bước thực hiện

### Bước 1 — Kiểm tra lại `.env`

**Lệnh:**
```bash
cd hermes-agent-with-honcho
cat .env | grep -v '^#' | grep .
```
Đảm bảo tối thiểu có `OPENAI_API_KEY=sk-...`. Các biến DB/Redis đã có default trong compose nên
không bắt buộc.

> 💡 Muốn đổi login dashboard local, thêm vào `.env`:
> ```bash
> HERMES_DASHBOARD_USERNAME=admin
> HERMES_DASHBOARD_PASSWORD=doi-mat-khau
> HERMES_DASHBOARD_SECRET=chuoi-bi-mat-dai-32-ky-tu-tro-len
> ```
> Nếu không đặt, mặc định là `admin` / `hermes-local`.

### Bước 2 — Dựng & khởi động toàn bộ

**Lệnh:**
```bash
docker compose up -d --build
```
〔Nói〕 "`-d` = chạy nền; `--build` = build image lần đầu. Lần đầu sẽ hơi lâu vì phải build
Honcho từ mã nguồn và kéo image Hermes chính thức."

`【SCREENSHOT: terminal đang build, log 'Successfully built'】`

### Bước 3 — Kiểm tra trạng thái

**Lệnh:**
```bash
docker compose ps
```
Mong đợi: `postgres`, `redis`, `honcho-api`, `hermes` ở trạng thái **healthy**; `deriver` ở
trạng thái **running/Up** (nó *không* có healthcheck — xem ghi chú).

> 📌 **Vì sao deriver không "healthy"?** Deriver là **worker nền, không chạy HTTP server**, nên
> healthcheck kiểu `curl /health` sẽ không bao giờ pass. Compose đã **tắt healthcheck** cho nó
> (`healthcheck: disable: true`). `Up` là đủ.

### Bước 4 — Xem log để chắc mọi thứ nối được nhau

**Lệnh:**
```bash
docker compose logs -f            # tất cả (Ctrl+C để thoát)
docker compose logs -f hermes     # chỉ Hermes
docker compose logs -f deriver    # chỉ Deriver (thấy nó xử lý hàng đợi)
```
Trong log `hermes` bạn sẽ thấy các dòng từ entrypoint:
```
🧠 Hermes Agent (Web Dashboard) starting...
   Honcho URL:  http://honcho-api:8000
✅ Memory provider set to honcho (/opt/data/config.yaml)
🔐 Dashboard auth: basic (username/password)
🚀 hermes dashboard --host 0.0.0.0 --port 3000 --no-open --skip-build
```

〔Nói〕 "Dòng '✅ Memory provider set to honcho' chính là lúc Hermes chọn Honcho làm bộ nhớ. Dòng
'Honcho URL' cho thấy nó biết gọi Honcho ở đâu qua mạng nội bộ Docker."

`【SCREENSHOT: log hermes có dòng '✅ Memory provider set to honcho'】`

### Bước 5 — Kiểm tra sức khỏe Honcho API

**Lệnh:**
```bash
curl -i http://localhost:8000/health
```
Mong đợi: `HTTP/1.1 200 OK`.

### Bước 6 — Mở dashboard & đăng nhập

**Thao tác:** mở trình duyệt tới <http://localhost:3000>.
- Đăng nhập: `admin` / `hermes-local` (hoặc giá trị bạn đặt ở `.env`).

`【SCREENSHOT: màn hình đăng nhập + dashboard sau khi vào】`

### Bước 7 — Bảng dịch vụ & cổng (để tham chiếu)

| Service | URL/cổng (local) | Ghi chú |
|---------|------------------|---------|
| Hermes dashboard | http://localhost:3000 | Login `admin`/`hermes-local` |
| Honcho API | http://localhost:8000 | API bộ nhớ |
| Honcho health | http://localhost:8000/health | Phải trả `200` |
| PostgreSQL | 127.0.0.1:5432 | Chỉ bind loopback |
| Redis | 127.0.0.1:6379 | Chỉ bind loopback |

> 🔒 Postgres/Redis **chỉ bind `127.0.0.1`** — không lộ ra mạng ngoài. Đây là hardening có sẵn.

### Bước 8 — Dừng / dọn dẹp

**Lệnh:**
```bash
docker compose down        # dừng, GIỮ dữ liệu (volume)
docker compose down -v     # dừng và XÓA sạch dữ liệu (postgres + redis)
```
> ⚠️ `-v` xóa luôn bộ nhớ đã học. Chỉ dùng khi muốn làm lại từ đầu.

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| `hermes` mãi không `healthy` | OpenAI key sai/thiếu, hoặc chưa nối được Honcho | Xem `docker compose logs hermes`; kiểm tra `OPENAI_API_KEY` |
| Dashboard mở ra nhưng **không đăng nhập được** | Sai user/pass; hoặc dư khoảng trắng/nháy trong biến | Đối chiếu `.env`; entrypoint in "fingerprint" (len+sha8) trong log để so khớp |
| Chat báo lỗi / không trả lời | `OPENAI_API_KEY` là placeholder | Đặt key thật trong `.env` **hoặc** trang Config của dashboard, rồi `docker compose up -d` |
| `deriver` cứ restart | Không kết nối được Postgres/Redis | Đảm bảo `postgres`/`redis` healthy trước; xem log deriver |
| `port is already allocated` (3000/8000/5432) | Cổng đang bị chiếm | Tắt tiến trình chiếm cổng, hoặc đổi cổng map trong compose |
| Honcho lỗi kết nối DB | Sai driver DB | Compose đã set `postgresql+psycopg://...`; đừng sửa scheme |

> 💡 **"Chat thật cần key thật."** Với key placeholder, mọi service vẫn boot và dashboard vẫn mở,
> nhưng chat + trích xuất bộ nhớ chỉ hoạt động khi có key hợp lệ.

## ✅ Checklist học viên
- [ ] `docker compose ps`: postgres/redis/honcho-api/hermes = healthy; deriver = Up.
- [ ] `curl localhost:8000/health` → 200.
- [ ] Đăng nhập được dashboard ở localhost:3000.
- [ ] Log hermes có dòng "✅ Memory provider set to honcho".
- [ ] Gửi thử một tin nhắn và nhận được trả lời (nếu đã có key thật).

## 🧠 Tổng kết
Một lệnh `docker compose up -d --build` dựng cả 5 service. Deriver là worker nền nên không
"healthy" là bình thường. Kiểm tra qua `docker compose ps`, `/health`, và log "provider set to
honcho". Đây là môi trường lý tưởng để học trước khi lên cloud.

## ➡️ Tiếp theo
- Muốn chạy 24/7 trên cloud: [Module 07 — Railway](./07-trien-khai-railway.md)
- Hệ thống đã chạy rồi: [Module 08 — Chạy lần đầu & tham quan Dashboard](./08-cau-hinh-lan-dau-va-dashboard.md)
