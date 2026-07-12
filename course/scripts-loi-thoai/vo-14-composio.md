# 🎙️ VO — Bài 14: Kết nối công cụ thật với Composio

> **Thời lượng mục tiêu:** ~14 phút · **Tông giọng:** hứng khởi nhưng đề cao bảo mật, "trao quyền có kiểm soát".
> **Kịch bản dạy học tương ứng:** [`../14-ket-noi-cong-cu-composio.md`](../14-ket-noi-cong-cu-composio.md)
> ⚠️ **Điều kiện:** đã cấu hình dashboard (Bài 08); đã đọc bảo mật (Bài 04).

---

## [00:00] MỞ MÀN — từ "biết nói" đến "làm được việc"

【B-ROLL: agent soạn email, tạo event lịch — nhanh, mãn nhãn】

〔Đọc〕
"Một agent chỉ biết trò chuyện thì hay, nhưng chưa đủ. Agent thật sự hữu ích là khi nó **làm được
việc thật**: soạn email cho bạn, xem lịch giúp bạn, lưu hóa đơn hộ bạn.

Vấn đề là: chẳng lẽ ta tích hợp thủ công từng dịch vụ một? Không. Ta dùng **Composio** — một cổng
kết nối duy nhất tới **hàng nghìn** ứng dụng. Bạn nối tài khoản một lần ở Composio, rồi nối Composio
vào Hermes một lần. Xong, agent chạm được vào cả một thế giới công cụ. Bắt đầu."

【MÀN HÌNH: Title card — "Bài 14 · Kết nối công cụ thật với Composio"】

---

## [00:50] BẢO MẬT TRƯỚC — một lời nhắc nghiêm túc

〔Đọc〕
"Trước khi làm, mình dừng lại một chút vì đây là bước **nhạy cảm nhất** từ đầu khóa tới giờ. Đây là
lúc bạn trao cho agent quyền chạm vào **dữ liệu thật** — email thật, lịch thật của bạn.

Nên áp dụng đúng nguyên tắc Bài 04: **least-privilege**. Cụ thể: khi đang học, hãy cân nhắc dùng một
**tài khoản riêng — burner** — chứ đừng vội nối email chính. Và bắt đầu với quyền **đọc** trước,
quyền ghi tính sau. Cẩn thận lúc này, thoải mái về sau."

---

## [01:50] BƯỚC 1 — Tạo tài khoản Composio

【THAO TÁC: mở app.composio.dev, đăng ký free】

〔Đọc〕
"Mở trình duyệt, vào **app.composio.dev** — đó là dashboard của Composio. Tạo một tài khoản
**miễn phí**.

Nói về mức free một chút: nó cho bạn khoảng **hai mươi nghìn tool calls mỗi tháng**. Nghe con số có
vẻ lớn, và đúng là thế — **quá đủ** để học và dùng cá nhân. Bạn không cần trả tiền gì ở giai đoạn
này."

---

## [02:50] BƯỚC 2 — Kết nối app: Gmail + Calendar

【THAO TÁC: Composio → Connect Apps → tìm Gmail → Connect】

〔Đọc〕
"Trong Composio, vào mục **Connect Apps**. Tìm **Gmail**, bấm **Connect**. Nó sẽ đưa bạn qua màn
đăng nhập Google — nhớ lời khuyên nãy, khi học thì nên dùng tài khoản **burner** — rồi cấp quyền.

Làm xong Gmail, **lặp lại** đúng như vậy cho **Google Calendar**. Có thể dùng cùng một tài khoản
Google."

【MÀN HÌNH: Composio đã kết nối Gmail + Google Calendar, hiện danh sách tool】

〔Đọc〕
"Bạn có thể thắc mắc: cấp quyền ở đây có rộng quá không? Yên tâm. Cấp đủ quyền ở Composio là **an
toàn**, vì ở bước sau bạn còn **giới hạn được công cụ nào agent thật sự được dùng**. Và một điểm
hay: bạn nối được **nhiều** tài khoản — nhiều email, nhiều Drive — tùy nhu cầu."

---

## [04:40] BƯỚC 3 — Lấy hướng dẫn cài cho agent

【THAO TÁC: Composio → Install → tìm OpenClaw → copy hướng dẫn】

〔Đọc〕
"Giờ ta cần lấy đoạn hướng dẫn để nối Composio vào Hermes. Trong Composio, vào mục **Install**, rồi
tìm phần tên **OpenClaw** — copy đoạn hướng dẫn hoặc cấu hình ở đó.

Bạn sẽ hỏi: 'Ủa, sao không thấy mục Hermes?'. Đúng vậy, thường không có mục riêng tên Hermes. Không
sao — Hermes **tương thích** với hướng dẫn kiểu **OpenClaw**, về cơ bản cùng một cơ chế. Cứ dùng
OpenClaw."

---

## [06:00] BƯỚC 4 — Nối Composio vào Hermes

【THAO TÁC: từ dashboard hoặc Telegram, dán hướng dẫn cho agent】

〔Đọc〕
"Quay lại chat với agent — dashboard hoặc Telegram đều được. Dán đoạn hướng dẫn vừa copy, và nói:

