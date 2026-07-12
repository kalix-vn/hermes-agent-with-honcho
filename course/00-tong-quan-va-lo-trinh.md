# Module 00 — Tổng quan & cách dùng bộ kịch bản

> **Thời lượng:** ~8 phút · **Mức độ:** Cơ bản
> **Mục tiêu:** Giúp học viên biết khóa học đi tới đâu, cần chuẩn bị gì, và cách dùng bộ kịch bản này.
> **Yêu cầu trước:** Không.

## 🎯 Kết quả sau bài học
- Nắm được **bức tranh tổng thể**: cuối khóa sẽ có một AI assistant tự host, có bộ nhớ Honcho.
- Biết **hai con đường triển khai** (Docker local / Railway) và chọn được con đường phù hợp.
- Hiểu **quy ước trình bày** để theo dõi các module sau không bị lạc.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Chào mừng đến với khóa Hermes Agent + Honcho. Khác với các tutorial chỉ dựng một
chatbot rồi thôi, ở đây chúng ta dựng một **trợ lý AI thật sự có trí nhớ** — nó nhớ bạn là ai,
bạn thích gì, đã nói gì với nó tuần trước, kể cả khi server khởi động lại. Bí quyết nằm ở
**Honcho** — tầng bộ nhớ mà chúng ta sẽ ghép vào Hermes. Cuối khóa bạn sẽ tự tay dựng, cấu hình,
kết nối Gmail/Telegram, và cho nó chạy các tác vụ tự động mỗi ngày."

〔Nói〕 "Mình sẽ đi **từ số 0**. Bạn không cần biết code. Nhưng bạn sẽ gõ vài lệnh — mình giải
thích từng lệnh làm gì, nên đừng lo."

---

## 🪜 Nội dung bài học

### 1. Cuối khóa trông như thế nào? (demo mở màn)

〔Nói〕 "Trước khi đi vào chi tiết, đây là kết quả cuối cùng."

**Thao tác màn hình:** Mở dashboard Hermes đã chạy sẵn, gõ vào chat:
> "Tuần trước tôi có nói tôi đang học tiếng Nhật, bạn còn nhớ không?"

và cho agent trả lời đúng — chứng minh **trí nhớ xuyên phiên** (đây là điều Honcho mang lại).

`【SCREENSHOT: dashboard trả lời đúng thông tin từ phiên cũ】`

> 💡 Đây là "wow moment" nên đặt ngay đầu khóa để tạo động lực. Nếu bạn chưa có hệ thống chạy
> sẵn để quay demo, có thể quay đoạn này **sau** khi hoàn thành module 09 rồi chèn vào đầu.

### 2. Hai thành phần, hai vai trò

| Thành phần | Vai trò | Ẩn dụ |
|-----------|---------|-------|
| **Hermes Agent** | Bộ não hành động: gọi LLM, dùng skills/tools, chạy cron, có dashboard | "Đôi tay & bộ kỹ năng" |
| **Honcho** | Tầng trí nhớ: mô hình hóa người dùng, suy luận biện chứng (dialectic), nhớ dài hạn | "Ký ức & sự thấu hiểu" |

〔Nói〕 "Hermes biết *làm*. Honcho giúp nó *hiểu và nhớ bạn*. Ghép lại thành một trợ lý càng
dùng càng hiểu bạn hơn."

### 3. Bản đồ khóa học (5 phần)

Mở [`README.md`](./README.md) chiếu mục lục:
- **A — Nền tảng** (00–04): hiểu khái niệm + bảo mật.
- **B — Triển khai** (05–08): dựng hệ thống.
- **C — Bộ nhớ Honcho** (09, 10, 16): điểm khác biệt.
- **D — Kết nối & tự động hóa** (11–15): làm cho nó hữu ích.
- **E — Vận hành** (17–19): làm chủ & mở rộng.

### 4. Chọn con đường triển khai

〔Nói〕 "Có hai cách dựng. Bạn chỉ cần **chọn một**."

| | **Docker local (Module 06)** | **Railway (Module 07)** |
|---|---|---|
| Phù hợp | Học/thử nghiệm trên máy mình | Chạy 24/7 trên cloud |
| Chi phí hạ tầng | Miễn phí (máy bạn) | Vài đô/tháng |
| Yêu cầu | Cài Docker | Tài khoản Railway |
| Chạy khi tắt máy? | Không | Có |

> 💡 Gợi ý: học viên mới nên **làm module 06 (Docker local) trước** để hiểu hệ thống, rồi mới
> lên Railway ở module 07 khi muốn chạy thật 24/7.

### 5. Cách đọc mỗi module

Chiếu nhanh phần "Quy ước dùng chung" trong README: mỗi module có 🎯 mục tiêu, 🪜 các bước,
⚠️ lỗi thường gặp, ✅ checklist. Học viên **vừa xem vừa mở file làm theo, tua lại thoải mái**.

---

## ✅ Checklist học viên
- [ ] Hiểu cuối khóa sẽ có gì (AI assistant có bộ nhớ Honcho).
- [ ] Phân biệt được vai trò Hermes vs Honcho.
- [ ] Đã chọn sơ bộ con đường triển khai (Docker hay Railway).
- [ ] Biết cách theo dõi các module (khung 🎯/🪜/⚠️/✅).

## 🧠 Tổng kết
Hermes = hành động; Honcho = trí nhớ. Khóa chia 5 phần, có 2 con đường deploy. Từ module sau
ta bắt đầu hiểu sâu từng mảnh trước khi bắt tay dựng.

## ➡️ Tiếp theo
[Module 01 — Hermes Agent là gì & tại sao dùng](./01-hermes-agent-la-gi.md)
