# Module 03 — Honcho là gì & tại sao ghép với Hermes

> **Thời lượng:** ~14 phút · **Mức độ:** Cơ bản → Trung cấp
> **Mục tiêu:** Hiểu Honcho là tầng bộ nhớ kiểu gì, các khái niệm Peer/Session/Workspace, và *vì
> sao* ghép với Hermes lại mạnh hơn bộ nhớ mặc định.
> **Yêu cầu trước:** [Module 02](./02-kien-truc-va-5-khai-niem.md)

## 🎯 Kết quả sau bài học
- Giải thích Honcho bằng một câu: *"bộ nhớ hiểu người, không phải kho lưu chữ"*.
- Nắm 4 khái niệm: **Workspace · Peer · Session · Message**, và 3 khái niệm suy luận: **Deriver ·
  Representation · Dialectic/Chat**.
- Hiểu kiến trúc 5 service trong repo và luồng dữ liệu **đồng bộ (lưu)** vs **bất đồng bộ (suy luận)**.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Bộ nhớ mặc định của agent thường chỉ là *tóm tắt lại tin nhắn cũ*. Honcho làm khác: nó
**xây một mô hình về bạn** — sở thích, niềm tin, phong cách giao tiếp — và **liên tục cập nhật**
mô hình đó khi hiểu bạn hơn. Nó do Plastic Labs làm, mã nguồn mở, và mình sẽ **tự host** nó."

---

## 🪜 Nội dung bài học

### 1. Honcho giải quyết vấn đề gì?

〔Nói〕 "Vấn đề của trợ lý AI: hết phiên là quên; đổi thiết bị là quên; restart server là quên.
Và kể cả khi nhớ, nó chỉ nhớ *chữ đã nói*, chứ không *hiểu bạn là người thế nào*."

Honcho là **memory infrastructure cho agent có trạng thái (stateful)**. Nó:
- **Nhận tin nhắn** bạn lưu vào (đồng bộ, nhanh).
- **Suy luận trong nền** (bất đồng bộ) để cập nhật hiểu biết về từng "peer".
- **Trả lời truy vấn**: ngữ cảnh phiên, kết quả tìm kiếm, hoặc *insight bằng ngôn ngữ tự nhiên*.

### 2. Bốn khái niệm lưu trữ (Storage — đồng bộ)

**Thao tác màn hình:** chiếu sơ đồ phân cấp.

```
Workspace  (không gian cô lập — vd. "hermes-railway")
  └── Peer         (một chủ thể: NGƯỜI DÙNG hoặc chính AGENT)
        └── Session   (một cuộc hội thoại / thread)
              └── Message  (một tin nhắn, gắn nhãn peer nguồn)
```

| Khái niệm | Nghĩa | Ẩn dụ |
|-----------|-------|-------|
| **Workspace** | Thùng chứa cấp cao, cô lập dữ liệu giữa các ứng dụng (multi-tenant) | "Tòa nhà" |
| **Peer** | *Bất kỳ chủ thể nào* — người dùng **hoặc** AI agent — đều là công dân hạng nhất | "Con người" |
| **Session** | Một tập tương tác giữa các peer (thread/hội thoại) | "Cuộc trò chuyện" |
| **Message** | Đơn vị dữ liệu nhỏ nhất, gắn nhãn peer nguồn, xử lý bất đồng bộ | "Câu nói" |

〔Nói〕 "Điểm hay: cả **bạn lẫn agent đều là 'peer'**. Nhờ vậy Honcho có thể mô hình hóa cả hai và
tách bạch nhiều agent/nhiều người dùng mà không lẫn lộn ngữ cảnh."

### 3. Ba khái niệm suy luận (Insights — bất đồng bộ)

〔Nói〕 "Đây là phần 'thông minh'. Sau khi lưu tin nhắn, một tiến trình nền tên **Deriver** sẽ
nghiền ngẫm và cập nhật hiểu biết — **không làm chậm lúc chat**."

| Khái niệm | Nghĩa |
|-----------|-------|
| **Deriver** | Worker nền, xử lý hàng đợi: cập nhật representation, tạo tóm tắt phiên, rút kết luận |
| **Representation** | *Ảnh chụp tĩnh, độ trễ thấp* về những gì Honcho biết về một peer (có thể theo phiên) |
| **Dialectic / Chat** | Hỏi Honcho bằng ngôn ngữ tự nhiên: *"người dùng thích phong cách học kiểu gì?"* → trả lời có căn cứ suy luận |

