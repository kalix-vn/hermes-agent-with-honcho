# 🎙️ VO — Bài 15: Tác vụ định kỳ (Crons/Automations)

> **Thời lượng mục tiêu:** ~14 phút · **Tông giọng:** truyền cảm hứng "agent chủ động", thực tế về giá trị.
> **Kịch bản dạy học tương ứng:** [`../15-tu-dong-hoa-cron.md`](../15-tu-dong-hoa-cron.md)
> ⚠️ **Điều kiện:** đã kết nối Composio (Bài 14) để cron chạm được email/lịch.

---

## [00:00] MỞ MÀN — từ bị động sang chủ động

【B-ROLL: buổi sáng, điện thoại rung — một bản tin tóm tắt tự động hiện lên trước khi bạn kịp hỏi】

〔Đọc〕
"Từ đầu khóa tới giờ, agent của bạn vẫn **bị động** — nó ngồi im chờ bạn nhắn rồi mới làm. Hữu ích,
nhưng chưa 'sống'.

Bài này ta lật ngược điều đó. Ta cho agent **chủ động** — tự làm việc theo lịch, mà bạn không phải
ra lệnh mỗi lần. Bảy giờ sáng nó tự lọc email và gửi bạn bản tóm tắt. Chủ nhật nó tự kiểm tra bảo
mật. Đây chính là lúc agent thật sự **'chạy giúp bạn hai tư trên bảy'**. Công cụ để làm điều đó gọi
là **cron**. Bắt đầu."

【MÀN HÌNH: Title card — "Bài 15 · Tác vụ định kỳ (Cron)"】

---

## [00:50] BƯỚC 1 — Cron đầu tiên: email triage mỗi sáng

【THAO TÁC: gửi prompt tạo cron email triage】

〔Đọc〕
"Điều tuyệt vời là: bạn tạo cron **hoàn toàn bằng lời**, không đụng file, không viết code. Mình gõ
cho agent:

_'Tạo một tác vụ định kỳ email triage. Chạy mỗi ngày bảy giờ sáng: đọc tất cả email trong hai mươi
tư giờ qua, lọc ra những gì quan trọng hoặc có action item, và gửi cho mình một bản tóm tắt ngắn
gọn, gọn gàng, ngay trong khung chat này.'_

_(gửi, chờ agent tạo)_

Agent tạo cron, và thường nó còn **chạy thử một lần luôn** để bạn xem mẫu output ra sao. Rất tiện —
bạn thấy ngay kết quả trước khi chờ đến sáng mai."

【MÀN HÌNH: agent xác nhận đã tạo cron email triage + output mẫu】

---

## [02:40] BƯỚC 2 — Cron thứ hai: security audit Chủ nhật

【THAO TÁC: gửi prompt tạo cron security audit】

〔Đọc〕
"Tạo thêm một cái nữa cho quen tay — lần này là kiểm tra bảo mật hàng tuần. Mình gõ:

_'Tạo tác vụ chạy mỗi Chủ nhật lúc không giờ: kiểm tra hệ thống xem có hoạt động bất thường không,
và gửi mình báo cáo kèm gợi ý cải thiện bảo mật.'_

Vậy là bạn vừa có một 'nhân viên an ninh' làm việc mỗi cuối tuần, hoàn toàn tự động. Để ý là ta chỉ
mô tả bằng ngôn ngữ đời thường — agent tự hiểu và tự đặt lịch."

---

## [04:00] BƯỚC 3 — Xem và xác minh cron

〔Đọc〕
"Sau khi tạo, tự nhiên bạn muốn kiểm chứng: 'cron của mình lưu ở đâu, có thật không?'. Cron được lưu
dưới dạng một file, và có **ba cách** để xem."

【MÀN HÌNH: mở repo GitHub → cron/jobs.json】

〔Đọc〕
"Cách một, nếu bạn đã bật backup GitHub ở Bài 12: mở repo lên, tìm file `cron/jobs.json`. Trong đó
bạn thấy rõ prompt của từng job và lịch chạy của nó.

Cách hai, qua shell: `docker compose exec hermes sh`, rồi tìm file cron trong thư mục dữ liệu của
Hermes — thường là ở `$HERMES_HOME/cron/jobs.json`.

Cách ba, nếu bản dashboard của bạn có mục **Crons** hoặc **Tasks**, nó liệt kê sẵn các job cho bạn
xem."

【MÀN HÌNH: nội dung cron/jobs.json — lịch và prompt của job】

---

## [05:40] BƯỚC 4 — Chỉnh sửa cron bằng lời

【THAO TÁC: gửi lệnh chỉnh cron email triage】

〔Đọc〕
"Đây là chỗ mình thích nhất. Muốn đổi giờ, đổi nội dung — bạn **không cần sờ vào file**. Cứ nói.

Ví dụ mình muốn bản tin sáng đến sớm hơn và thêm mục việc cần làm. Mình gõ:

_'Đổi email triage sang sáu giờ ba mươi sáng, và thêm phần top ba việc cần làm hôm nay vào cuối
tóm tắt.'_