_'Hãy chạy các bước sau để kết nối mình với Composio: [dán hướng dẫn vào đây]. Giúp mình đăng nhập
Composio.'_

Agent sẽ đưa cho bạn một **URL để authorize** — cấp phép. Mở URL đó, bấm **Authorize**, rồi quay lại
chat báo cho agent là 'đã approve'."

【MÀN HÌNH: agent báo "Composio connected"】

〔Đọc〕
"Nếu mọi thứ ổn, agent xác nhận: **Composio connected** — đã kết nối. Đây là cầu nối một lần; làm
xong là dùng mãi."

---

## [08:00] BƯỚC 5 — Thử thao tác thật

【THAO TÁC: gửi lệnh đọc email — an toàn nhất trước】

〔Đọc〕
"Giờ mới đã. Ta thử. Và theo nguyên tắc, thử cái **an toàn nhất trước** — một lệnh chỉ **đọc**:

_'Cho mình xem tiêu đề hai email gần nhất trong hộp thư.'_

_(chờ, agent liệt kê)_

Đấy — nó đọc được hộp thư thật của bạn. Giờ thử một lệnh **ghi** — tạo cái gì đó:

_'Tạo giúp mình một sự kiện lịch tên Học Hermes vào tám giờ tối nay.'_

Và nó tạo event trên Google Calendar thật. Từ giây phút này, agent của bạn không còn là chatbot —
nó **làm việc thật**."

【MÀN HÌNH: agent liệt kê email và tạo event lịch】

---

## [10:00] BƯỚC 6 — Dạy agent chọn đúng skill

〔Đọc〕
"Có một chuyện thực tế bạn nên biết trước. Lúc đầu, agent đôi khi **dùng nhầm công cụ** — ví dụ nó
cố dùng một 'Google Workspace skill' nào đó, trong khi lẽ ra nên dùng 'Composio skill'. Kết quả là
lỗi lung tung. Ta **dạy** nó."

【THAO TÁC: gửi lệnh dạy ưu tiên skill】

〔Đọc〕
"Gửi cho agent:

_'Từ nay, mỗi khi cần thao tác email hoặc lịch, hãy dùng Composio — không dùng skill khác. Ghi nhớ
ưu tiên này.'_

Và đây là điều đẹp: nhờ vòng **self-improvement** cộng với **Honcho**, agent **ghi nhớ** ưu tiên này
cho những lần sau. Bạn dạy một lần, nó nhớ mãi. Không phải nhắc lại mỗi ngày."

【MÀN HÌNH: agent xác nhận ghi nhớ ưu tiên Composio】

〔Đọc〕
"Một mẹo xử lý sự cố: nếu Composio báo **'Gmail not linked'** dù bạn đã nối rồi — agent thường tự
đưa cho bạn một **link để nối lại**; bấm vào là xong. Đây là trục trặc kết nối lần đầu hay gặp,
không phải lỗi của bạn."

---

## [12:00] LỖI HAY GẶP — điểm nhanh

【MÀN HÌNH: bảng lỗi thường gặp】

〔Đọc〕
"Vài lỗi để bạn không hoảng.

'Gmail not linked' — kết nối lần đầu chưa xong, bấm link re-link agent đưa.

Agent dùng nhầm skill — chưa được dạy, ra lệnh 'luôn dùng Composio cho email và lịch'.

Không authorize được — thường do sai tài khoản hoặc trình duyệt chặn popup; mở đúng URL, đăng nhập
đúng tài khoản.

Còn nếu bạn thấy lo quyền quá rộng — cứ vào Composio **tắt bớt** công cụ, và bắt đầu ở chế độ chỉ
đọc."

---

## [12:50] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 14 tick xanh + nút "Bài tiếp: Tự động hóa với Cron"】

〔Đọc〕
"Tóm lại: **Composio là một cổng nối tới mọi app**. Bạn kết nối tài khoản ở dashboard Composio, nối
vào Hermes một lần, rồi ra lệnh bằng lời. Nhớ least-privilege, và nhớ dạy agent chọn đúng skill.

Giờ agent làm được **việc thật** — nhưng nó vẫn đang **bị động**, chờ bạn nhắn mới làm. Bài tiếp
theo, ta biến nó thành **chủ động**: tự chạy việc theo lịch, mỗi ngày, kể cả khi bạn không mở máy.
Đây là lúc nó thật sự 'chạy giúp bạn hai tư trên bảy'. Hẹn gặp ở bài mười lăm."

【[13:45] HẾT】

---

### 🎬 Ghi chú sản xuất
- Dùng tài khoản Google **burner** thật khi quay — tuyệt đối không lộ email/lịch cá nhân trên màn hình.
- Đoạn [08:00] thao tác thật nên quay liền mạch email→lịch để thấy sức mạnh "làm việc thật".
- Nhấn mạnh chữ "least-privilege" và "burner" ở [00:50] — đây là điểm bảo mật cốt lõi.
- Nếu bắt được cảnh agent dùng nhầm skill rồi được dạy lại ([10:00]), chèn vào rất thuyết phục về self-improvement.
