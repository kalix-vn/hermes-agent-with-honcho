# Module 14 — Kết nối công cụ thật với Composio

> **Thời lượng:** ~14 phút · **Mức độ:** Trung cấp
> **Mục tiêu:** Cho agent chạm vào các tài khoản thật (Gmail, Google Calendar, Notion…) qua
> **Composio** — một cổng kết nối duy nhất — và dạy nó chọn đúng công cụ.
> **Yêu cầu trước:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md), đã đọc bảo mật [Module 04](./04-bao-mat-va-guardrails.md)

## 🎯 Kết quả sau bài học
- Tạo tài khoản Composio và kết nối **Gmail + Google Calendar** (least-privilege).
- Kết nối Composio vào Hermes và ra lệnh thao tác email/lịch thật.
- Dạy agent **ưu tiên đúng skill** (Composio) khi làm việc với các tài khoản đó.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Agent chỉ thật sự hữu ích khi **làm được việc thật**: soạn email, xem lịch, lưu hóa đơn.
Thay vì tích hợp từng dịch vụ, ta dùng **Composio** — một cổng kết nối tới hàng nghìn app. Bạn kết
nối tài khoản ở dashboard Composio, rồi nối Composio vào Hermes một lần."

> ⚠️ **Bảo mật trước hết:** đây là lúc bạn trao quyền chạm dữ liệu thật. Áp dụng least-privilege
> (Module 04): cân nhắc dùng **tài khoản riêng/burner** khi học, và bắt đầu với quyền đọc.

---

## 🪜 Các bước thực hiện

### Bước 1 — Tạo tài khoản Composio

**Thao tác:** mở <https://app.composio.dev> (dashboard) → tạo tài khoản free.

〔Nói〕 "Composio free cho ~20.000 tool calls/tháng — quá đủ để học và dùng cá nhân."

### Bước 2 — Kết nối app (Connect Apps)

**Thao tác:** Composio → **Connect Apps** → tìm **Gmail** → **Connect** → đăng nhập tài khoản
Google (nên dùng **burner** khi học) → cấp quyền.
- Lặp lại cho **Google Calendar** (có thể cùng tài khoản).

〔Nói〕 "Cấp đủ quyền ở Composio là an toàn vì bạn **giới hạn công cụ nào agent được dùng ở bước
sau**. Bạn có thể nối **nhiều** tài khoản (nhiều email, nhiều Drive…)."

`【SCREENSHOT: Composio đã kết nối Gmail + Google Calendar, hiện danh sách tool】`

### Bước 3 — Lấy hướng dẫn cài đặt cho agent

**Thao tác:** Composio → **Install** → tìm mục **OpenClaw** (Hermes tương thích với hướng dẫn kiểu
OpenClaw) → **copy** đoạn hướng dẫn/cấu hình.

> 💡 Không có mục dành riêng "Hermes"? Dùng hướng dẫn **OpenClaw** — về cơ bản cùng cơ chế.

### Bước 4 — Nối Composio vào Hermes

**Thao tác (từ dashboard/Telegram):** dán đoạn hướng dẫn và nói:
> "Hãy chạy các bước sau để **kết nối mình với Composio**: [dán hướng dẫn]. Giúp mình đăng nhập
> Composio."

Agent sẽ đưa một **URL để authorize** → mở URL → **Authorize** → quay lại chat báo "đã approve".
Mong đợi: agent xác nhận **"Composio connected"**.

`【SCREENSHOT: agent báo Composio đã kết nối】`

### Bước 5 — Thử thao tác thật

**Thao tác:** thử một lệnh đọc (an toàn nhất trước):
> "Cho mình xem tiêu đề **2 email gần nhất** trong hộp thư."

Rồi thử lịch:
> "Tạo giúp mình một sự kiện lịch tên 'Học Hermes' vào 20h tối nay."

`【SCREENSHOT: agent liệt kê email / tạo event lịch】`

### Bước 6 — Dạy agent chọn đúng skill (rất quan trọng)

〔Nói〕 "Lúc đầu agent có thể dùng nhầm skill — vd. cố dùng 'Google Workspace skill' trong khi nên
dùng 'Composio skill'. Ta dạy nó."

**Thao tác:** gửi:
> "**Từ nay, mỗi khi cần thao tác email/lịch, hãy dùng Composio** (không dùng skill khác). Ghi nhớ
> ưu tiên này."

Nhờ vòng self-improvement + Honcho, agent sẽ ghi nhớ ưu tiên này cho lần sau.

> 💡 Nếu Composio báo "Gmail not linked" dù đã nối → agent thường đưa một **link để link lại**;
> bấm vào là xong. Đây là trục trặc kết nối lần đầu hay gặp, không phải lỗi của bạn.

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| "Gmail not linked" | Kết nối lần đầu chưa hoàn tất | Bấm link re-link mà agent đưa |
| Agent dùng nhầm skill | Chưa được dạy ưu tiên | Ra lệnh "luôn dùng Composio cho email/lịch" |
| Không authorize được | Sai tài khoản/chặn popup | Mở đúng URL, đăng nhập đúng tài khoản |
| Lo ngại quyền quá rộng | Chưa giới hạn tool | Tắt bớt tool trong Composio; bắt đầu read-only |

## ✅ Checklist học viên
- [ ] Có tài khoản Composio, kết nối Gmail + Calendar.
- [ ] Nối Composio vào Hermes (agent báo connected).
- [ ] Thực hiện được 1 thao tác đọc (email) và 1 thao tác ghi (tạo event).
- [ ] Đã dạy agent ưu tiên Composio cho email/lịch.

## 🧠 Tổng kết
Composio = một cổng nối tới mọi app. Kết nối ở dashboard Composio, nối vào Hermes một lần, rồi ra
lệnh bằng lời. Nhớ least-privilege + dạy agent chọn đúng skill. Giờ agent làm được **việc thật** —
sẵn sàng để tự động hóa theo lịch.

## ➡️ Tiếp theo
[Module 15 — Tác vụ định kỳ (Crons/Automations)](./15-tu-dong-hoa-cron.md)
