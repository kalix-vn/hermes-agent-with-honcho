# 🎙️ VO — Bài 09: "Trí nhớ xuyên phiên" (Wow moment)

> **Thời lượng mục tiêu:** ~12 phút · **Tông giọng:** hào hứng nhưng chắc chắn — đây là bài "chứng minh giá trị".
> **Kịch bản dạy học tương ứng:** [`../09-kiem-chung-bo-nho-honcho.md`](../09-kiem-chung-bo-nho-honcho.md)
> ⚠️ **Điều kiện:** hệ thống đã chạy (Bài 06 hoặc 07) và đăng nhập được dashboard (Bài 08).

---

## [00:00] MỞ MÀN — đặt cược

【MÀN HÌNH: dashboard Hermes đang mở, sạch sẽ】

〔Đọc〕
"Từ đầu khóa mình cứ nói 'Honcho cho agent trí nhớ thật'. Bài này mình sẽ **không bắt bạn tin** —
mình sẽ _chứng minh_ ngay trước mặt bạn.

Đây là phép thử: mình sẽ kể cho agent vài điều về bản thân. Rồi mình **mở một phiên hoàn toàn mới**
— coi như một cuộc trò chuyện khác, một ngày khác. Và mình sẽ hỏi lại. Nếu nó nhớ đúng, nghĩa là
Honcho đang làm việc. Bắt đầu."

---

## [00:45] BƯỚC 1 — Xác nhận Honcho đang chạy

【THAO TÁC: mở shell vào Hermes】
【MÀN HÌNH: gõ `docker compose exec hermes sh` rồi `hermes honcho status`】

〔Đọc〕
"Đầu tiên, kiểm tra Honcho có thật sự là bộ nhớ đang hoạt động không. Mình mở một cửa sổ dòng lệnh
vào Hermes, rồi gõ: `hermes honcho status`.

_(chờ output)_

Đây rồi. Nó hiện thông tin kết nối — địa chỉ Honcho, peer, các thông số. Một mẹo nhỏ: bộ lệnh
`hermes honcho` này **chỉ xuất hiện khi Honcho đang bật**. Nếu bạn không thấy nó, quay lại kiểm tra
provider bộ nhớ ở Bài 06 hoặc 07. Còn thấy rồi thì ta yên tâm đi tiếp."

【MÀN HÌNH: khoanh vùng dòng "base URL" và "peer" trong output】

---

## [02:00] BƯỚC 2 — Nạp thông tin (Phiên 1)

【THAO TÁC: quay lại dashboard, gõ tin nhắn】

〔Đọc〕
"Giờ mình 'gieo' vài thông tin đặc trưng, dễ kiểm chứng. Mình gõ:

_'Ghi nhớ giúp tôi nhé: tôi tên Minh, đang học tiếng Nhật trình độ N4, và tôi thích được giải
thích ngắn gọn kèm ví dụ.'_

_(gửi, chờ agent xác nhận)_

Agent xác nhận. Nhưng đây mới là phần hay: **ngay lúc này**, ở phía sau, một tiến trình tên
**Deriver** đang bắt đầu nghiền ngẫm câu vừa rồi để cập nhật 'chân dung' về mình. Và nó làm việc đó
**bất đồng bộ** — nghĩa là không hề làm chậm cuộc trò chuyện của chúng ta."

---

## [03:30] BƯỚC 3 — Nhìn Deriver làm việc (bằng chứng kỹ thuật)

【THAO TÁC: mở cửa sổ log deriver】
【MÀN HÌNH: `docker compose logs -f deriver` — thấy dòng xử lý task xuất hiện】

〔Đọc〕
"Bạn không phải tin lời mình. Nhìn này — mình mở log của Deriver: `docker compose logs -f deriver`.

_(chờ dòng log)_

Thấy chưa? Ngay sau khi mình gửi tin, Deriver nhận một tác vụ và bắt đầu suy luận. Đây chính là lúc
Honcho biến 'một câu chat' thành 'hiểu biết về Minh'. Nó không lưu _câu chữ_ — nó xây _mô hình_."

---

## [05:00] BƯỚC 4 — PHÉP THỬ QUYẾT ĐỊNH: Phiên mới

〔Đọc〕
"Đây là khoảnh khắc quan trọng nhất của cả khóa. Mình sẽ tạo một **phiên hoàn toàn mới**. Với một
bộ nhớ thường, phiên mới nghĩa là _tờ giấy trắng_ — quên hết.

Mình tạo phiên mới. _(chọn cách bạn dùng: bắt đầu cuộc trò chuyện mới, hoặc nhắn từ Telegram, hoặc
để qua ngưỡng reset.)_"

【THAO TÁC: mở phiên mới / nhắn từ Telegram】
【MÀN HÌNH: rõ ràng cho thấy đây là phiên khác】

〔Đọc〕
"Rồi. Đây là ngữ cảnh mới tinh. Bây giờ mình hỏi:

_'Bạn còn nhớ tôi đang học ngoại ngữ nào, ở trình độ nào không? Và tôi thích được giải thích theo
cách nào?'_

