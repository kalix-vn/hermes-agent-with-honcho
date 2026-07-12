# Module 09 — Kiểm chứng bộ nhớ Honcho hoạt động

> **Thời lượng:** ~12 phút · **Mức độ:** Trung cấp
> **Mục tiêu:** Chứng minh (không phải "tin") rằng Honcho đang nhớ bạn xuyên phiên, và biết các
> lệnh/công cụ Honcho để kiểm tra trạng thái.
> **Yêu cầu trước:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md), hiểu khái niệm [Module 03](./03-honcho-la-gi.md)

## 🎯 Kết quả sau bài học
- Tự tay tạo được "wow moment": agent nhớ thông tin từ **phiên trước**.
- Dùng được `hermes honcho status` và biết các công cụ `honcho_*`.
- Biết cách xác nhận deriver đã suy luận (qua log/Honcho).

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Đây là bài 'chứng minh giá trị'. Bộ nhớ mặc định sẽ quên khi reset session. Với Honcho,
ký ức **sống sót qua phiên, qua thiết bị, qua restart**. Ta sẽ test trực tiếp."

---

## 🪜 Các bước thực hiện

### Bước 1 — Xác nhận Honcho là provider đang hoạt động

**Mở shell vào Hermes** (Docker: `docker compose exec hermes sh`; Railway: nút Shell của service `hermes`), rồi:
```bash
hermes honcho status
```
Mong đợi: thông tin kết nối + cấu hình (base URL, peer, cadence…). 

> 📌 Bộ lệnh `hermes honcho ...` **chỉ xuất hiện khi Honcho là provider đang active**. Nếu không
> thấy, kiểm tra `config.yaml` có `memory.provider: honcho` và `HONCHO_BASE_URL` đã set chưa
> (Module 06/07).

`【SCREENSHOT: output của 'hermes honcho status'】`

Các lệnh `hermes honcho` hữu ích (tham khảo, sẽ dùng ở Module 16):
```bash
hermes honcho status      # thông tin kết nối & cấu hình
hermes honcho peer        # xem/cập nhật tên peer
hermes honcho sessions    # liệt kê ánh xạ session
hermes honcho mode        # xem/đặt recall mode (hybrid/context/tools)
hermes honcho strategy    # xem/đặt session strategy
```

### Bước 2 — Nạp một "sự thật" về bạn (phiên 1)

**Thao tác:** trong chat, nói một thông tin đặc trưng, dễ kiểm:
> "Ghi nhớ giúp tôi: tôi tên Minh, đang học tiếng Nhật trình độ N4, và tôi thích giải thích ngắn
> gọn kèm ví dụ."

Agent xác nhận. Lúc này Honcho lưu message (đồng bộ) và **enqueue** việc suy luận cho **deriver**.

〔Nói〕 "Ngay bây giờ deriver đang nghiền ngẫm ở nền để cập nhật 'representation' về mình — không
làm chậm chat."

### Bước 3 — Quan sát deriver xử lý (bằng chứng kỹ thuật)

**Bản Docker:**
```bash
docker compose logs -f deriver
```
Bạn sẽ thấy deriver nhận và xử lý tác vụ suy luận sau khi bạn gửi tin.

`【SCREENSHOT: log deriver đang xử lý một task】`

### Bước 4 — Tạo phiên MỚI rồi hỏi lại (phiên 2) — phép thử quyết định

Tạo phiên mới theo **một** trong các cách:
- Chờ qua ngưỡng inactivity / sang ngày (nếu để `inactivity+daily reset`), **hoặc**
- Nhắn từ **kênh khác** (vd. Telegram sau Module 11), **hoặc**
- Bắt đầu một cuộc trò chuyện mới trong dashboard.

Sau đó hỏi:
> "Bạn còn nhớ tôi đang học ngoại ngữ nào và ở trình độ nào không? Và tôi thích cách giải thích thế nào?"

Mong đợi: agent trả lời đúng **"tiếng Nhật, N4, thích ngắn gọn kèm ví dụ"** — dù đây là phiên khác.

`【SCREENSHOT: phiên mới trả lời đúng thông tin phiên cũ — WOW MOMENT】`

〔Nói〕 "Đó chính là Honcho. Không phải nó nhớ *câu chữ* — mà nó đã **mô hình hóa bạn** và truy
xuất lại khi cần."

### Bước 5 — (Nâng cao) Nhìn "insight" qua công cụ Honcho

Khi Honcho active, agent có các công cụ:
| Công cụ | Chức năng |
|---------|-----------|
| `honcho_profile` | Đọc/cập nhật thẻ hồ sơ (peer card) của bạn |
| `honcho_search` | Tìm kiếm ngữ nghĩa trên ngữ cảnh |
| `honcho_context` | Lấy toàn bộ ngữ cảnh phiên |
| `honcho_reasoning` | Câu trả lời tổng hợp có suy luận (chỉnh được độ sâu) |
| `honcho_conclude` | Tạo/xóa "kết luận" về bạn |

**Thao tác:** thử ra lệnh để agent dùng suy luận Honcho:
> "Dựa trên những gì bạn biết về tôi, hãy mô tả phong cách học và giao tiếp của tôi."

Agent sẽ gọi `honcho_reasoning`/`honcho_profile` để trả lời có căn cứ.

`【SCREENSHOT: agent dùng công cụ honcho_reasoning để mô tả bạn】`

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| Không có lệnh `hermes honcho` | Honcho chưa active | Kiểm tra `memory.provider: honcho` + `HONCHO_BASE_URL` |
| Phiên mới **không** nhớ | Deriver chưa kịp xử lý / lỗi | Xem log deriver; đợi vài giây; kiểm tra Postgres/Redis khỏe |
| Nhớ sai/lẫn người | Peer mapping sai (đa người dùng) | Cấu hình peer/aliases — [Module 16](./16-honcho-nang-cao.md) |
| Deriver báo lỗi LLM | `LLM_OPENAI_API_KEY` thiếu ở honcho | Đặt key cho honcho-api & deriver |

## ✅ Checklist học viên
- [ ] `hermes honcho status` trả về thông tin kết nối.
- [ ] Thấy deriver xử lý task trong log sau khi gửi tin.
- [ ] Phiên mới trả lời đúng thông tin của phiên cũ (wow moment).
- [ ] Gọi được một công cụ `honcho_*` để agent mô tả bạn.

## 🧠 Tổng kết
Honcho đã chạy khi: `hermes honcho status` OK, deriver xử lý nền, và **phiên mới nhớ được thông
tin phiên cũ**. Đây là bằng chứng sống của "trợ lý có trí nhớ". Tiếp theo ta *chủ động dạy* agent
hiểu bạn qua onboarding.

## ➡️ Tiếp theo
[Module 10 — Onboarding: User & Soul (persona của agent)](./10-onboarding-user-va-soul.md)
