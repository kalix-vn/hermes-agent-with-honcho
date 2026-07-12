# 🎙️ VO — Bài 13: Voice, hình ảnh & browser automation

> **Thời lượng mục tiêu:** ~10 phút · **Tông giọng:** khám phá, hào hứng, bình thường hóa lỗi lần đầu.
> **Kịch bản dạy học tương ứng:** [`../13-voice-image-browser.md`](../13-voice-image-browser.md)
> ⚠️ **Điều kiện:** đã cấu hình dashboard (Bài 08); Telegram (Bài 11) tiện cho phần voice.

---

## [00:00] MỞ MÀN — agent có giác quan

【B-ROLL: nhanh 3 cảnh — nói vào điện thoại, gửi ảnh, agent chụp một trang web】

〔Đọc〕
"Tới giờ, agent của bạn chỉ mới đọc và viết **chữ**. Nhưng nó làm được nhiều hơn thế nhiều.

Nó **nghe** được — bạn nói, nó hiểu. Nó **nói** được — trả lời bạn bằng giọng. Nó **nhìn** được ảnh
— gửi cho nó một tấm hình, nó mô tả. Và nó **duyệt web** được — vào một trang, chụp màn hình, đọc
nội dung. Bài này ta bật và thử cả ba khả năng đó. Bắt đầu."

【MÀN HÌNH: Title card — "Bài 13 · Voice, hình ảnh & browser"】

---

## [00:45] BƯỚC 1 — Thử giọng nói: nghe và nói

【THAO TÁC: mở Telegram, giữ nút micro, gửi voice message】

〔Đọc〕
"Phần giọng nói tiện nhất là làm qua Telegram. Mình mở chat với bot, giữ nút micro, và nói một câu:

_'Bạn nghe được mình không? Nhắc lại giúp mình câu vừa nói.'_

Gửi đi. Agent sẽ **transcribe** — chuyển giọng thành chữ — rồi trả lời. Đó là **STT**, speech to
text, tức là nó **nghe** được."

【MÀN HÌNH: agent transcribe đúng câu vừa nói】

〔Đọc〕
"Giờ thử chiều ngược lại. Mình gõ:

_'Gửi cho mình một voice message nói hello world.'_

Và nó gửi lại một **tin nhắn thoại**. Đó là **TTS**, text to speech — nó **nói** được.

Một điểm hay: với cấu hình mặc định, agent đã có sẵn TTS và STT cơ bản, **miễn phí**. Nếu bạn muốn
giọng đọc tự nhiên hơn, có thể đổi nhà cung cấp TTS trong Config — ví dụ **ElevenLabs**. Nhưng cái
đó **không bắt buộc**, để sau cũng được."

【MÀN HÌNH: voice message gửi đi và agent trả lời bằng voice】

---

## [02:50] BƯỚC 2 — Gửi ảnh cho agent

【THAO TÁC: đính kèm một ảnh — hóa đơn, biểu đồ, hoặc screenshot】

〔Đọc〕
"Tiếp theo là thị giác. Mình đính kèm một tấm ảnh — có thể là screenshot, một hóa đơn, một biểu đồ
— rồi hỏi:

_'Trong ảnh này có gì? Tóm tắt các ý chính giúp mình.'_

_(chờ agent xử lý)_

Và nó mô tả lại nội dung ảnh. Cực kỳ tiện khi bạn muốn nó đọc giúp một cái hóa đơn, hay tóm tắt một
biểu đồ."

【MÀN HÌNH: agent mô tả nội dung ảnh】

〔Đọc〕
"Lưu ý một chút: khả năng này cần một **model có thị giác** — vision. Phần lớn model hiện đại đều
có, nên thường không vấn đề gì. Nhưng nếu agent nói 'mình không xem được ảnh', thì chỉ cần vào
Config, đổi sang một model có hỗ trợ vision là xong."

---

## [04:20] BƯỚC 3 — Browser automation: chờ nó FAIL

【THAO TÁC: gửi lệnh truy cập example.com và chụp màn hình】

〔Đọc〕
"Giờ tới phần thú vị nhất, và cũng 'gập ghềnh' nhất: duyệt web. Mình gửi:

_'Truy cập example.com, chụp màn hình và cho mình biết trang có gì.'_

_(chờ, và... lỗi)_