Agent cập nhật cron ngay. Và nếu bạn đã bật auto-commit ở Bài 12, nó còn **tự backup** thay đổi này
luôn. Sửa cron mà nhẹ như nhắn tin cho bạn bè."

---

## [07:20] BƯỚC 5 — Ngân hàng ý tưởng cron

【MÀN HÌNH: bảng 5 ý tưởng cron cuộn nhẹ】

〔Đọc〕
"Để bạn có cảm hứng, đây là vài ý tưởng cron mình thấy đáng làm.

**Morning brief** — gom nhiều nguồn thành các action item buổi sáng; cần Gmail, Calendar.

**Kế toán tự động** — email nào là hóa đơn thì tự lưu vào Drive, thư mục receipts; cần Gmail và
Drive.

**Tối ưu lịch** — xem lịch, gợi ý sắp xếp, chèn block tập thể dục, ăn uống, và focus; cần Calendar.

**Daily wrap-up** — cuối ngày tổng kết đã làm gì, hoàn thành gì, cải thiện gì.

**Habit tracker hoặc học ngoại ngữ** — mỗi ngày dạy năm từ mới kèm quiz, đúng định dạng bạn muốn;
cái này thậm chí không cần kết nối gì."

〔Đọc〕
"Mình muốn nói thẳng một điều, như đã hứa từ đầu khóa: cái này **không phải phép màu** làm bạn giàu
sau một đêm. Nhưng nếu đặt đúng, nó tiết kiệm cho bạn **rất nhiều thời gian mỗi ngày**. Chìa khóa
nằm ở chỗ: **biết bạn muốn tự động hóa cái gì.**"

---

## [09:40] BƯỚC 6 — Vì sao cron ở đây "thông minh" hơn

【MÀN HÌNH: sơ đồ vòng lặp — Cron chạy → bạn phản hồi → agent cập nhật skill + Honcho ghi sở thích】

〔Đọc〕
"Và đây là điều khiến cron ở khóa này khác hẳn cron thông thường. Cron bình thường thì chạy y một
kiểu mãi mãi. Còn ở đây:

Mỗi lần cron chạy và bạn phản hồi — kiểu 'ngắn hơn nữa đi', hoặc 'thêm mục này vào' — thì hai chuyện
xảy ra. Một, agent **học** và tự **cập nhật skill** của chính nó. Hai, **Honcho** ghi nhớ sở thích
định dạng của bạn.

Kết quả? Bản tin sáng **tuần sau** sẽ hợp ý bạn hơn tuần này — **tự động**, không cần bạn nhắc lại.
Nó càng chạy càng vừa vặn với bạn. Đó là sức mạnh của cron cộng Honcho cộng self-improvement."

---

## [11:20] LỖI HAY GẶP — điểm nhanh

【MÀN HÌNH: bảng lỗi thường gặp】

〔Đọc〕
"Vài lỗi hay gặp.

Cron chạy nhưng **không đọc được email** — nghĩa là chưa nối Composio hoặc thiếu quyền; quay lại
hoàn tất Bài 14.

Cron **không kích hoạt đúng giờ** — thường do sai múi giờ; nói rõ ra, ví dụ 'bảy giờ giờ Việt Nam',
và kiểm tra lại trong `jobs.json`.

Output **quá dài hoặc lệch ý** — prompt cron còn mơ hồ; chỉnh bằng lời cho rõ định dạng, độ dài, các
mục cần có.

Và quan trọng: agent bản **local** — Docker trên máy bạn — sẽ **không chạy khi bạn tắt máy**. Muốn
cron chạy thật hai tư trên bảy, bạn cần đưa lên **Railway** như ở Bài 07."

---

## [12:40] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 15 tick xanh + nút "Bài tiếp: Honcho nâng cao"】

〔Đọc〕
"Tóm lại: cron biến agent từ bị động thành **chủ động**. Tạo và sửa hoàn toàn bằng lời, lưu ở
`cron/jobs.json`. Kết hợp Composio để làm việc thật, cộng Honcho, cộng self-improvement — các bản
tin định kỳ ngày càng hợp ý bạn. Nhớ: muốn chạy thật hai tư trên bảy thì cần bản Railway.

Bây giờ agent đã có trí nhớ, làm việc thật, và chạy chủ động. Bài tiếp theo, ta mở **nắp capo** của
Honcho — học các 'núm vặn' để cân bằng giữa **chi phí** và **độ sâu suy luận**, và cấu hình cho
nhiều người dùng cùng lúc. Hẹn gặp ở bài mười sáu."

【[13:40] HẾT】

---

### 🎬 Ghi chú sản xuất
- B-roll mở màn (điện thoại rung sáng sớm nhận brief) là hình ảnh "chốt hạ" của bài — đầu tư quay đẹp.
- Đoạn [09:40] vòng lặp tự cải thiện nên minh họa bằng sơ đồ động — đây là điểm bán hàng lớn nhất của cron.
- Khi quay `cron/jobs.json`, che nội dung email thật nếu output mẫu có dữ liệu cá nhân.
- Đọc "hai tư trên bảy" thống nhất với các bài khác (không đọc "24/7" kiểu tiếng Anh).
