# Module 18 — Vận hành, chi phí & troubleshooting

> **Thời lượng:** ~14 phút · **Mức độ:** Trung cấp → Nâng cao
> **Mục tiêu:** Giữ hệ thống chạy ổn định, kiểm soát chi phí, và tự chẩn đoán các sự cố phổ biến
> của cả 5 service.
> **Yêu cầu trước:** Đã deploy ([Module 06](./06-trien-khai-local-docker.md) hoặc [07](./07-trien-khai-railway.md))

## 🎯 Kết quả sau bài học
- Đọc log đúng service để khoanh vùng lỗi.
- Áp dụng các đòn bẩy giảm chi phí token.
- Có **bảng tra sự cố** cho toàn stack.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Dựng xong không phải là hết. Bạn cần biết nhìn log, cắt chi phí, và sửa nhanh khi có trục
trặc. 90% sự cố nằm ở vài chỗ quen thuộc — mình gom hết vào đây."

---

## 🪜 Nội dung bài học

### 1. Bản đồ log — nhìn đúng chỗ

**Bản Docker:**
```bash
docker compose ps                 # trạng thái tổng quan
docker compose logs -f hermes     # UI/agent/gateway (Telegram, dashboard, honcho client)
docker compose logs -f honcho-api # API bộ nhớ (lưu message, health)
docker compose logs -f deriver    # suy luận nền — nơi lỗi LLM key của Honcho lộ ra
docker compose logs -f postgres   # DB
docker compose logs -f redis      # cache/queue
```
**Bản Railway:** mỗi service có tab **Logs/Deployments** riêng — xem đúng service nghi ngờ.

| Triệu chứng thuộc về | Xem log |
|----------------------|---------|
| Không đăng nhập / chat lỗi / Telegram im | `hermes` |
| Không nhớ / representation không cập nhật | `deriver` |
| API bộ nhớ lỗi, `/health` fail | `honcho-api` |
| Deriver/api crash khởi động | `postgres`, `redis` |

### 2. Kiểm soát chi phí (token = tiền)

〔Nói〕 "Chi phí đến từ **số lần gọi LLM** × **kích thước context**. Đây là các đòn bẩy."

| Đòn bẩy | Cách | Module |
|---------|------|--------|
| Đặt **spend limit** ở nhà cung cấp | OpenAI → Usage limits | [05](./05-chuan-bi-moi-truong.md) |
| Hạ **max iterations** về mặc định | Config | [08](./08-cau-hinh-lan-dau-va-dashboard.md) |
| **Context compression** hợp lý (`0.8`) | Config | [08](./08-cau-hinh-lan-dau-va-dashboard.md) |
| **Session reset** `inactivity+daily` | Config | [08](./08-cau-hinh-lan-dau-va-dashboard.md) |
| Tăng `dialecticCadence`, giữ `depth=1` | `hermes honcho` | [16](./16-honcho-nang-cao.md) |
| `recallMode: tools` (chỉ tra khi cần) | `hermes honcho mode` | [16](./16-honcho-nang-cao.md) |
| Dùng model rẻ cho task nhẹ | multi-model config | [16](./16-honcho-nang-cao.md) |
| Provider rẻ qua `OPENAI_BASE_URL` | OpenRouter/DeepSeek… | [07](./07-trien-khai-railway.md) |

> 💡 Honcho có **2 nguồn tốn token**: chat (Hermes) *và* deriver (suy luận nền). Đừng quên núm
> cadence/depth của Honcho khi tối ưu.

### 3. Bảo trì định kỳ

- **Rotate secret** (OpenAI key, GitHub PAT, Telegram token) theo lịch — [04](./04-bao-mat-va-guardrails.md)/[12](./12-github-backup.md).
- **Kiểm tra backup** thật sự chạy (xem tab Commits repo) — [12](./12-github-backup.md).
- **Theo dõi dung lượng Postgres** (message/representation tích lũy). Dọn dữ liệu cũ nếu cần.
- **Cập nhật image** khi upstream Hermes/Honcho ra bản vá bảo mật (rebuild/redeploy).

### 4. Bảng tra sự cố toàn stack

| Sự cố | Khoanh vùng | Cách sửa |
|-------|-------------|----------|
| Dashboard không mở/login fail | `hermes` log | Đặt `HERMES_DASHBOARD_BASIC_AUTH_*`; so "fingerprint" trong log; redeploy sau khi sửa env |
| Chat không trả lời | `hermes` | Key OpenAI sai/hết quota; đổi model |
| Nhớ không hoạt động | `deriver` | Key LLM của Honcho thiếu; Postgres/Redis chết; đợi deriver xử lý |
| `honcho-api` /health fail | `honcho-api` | DB URL sai; entrypoint tự sửa scheme — kiểm tra `DB_CONNECTION_URI` |
| Deriver deploy fail (Railway) | `deriver` | Bỏ Healthcheck Path (worker không có HTTP) |
| Telegram im lặng | `hermes` | Gateway dừng → nhờ agent restart / restart service |
| `port already allocated` (local) | — | Đổi cổng/tắt tiến trình chiếm cổng |
| Agent chạy lâu, đốt token | `hermes` | Hạ iterations; ra lệnh rõ ràng |
| Đổi env nhưng không ăn | — | Redeploy service (Railway) / `up -d` lại (Docker) |
| Postgres đầy | `postgres` | Tăng dung lượng / dọn dữ liệu cũ |

### 5. Nút "khẩn cấp"

〔Nói〕 "Nếu nghi ngờ bị xâm nhập hoặc agent hành xử lạ:"
- **Dừng ngay:** `docker compose down` (local) hoặc tắt service `hermes` trên Railway.
- **Revoke secret:** xóa OpenAI key, GitHub PAT, Telegram token đang dùng.
- **Kéo domain xuống:** gỡ public domain của Hermes để cắt truy cập ngoài.
- Khôi phục từ backup GitHub khi đã an toàn.

---

## ⚠️ Nhắc lại nguyên tắc vàng
- Secret sống trong **env**, không trong chat/Git.
- Chỉ expose **Hermes**; Honcho/DB/Redis private.
- Đổi env → **redeploy** mới ăn.
- Deriver **không** healthcheck HTTP.

## ✅ Checklist học viên
- [ ] Biết xem log của từng service đúng lúc.
- [ ] Đã áp dụng ≥3 đòn bẩy giảm chi phí.
- [ ] Nắm bảng tra sự cố (bookmark lại).
- [ ] Biết quy trình "khẩn cấp" khi có sự cố bảo mật.

## 🧠 Tổng kết
Vận hành = nhìn đúng log + kiểm soát token + bảo trì + biết tra sự cố. Nhớ nút khẩn cấp: dừng,
revoke, gỡ domain, khôi phục backup. Có bảng này, bạn tự chủ được hệ thống.

## ➡️ Tiếp theo
[Module 19 — Tổng kết, bài tập & tài nguyên](./19-tong-ket-bai-tap-tai-nguyen.md)