Và... nó **báo lỗi**. Kiểu như 'agent browser is not installed' — chưa cài trình duyệt. Đây là điều
mình **cố ý** cho bạn thấy: lần đầu, nó **thường fail** như vậy. Không phải bạn làm sai đâu. Trình
duyệt cho agent cần được cài lần đầu, và ta sẽ làm ngay bây giờ."

【MÀN HÌNH: lỗi 'agent browser is not installed'】

---

## [05:40] BƯỚC 4 — Cài agent browser rồi thử lại

【THAO TÁC: gửi lệnh cài agent browser】

〔Đọc〕
"Cách sửa đơn giản đến bất ngờ: ta **nhờ chính agent tự cài**. Gửi:

_'Hãy cài agent browser, rồi thử lại tác vụ chụp màn hình trang đó.'_

_(chờ cài, rồi thử lại)_

Sau khi cài xong, nó chụp được màn hình và mô tả lại — phần hero, các nút, các section trên trang.
Vậy là agent giờ 'nhìn' được cả web, không chỉ ảnh tĩnh."

【MÀN HÌNH: agent chụp và mô tả trang web sau khi cài browser】

---

## [07:00] BƯỚC 5 — Phân biệt Search vs Browser automation

【MÀN HÌNH: bảng 2 cột — Search / Browser automation】

〔Đọc〕
"Có một điểm dễ nhầm mình muốn làm rõ. Có **hai loại** 'lên web' khác nhau.

Loại thứ nhất là **Search** — tìm kiếm web, lấy thông tin. Cái này nhẹ nhàng, và đủ dùng cho **phần
lớn** nhu cầu của bạn.

Loại thứ hai là **Browser automation** — điều khiển một trình duyệt thật: click, chụp, render
JavaScript. Cái này **nặng hơn** nhiều. Và điều quan trọng: trình duyệt chạy trên máy bạn là loại
**headless** — không giao diện — nên nó chỉ kéo được HTML, **không render** được JavaScript phức
tạp."

〔Đọc〕
"Nói cho dễ hình dung: nếu bạn chỉ thỉnh thoảng cần agent đọc một trang web, **local browser là
đủ**. Nhưng nếu bạn làm **nhiều** tác vụ duyệt web phức tạp — vượt CAPTCHA, mở nhiều tab, chạy đa
vùng — thì cân nhắc dịch vụ trả phí như **Browserbase** hoặc **Firecrawl**. Tầm hai mươi đô một
tháng, thường có credit miễn phí để thử. Còn lại thì local là ổn."

---

## [08:40] LỖI HAY GẶP — điểm nhanh

【MÀN HÌNH: bảng lỗi thường gặp】

〔Đọc〕
"Gom nhanh mấy lỗi.

'agent browser is not installed' — như đã thấy, ra lệnh 'cài agent browser' rồi thử lại.

Agent không đọc được ảnh — model không có vision, đổi sang model hỗ trợ ảnh.

Trang JavaScript nặng đọc thiếu nội dung — đó là do local browser headless, dùng Browserbase hoặc
Firecrawl.

Voice không hoạt động — kiểm tra provider TTS/STT trong Config; cứ giữ mặc định miễn phí để test
trước."

---

## [09:10] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 13 tick xanh + nút "Bài tiếp: Kết nối công cụ thật với Composio"】

〔Đọc〕
"Tóm lại: agent giờ **nghe, nói, nhìn, và duyệt web**. Voice và ảnh gần như sẵn sàng ngay; browser
automation cần **cài lần đầu**; và web thật phức tạp thì cân nhắc dịch vụ trả phí.

Nhưng đây mới chỉ là **giác quan**. Cái làm agent thật sự hữu ích là khi nó chạm được vào **tài
khoản thật** của bạn — Gmail, lịch, Notion. Bài tiếp theo, ta nối agent vào các dịch vụ đó qua một
cổng tên là **Composio**. Đây là lúc agent bắt đầu làm **việc thật**. Hẹn gặp ở bài mười bốn."

【[10:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- Đoạn [04:20] "chờ nó FAIL": quay lỗi **thật** — đây là điểm dạy học cốt lõi, đừng dàn dựng.
- Phần voice quay qua Telegram để khán giả thấy nút micro và bong bóng voice message rõ ràng.
- Ảnh dùng để test nên là ảnh vô hại, không chứa thông tin cá nhân (đừng dùng hóa đơn thật có số tài khoản).
- Giữ nhịp nhẹ nhàng ở [07:00] bảng Search vs Browser — đây là chỗ khán giả hay nhầm, đọc thong thả.
