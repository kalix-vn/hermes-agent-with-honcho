# Module 10 — Onboarding: User & Soul (persona của agent)

> **Thời lượng:** ~12 phút · **Mức độ:** Cơ bản
> **Mục tiêu:** Dạy agent hiểu *bạn là ai* (user) và định hình *tính cách nó* (soul) chỉ bằng lời
> nói tự nhiên — không sửa file tay.
> **Yêu cầu trước:** [Module 09](./09-kiem-chung-bo-nho-honcho.md)

## 🎯 Kết quả sau bài học
- Viết được một **prompt onboarding** giới thiệu bản thân + mục tiêu.
- Điều chỉnh **soul** của agent (giọng điệu, độ dài, phong cách) bằng lời.
- Hiểu user/soul phối hợp với Honcho ra sao để cá nhân hóa.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Lần đầu dùng, hãy 'giới thiệu bản thân' cho agent: bạn là ai, làm gì, muốn nó cư xử thế
nào. Bạn **không cần sửa file** — chỉ cần nói, agent tự cập nhật `user.md`, `soul.md` và ghi vào
Honcho. Càng rõ ràng, cá nhân hóa càng tốt."

---

## 🪜 Các bước thực hiện

### Bước 1 — Prompt onboarding (giới thiệu bản thân + mục tiêu)

**Thao tác:** gửi một tin nhắn giới thiệu. Đây là **mẫu để học viên tùy biến**:

> "Chào, mình tên **Minh**. Cứ gọi mình là Minh. Mình làm **kỹ sư phần mềm**, quan tâm **AI, Python,
> tự động hóa công việc**. Mục tiêu khi dùng bạn: giúp mình quản lý email, lịch, và tạo digest
> hằng ngày. Hãy cập nhật hiểu biết về mình cho phù hợp."

〔Nói〕 "Bạn đang rambling một chút cũng không sao — cứ nói tự nhiên. Agent sẽ trích thông tin,
lưu vào memory và Honcho."

`【SCREENSHOT: agent xác nhận đã cập nhật user profile】`

### Bước 2 — Định hình Soul (tính cách/giọng điệu)

**Thao tác:** gửi yêu cầu chỉnh soul. Mẫu:

> "Hãy cập nhật **soul.md** của bạn: luôn **ngắn gọn, đi thẳng vấn đề, mang tính giáo dục**. Đừng
> vòng vo. Khi làm gì, hãy giải thích *tại sao* và các *bước* bạn theo, để mình học và debug được.
> Mình thích một trợ lý như một người thầy — súc tích chứ không dài dòng."

Agent sẽ xem skills, chỉnh soul và xác nhận.

〔Nói〕 "Soul là tính cách. Bạn muốn nghiêm túc hay hài hước, có emoji hay không, xưng hô ra sao —
tất cả nói ra là được. Có thể chỉnh lại bất cứ lúc nào."

`【SCREENSHOT: agent xác nhận đã cập nhật soul】`

### Bước 3 — Kiểm chứng persona đã ăn

**Thao tác:** hỏi một câu bất kỳ và quan sát:
> "Giải thích ngắn cho mình: prompt injection là gì?"

Mong đợi: câu trả lời **ngắn gọn, có cấu trúc, mang tính giáo dục** — đúng soul vừa đặt.

### Bước 4 — Hiểu user + soul + Honcho phối hợp

| Lớp | Lưu gì | Ai cập nhật |
|-----|--------|-------------|
| `user.md` | Sự thật về bạn (tên, nghề, sở thích) | Agent, khi bạn kể |
| `soul.md` | Cách agent cư xử | Agent, khi bạn yêu cầu |
| **Honcho** | *Mô hình suy luận* về bạn (phong cách, niềm tin, mục tiêu) — cập nhật liên tục | Deriver, tự động sau mỗi lượt |

〔Nói〕 "`user.md`/`soul.md` là ảnh chụp bạn *chủ động* khai báo. Honcho là phần *tự học ngầm* —
nó tinh chỉnh hiểu biết theo thời gian. Hai cái bổ trợ nhau."

### Bước 5 — (Khuyến nghị) Gieo 'identity' cho AI peer

Vì trong Honcho **cả agent cũng là peer**, bạn có thể gieo danh tính cho nó:
```bash
# trong shell của Hermes
hermes honcho identity      # gieo/định danh peer cho AI
hermes honcho peer          # xem/đổi tên peer
```
Việc này giúp Honcho tách bạch "quan sát về bạn" và "quan sát về agent" (observation mode). Chi
tiết ở [Module 16](./16-honcho-nang-cao.md).

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| Soul đổi nhưng câu trả lời vẫn dài dòng | Yêu cầu chưa rõ / model bỏ qua | Nêu cụ thể ("tối đa 5 câu", "gạch đầu dòng") |
| Agent nhớ nhầm thông tin cá nhân | Bạn kể mâu thuẫn ở nhiều phiên | Nói lại rõ, yêu cầu cập nhật; Honcho sẽ hòa giải |
| Không thấy tác dụng của onboarding | Onboarding quá chung chung | Cụ thể hóa mục tiêu + phong cách mong muốn |

## ✅ Checklist học viên
- [ ] Đã gửi prompt onboarding (bản thân + mục tiêu).
- [ ] Đã chỉnh soul và xác minh giọng điệu thay đổi.
- [ ] Giải thích được vai trò user.md vs soul.md vs Honcho.
- [ ] (Tùy chọn) Đã gieo identity cho AI peer.

## 🧠 Tổng kết
Dạy agent hiểu bạn bằng lời: onboarding (user) + chỉnh soul (persona). Honcho làm phần tự học
ngầm bên dưới. Bộ ba này biến trợ lý chung chung thành *trợ lý của riêng bạn*.

## ➡️ Tiếp theo
- Kết nối kênh nhắn tin: [Module 11 — Telegram](./11-ket-noi-telegram.md)
- (Hoặc học tinh chỉnh Honcho ngay) [Module 16 — Honcho nâng cao](./16-honcho-nang-cao.md)