〔Nói〕 "**Dialectic** (suy luận biện chứng) là điểm nhấn: thay vì trả về chữ thô, Honcho tổng hợp
và *lập luận* để đưa ra insight về bạn."

Ví dụ API (chỉ để minh họa, học viên **không cần gõ** lúc này):
```python
alice = honcho.peer("alice")
session.add_messages([alice.message("Tôi thích giải thích ngắn gọn, có ví dụ")])
# ... deriver xử lý nền ...
answer = alice.chat("Người dùng thích phong cách giải thích thế nào?")
# → "Ưa ngắn gọn, kèm ví dụ cụ thể"
```

### 4. Kiến trúc thật trong repo này (5 service)

**Thao tác màn hình:** mở [`../README.md`](../README.md) phần *Architecture* và chiếu:

```
Hermes Agent (dashboard :3000) ──► Honcho API (:8000)
                                        │
                              ┌─────────┴─────────┐
                              ▼                   ▼
                        PostgreSQL(pgvector)    Redis(cache)
                              ▲
                              │
                        Honcho Deriver (worker nền)
```

| Service | Vai trò |
|---------|---------|
| **hermes-agent** | Dashboard chat + bộ não hành động |
| **honcho-api** | API bộ nhớ (lưu message, trả context/insight) |
| **honcho-deriver** | Worker nền — suy luận, cập nhật representation |
| **PostgreSQL + pgvector** | Lưu message + tìm kiếm ngữ nghĩa (vector) |
| **Redis** | Cache + hàng đợi tác vụ cho deriver |

> 📌 Ghi nhớ 2 điều sẽ gặp lại khi deploy:
> 1. **Deriver không có HTTP server** → không đặt healthcheck HTTP cho nó (sẽ fail deploy).
> 2. Honcho (SQLAlchemy) cần URL Postgres dạng `postgresql+psycopg://...`; entrypoint tự chuyển
>    đổi từ `DATABASE_URL` của Railway. *(Chi tiết Module 06/07.)*

### 5. Hermes "nói chuyện" với Honcho thế nào?

Trong repo, Hermes chọn Honcho làm memory provider qua config:
```yaml
# hermes/config.yaml
memory:
  provider: honcho
```
và kết nối bằng biến môi trường `HONCHO_BASE_URL` (+ `HONCHO_API_KEY` nếu bật auth).

Khi active, Hermes có thêm các **công cụ Honcho**: `honcho_profile`, `honcho_search`,
`honcho_context`, `honcho_reasoning`, `honcho_conclude` — và bộ lệnh `hermes honcho ...`.
*(Ta dùng thật ở [Module 09](./09-kiem-chung-bo-nho-honcho.md) và tinh chỉnh ở [Module 16](./16-honcho-nang-cao.md).)*

---

## ⚠️ Hiểu lầm thường gặp
| Hiểu lầm | Sự thật |
|----------|---------|
| "Honcho chỉ là database lưu chat" | Không — nó *suy luận* và *mô hình hóa* người dùng, không chỉ lưu. |
| "Suy luận nền làm chat bị chậm" | Không — deriver chạy bất đồng bộ, tách khỏi đường chat. |
| "Chỉ người dùng mới là peer" | Cả agent cũng là peer → hỗ trợ multi-agent, tách ngữ cảnh. |
| "Không có Redis/Postgres vẫn chạy" | Không — Honcho cần Postgres(pgvector) + Redis. |

## ✅ Checklist học viên
- [ ] Định nghĩa Workspace/Peer/Session/Message.
- [ ] Giải thích Deriver và Representation.
- [ ] Nói được *dialectic/chat* khác truy vấn thường ở chỗ nào.
- [ ] Vẽ lại được sơ đồ 5 service.

## 🧠 Tổng kết
Honcho = *bộ nhớ hiểu người*. Lưu (đồng bộ): Workspace→Peer→Session→Message. Hiểu (bất đồng bộ):
Deriver → Representation + Dialectic. Repo triển khai 5 service; Hermes gắn Honcho qua
`memory.provider: honcho` + `HONCHO_BASE_URL`. Đây chính là thứ khiến trợ lý "càng dùng càng hiểu bạn".

## ➡️ Tiếp theo
[Module 04 — Bảo mật & guardrails (đọc trước khi deploy)](./04-bao-mat-va-guardrails.md)