_(gửi, giữ nhịp — đây là lúc hồi hộp)_"

---

## [06:40] KHOẢNH KHẮC "WOW"

【MÀN HÌNH: zoom vào câu trả lời của agent — highlight "tiếng Nhật", "N4", "ngắn gọn kèm ví dụ"】

〔Đọc〕
"Và... đây rồi. Nó trả lời: tiếng Nhật, trình độ N4, thích ngắn gọn kèm ví dụ. **Chính xác.** Dù
đây là một phiên khác hoàn toàn.

Dừng lại một giây để thấy điều này _lớn_ cỡ nào. Đây không phải nó cuộn lại lịch sử chat — lịch sử
đó thuộc phiên cũ, đã đóng. Nó nhớ vì **Honcho đã mô hình hóa mình** và truy xuất lại đúng lúc cần.

Đây là khác biệt giữa 'một chatbot' và 'một trợ lý thật sự biết bạn'."

---

## [08:00] BƯỚC 5 — Đào sâu: nhờ Honcho 'phân tích' bạn

【THAO TÁC: gõ tin nhắn dùng suy luận Honcho】

〔Đọc〕
"Ta đẩy xa hơn chút. Honcho không chỉ nhớ dữ kiện — nó **suy luận**. Mình hỏi:

_'Dựa trên những gì bạn biết về tôi, hãy mô tả phong cách học và giao tiếp của tôi.'_

_(gửi)_

Để ý — agent gọi một công cụ tên `honcho_reasoning` hoặc `honcho_profile`. Nó không bịa; nó tổng
hợp từ chân dung mà Deriver đã dựng. Câu trả lời không chỉ lặp lại điều mình nói, mà _diễn giải_ —
kiểu 'bạn có xu hướng thích thông tin súc tích, ưu tiên ví dụ thực tế hơn lý thuyết dài dòng'."

【MÀN HÌNH: chỉ vào chỗ agent gọi công cụ honcho_*】

〔Đọc〕
"Đó là 'dialectic' — suy luận biện chứng. Đây là thứ Honcho làm mà một kho lưu trữ thường không
bao giờ làm được."

---

## [09:40] GIẢI THÍCH NHANH: vì sao nó hoạt động

【MÀN HÌNH: sơ đồ đơn giản — Message → (đồng bộ) lưu → Deriver (bất đồng bộ) → Representation → Chat】

〔Đọc〕
"Tua nhanh 'hậu trường' để bạn nắm bản chất.

Khi bạn nhắn: tin được **lưu ngay** — đồng bộ, nhanh. Song song, một tác vụ được xếp hàng cho
**Deriver**. Deriver chạy nền, cập nhật cái gọi là **representation** — một 'ảnh chụp' về bạn. Và
khi bạn hỏi, Honcho dùng ảnh chụp đó, cộng khả năng suy luận, để trả lời.

Lưu thì tức thời. Hiểu thì diễn ra ngầm. Đó là lý do chat không bao giờ bị chậm dù Honcho vẫn 'suy
nghĩ' liên tục về bạn."

---

## [11:00] Ý NGHĨA THỰC TẾ

〔Đọc〕
"Vậy điều này đổi gì cho bạn trong đời thực? Nhớ ở Bài 08 mình nói reset session để tiết kiệm chi
phí không? Giờ bạn hiểu vì sao _yên tâm_ reset: ký ức quan trọng **không nằm trong phiên** — nó nằm
trong Honcho. Reset phiên giúp gọn ngữ cảnh, giảm tiền, mà **không mất trí nhớ dài hạn**.

Và càng dùng, chân dung của bạn càng đầy. Bản tin sáng tuần sau sẽ hợp ý bạn hơn tuần này — tự
động. Đó là nền cho mọi thứ ta xây ở các bài sau."

---

## [11:45] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 09 tick xanh + nút "Bài tiếp: Onboarding User & Soul"】

〔Đọc〕
"Vậy là ta đã _chứng minh_ chứ không chỉ _nói_: `honcho status` chạy, Deriver suy luận, và phiên
mới nhớ đúng thông tin phiên cũ. Trí nhớ là thật.

Ở bài tiếp theo, thay vì để agent tự học ngầm, ta sẽ **chủ động dạy** nó hiểu bạn nhanh hơn — qua
onboarding và tinh chỉnh 'soul', tức tính cách của nó. Hẹn gặp ở bài mười."

【[12:15] HẾT】

---

### 🎬 Ghi chú sản xuất
- **Quay bài này sớm** để lấy 20–30 giây "wow" (mục [06:40]) chèn làm hook Bài 00.
- Giữ **nhịp hồi hộp** ở [05:00]–[06:40]: đừng cắt vội, để khán giả "chờ cùng".
- Nếu phiên mới lỡ _không_ nhớ khi quay: xem log deriver, đợi nó xử lý xong rồi hỏi lại — đừng cắt
  ghép giả kết quả (mất uy tín). Bảng lỗi trong file module 09 có cách xử lý.
- Dùng số liệu **cá nhân hóa của bạn** (tên thật, ngôn ngữ đang học…) để đoạn này chân thật hơn.
