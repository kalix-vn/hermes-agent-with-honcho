# Module 15 — Tác vụ định kỳ (Crons/Automations)

> **Thời lượng:** ~14 phút · **Mức độ:** Trung cấp
> **Mục tiêu:** Biến agent thành **proactive** — tự chạy việc theo lịch (email triage, morning
> brief, security audit) chỉ bằng lời, và biết xem/sửa các cron đó.
> **Yêu cầu trước:** [Module 14](./14-ket-noi-cong-cu-composio.md) (để cron chạm được email/lịch)

## 🎯 Kết quả sau bài học
- Tạo được ít nhất 2 cron bằng ngôn ngữ tự nhiên.
- Biết cron được lưu ở đâu (`cron/jobs.json`) và kiểm tra được.
- Hiểu cron + Honcho + self-improvement giúp output ngày càng hợp ý bạn.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Đến giờ agent mới **reactive** — chờ bạn nhắn. Cron biến nó thành **proactive**: tự làm
việc theo lịch mà không cần bạn ra lệnh mỗi lần. Đây là lúc nó thật sự 'chạy giúp bạn 24/7'."

---

## 🪜 Các bước thực hiện

### Bước 1 — Tạo cron #1: Email triage mỗi sáng 7h

**Thao tác:** gửi prompt (tùy biến theo nhu cầu):
> "Tạo một **tác vụ định kỳ email triage**. Chạy **mỗi ngày 7:00 sáng**: đọc tất cả email trong
> **24h qua**, lọc ra những gì quan trọng / có action item, và gửi cho mình một **bản tóm tắt ngắn
> gọn, gọn gàng** ngay trong khung chat này."

Agent tạo cron, thường **chạy thử một lần** để bạn xem mẫu output.

`【SCREENSHOT: agent xác nhận đã tạo cron email triage】`

### Bước 2 — Tạo cron #2: Security audit Chủ nhật

**Thao tác:**
> "Tạo tác vụ chạy **mỗi Chủ nhật 00:00**: kiểm tra hệ thống xem có hoạt động bất thường không, và
> gửi mình báo cáo kèm gợi ý cải thiện bảo mật."

### Bước 3 — Xem & xác minh cron đã tạo

Cron được lưu dạng file. **Cách xem:**
- **Qua GitHub backup** (nếu đã bật Module 12): mở repo → `cron/jobs.json` → thấy prompt + lịch chạy.
- **Qua shell:** 
  ```bash
  docker compose exec hermes sh
  # tìm file cron trong thư mục dữ liệu Hermes (vd. $HERMES_HOME/cron/jobs.json)
  ```
- **Qua dashboard:** mục **Crons/Tasks** (nếu có) liệt kê các job.

`【SCREENSHOT: cron/jobs.json với lịch và prompt của job】`

### Bước 4 — Chỉnh sửa cron bằng lời

〔Nói〕 "Không cần sửa file tay. Muốn đổi giờ/nội dung, cứ nói."
> "Đổi email triage sang **6:30 sáng** và thêm phần 'top 3 việc cần làm hôm nay' vào cuối tóm tắt."

Agent cập nhật cron (và tự backup nếu đã bật auto-commit).

### Bước 5 — Ngân hàng ý tưởng cron (gợi ý cho học viên)

| Cron | Mô tả | Cần kết nối |
|------|-------|-------------|
| **Morning brief / digest** | Gom nhiều nguồn → action item buổi sáng | Gmail/Calendar/… |
| **Kế toán tự động** | Email mới là hóa đơn → lưu vào Drive/thư mục receipts | Gmail + Drive |
| **Tối ưu lịch** | Xem lịch, gợi ý sắp xếp, chèn block tập/ăn/focus | Calendar |
| **Daily wrap-up** | Cuối ngày: đã làm gì, hoàn thành gì, cải thiện gì | (tùy) |
| **Habit tracker / học ngoại ngữ** | Mỗi ngày dạy 5 từ + quiz, đúng format bạn muốn | (không) |

〔Nói〕 "Đây không phải phép màu làm bạn giàu sau một đêm. Nhưng đặt đúng, nó tiết kiệm cho bạn
rất nhiều thời gian mỗi ngày. Chìa khóa là **biết bạn muốn tự động hóa cái gì**."

### Bước 6 — Vì sao cron ở khóa này "thông minh" hơn

〔Nói〕 "Mỗi lần cron chạy và bạn phản hồi ('ngắn hơn nữa', 'thêm mục này'), agent **học** và
**cập nhật skill** của chính nó, còn **Honcho** ghi nhớ sở thích định dạng của bạn. Nên bản tin
sáng tuần sau sẽ hợp ý bạn hơn tuần này — tự động."

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| Cron chạy nhưng không đọc được email | Chưa kết nối Composio hoặc thiếu quyền | Hoàn tất [Module 14](./14-ket-noi-cong-cu-composio.md) |
| Cron không kích hoạt đúng giờ | Sai múi giờ | Nêu rõ múi giờ ("7:00 giờ VN"); kiểm tra `jobs.json` |
| Output quá dài/lệch ý | Prompt cron mơ hồ | Chỉnh bằng lời: định dạng, độ dài, mục cần có |
| Agent (bản local) không chạy khi tắt máy | Docker local không 24/7 | Chuyển lên Railway ([Module 07](./07-trien-khai-railway.md)) |

## ✅ Checklist học viên
- [ ] Tạo được ≥2 cron bằng lời.
- [ ] Xem được cron trong `cron/jobs.json` (qua GitHub/shell/dashboard).
- [ ] Chỉnh sửa được cron bằng lời.
- [ ] Có ít nhất 1 cron thực sự hữu ích cho công việc của mình.

## 🧠 Tổng kết
Cron biến agent thành proactive. Tạo/sửa bằng lời, lưu ở `cron/jobs.json`. Kết hợp Composio (làm
việc thật) + Honcho + self-improvement, các bản tin định kỳ ngày càng hợp ý bạn. Muốn chạy thật
24/7 thì cần bản Railway.

## ➡️ Tiếp theo
[Module 16 — Honcho nâng cao: tinh chỉnh & multi-agent](./16-honcho-nang-cao.md)
