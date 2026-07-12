# 🎙️ VO — Bài 02: Kiến trúc & 5 khái niệm cốt lõi

> **Thời lượng mục tiêu:** ~12 phút · **Tông giọng:** mạch lạc, có hệ thống — bài "bản đồ khái niệm".
> **Kịch bản dạy học tương ứng:** [`../02-kien-truc-va-5-khai-niem.md`](../02-kien-truc-va-5-khai-niem.md)

---

## [00:00] MỞ MÀN — năm mảnh ghép

【MÀN HÌNH: Title card — "Bài 02 — Kiến trúc & 5 khái niệm cốt lõi"】

〔Đọc〕
"Ở bài trước, mình nói Hermes là phần mềm bao quanh LLM. Bài này ta mở nắp ra, nhìn vào bên trong.

Trước khi dựng bất cứ thứ gì, ta cần hiểu năm mảnh ghép tạo nên Hermes. Nghe có vẻ nhiều, nhưng
mình hứa: hiểu năm cái này rồi thì mọi thao tác về sau, bạn đều biết mình đang chỉnh cái gì và tại
sao. Đây là bản đồ, và ta sẽ dùng nó suốt cả khóa."

【MÀN HÌNH: sơ đồ năm khối — Memory · Skills · Soul · Crons · Self-improvement — bên dưới là "LLM (bộ não)"】

〔Đọc〕
"Năm mảnh đó là: Memory — trí nhớ. Skills — kỹ năng. Soul — tính cách. Crons — tác vụ định kỳ. Và
Self-improvement — vòng lặp tự nâng cấp. Đi từng cái nhé."

---

## [01:15] ① MEMORY — trí nhớ

【MÀN HÌNH: cây thư mục agent, highlight thư mục `memory/`, file `user.md`, `memory.md`】

〔Đọc〕
"Mảnh thứ nhất là Memory. Khi bạn cài Hermes, bạn nhận về một cấu trúc thư mục — gồm vài file
markdown, file config, biến môi trường, và một thư mục tên `memory`.

Trong đó có hai file quan trọng nhất. Một là `user.md` — chứa thông tin về _bạn_: tên, tuổi, nơi ở,
sở thích, phong cách bạn mong muốn. Hai là `memory.md` — chứa những sự thật dài hạn mà agent cần
luôn nhớ khi trò chuyện với bạn.

Điểm mình muốn bạn yên tâm: bạn _không cần tự sửa_ mấy file này bằng tay. Hermes tự cập nhật chúng.
Nhưng biết chúng tồn tại giúp bạn hiểu 'hậu trường' đang diễn ra thế nào."

【MÀN HÌNH: khung nhấn mạnh — "Khóa này: thay/bổ sung Memory bằng Honcho"】

〔Đọc〕
"Và đây là điểm mấu chốt của cả khóa. Ở bản Hermes chuẩn, memory chỉ là mấy file markdown cục bộ.
Trong khóa này, ta _thay và bổ sung_ nó bằng Honcho — một tầng nhớ mạnh hơn nhiều, không chỉ lưu
chữ mà còn _suy luận_ và _mô hình hóa_ về bạn. Toàn bộ Bài 03 dành cho chuyện đó."

---

## [03:15] ② SKILLS — kỹ năng, và mẹo tiết kiệm token

【MÀN HÌNH: ví dụ một file skill `.md` với mục "khi nào dùng" + "các bước"】

〔Đọc〕
"Mảnh thứ hai là Skills — kỹ năng. Một skill thật ra chỉ là một file markdown, mô tả ba thứ: skill
này là gì, khi nào thì dùng, và các bước thực hiện.

Ví dụ cho dễ hiểu. Thay vì mỗi lần bạn phải viết lại năm bước 'cách kiểm tra email', ta có sẵn một
_email skill_. Bạn chỉ cần nói 'kiểm tra email', agent tra skill đó rồi làm theo — nhất quán, và
đoán trước được.

Hermes có sẵn khoảng chín mươi skill built-in, cộng với hơn năm trăm skill từ cộng đồng, và bạn
còn tự tạo được nữa."

【MÀN HÌNH: minh họa "progressive disclosure" — lúc khởi động chỉ nạp tên + mô tả, khi cần mới nạp đầy đủ】

〔Đọc〕
"Giờ tới một khái niệm nghe hơi kỹ thuật nhưng cực kỳ quan trọng: _progressive disclosure_, tức
tiết lộ dần. Lúc khởi động, agent chỉ nạp _tên và mô tả ngắn_ của các skill thôi, chứ không nạp
toàn bộ nội dung. Chỉ khi cần dùng skill nào, nó mới nạp đầy đủ đúng skill đó.

Nhờ vậy, agent không phải nhồi hàng trăm nghìn ký tự vào mỗi lần chạy. Kết quả: tiết kiệm token,
tiết kiệm tiền. Hãy nhớ cụm 'progressive disclosure' này — nó là lý do vì sao bật nhiều skill
_không_ làm agent chậm đi."

---

## [05:45] ③ SOUL — tính cách

【MÀN HÌNH: file `soul.md` với vài dòng mô tả giọng điệu】

〔Đọc〕
"Mảnh thứ ba là Soul — tạm dịch là 'linh hồn', hay tính cách, persona của agent. Nó cũng chỉ là
một file markdown, mô tả cách agent hành xử: nghiêm túc hay thân thiện, có dùng emoji hay không,
xưng hô ra sao, giọng điệu thế nào.

Và một lần nữa, bạn _không cần tự viết_ file này. Bạn chỉ cần nói, kiểu: 'hãy chỉnh soul của bạn để
luôn ngắn gọn, trực tiếp, mang tính giáo dục' — thế là agent tự cập nhật. Mình sẽ thực hành đúng
cái này ở Bài 10."

---

## [07:00] ④ CRONS — tác vụ định kỳ

【MÀN HÌNH: lịch với các mốc "mỗi sáng", "mỗi tối", "mỗi Chủ nhật"】

〔Đọc〕
"Mảnh thứ tư là Crons — các tác vụ định kỳ, hay còn gọi là automations. Đây là lúc Hermes bắt đầu
thật sự hữu ích.

Bạn hẹn nó làm việc theo lịch. Mỗi sáng gửi cho bạn bản tóm tắt email. Mỗi tối nhắc uống thuốc. Mỗi
Chủ nhật chạy một lượt kiểm tra bảo mật. Bạn đặt lịch một lần, nó tự lo.

Ở đây có một phân biệt hay: một agent _reactive_ là agent chỉ ngồi chờ bạn ra lệnh. Còn một agent
_proactive_ thì tự chạy nền theo lịch. Chính Crons biến Hermes từ reactive thành proactive. Ta
thực hành ở Bài 15."

---

## [08:30] ⑤ SELF-IMPROVEMENT — vòng lặp tự cải thiện

【MÀN HÌNH: vòng lặp "dùng → agent học → lưu memory → tự xây skill mới"】

〔Đọc〕
"Và mảnh thứ năm — với mình là quan trọng nhất — vòng lặp tự cải thiện. Đây là điểm tách Hermes ra
khỏi OpenClaw.

Khi bạn làm việc với agent, nó học về bạn, lưu vào memory, và _tự xây skill mới trong nền_ — không
cần bạn yêu cầu. Bạn lặp lại một việc vài lần, nó tự tạo một skill để nhớ _cách bạn thích làm việc
đó_. Lần sau nhanh hơn, đúng ý hơn.

Và trong khóa này, vòng lặp đó còn được _tăng cường bằng Honcho_: Honcho chạy một tiến trình nền tên
Deriver, liên tục cập nhật hiểu biết về bạn sau mỗi lượt trò chuyện. Bạn sẽ nghe lại cái tên Deriver
này rất nhiều."

---

## [10:00] BA HIỂU LẦM CẦN DỌN

【MÀN HÌNH: bảng "Hiểu lầm — Sự thật"】

〔Đọc〕
"Dọn nhanh vài hiểu lầm.

'Phải tự viết `user.md`, `soul.md`, hay skill bằng tay.' Không — nói bằng lời, agent tự tạo và cập
nhật.

'Bật nhiều skill thì agent luôn chậm và tốn token.' Không — nhờ progressive disclosure, nó chỉ nạp
skill khi cần.

Và 'cron chỉ chạy được mỗi ngày.' Cũng không — mỗi giờ, mỗi tuần, mỗi tháng, hay bất kỳ biểu thức
lịch nào, đều được."

---

## [11:00] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: năm khối sáng lên lần lượt + nút "Bài tiếp: Honcho là gì"】

〔Đọc〕
"Vậy là ta có năm mảnh ghép: Memory để nhớ, Skills là kỹ năng nạp dần, Soul là tính cách, Crons là
định kỳ, và Self-improvement là tự nâng cấp. Tất cả, về bản chất, chỉ là các file được quản lý
quanh một LLM.

Và khóa này nâng cấp mạnh mảnh đầu tiên — Memory — bằng Honcho. Nên ở bài tiếp theo, ta trả lời cho
được: Honcho thật ra là gì, và vì sao ghép nó với Hermes lại mạnh đến vậy? Hẹn gặp ở Bài 03."

【[12:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- Sơ đồ năm khối ở [00:00] nên giữ trên màn hình lâu để khán giả 'chụp' được bức tranh tổng.
- Nhấn mạnh cụm "progressive disclosure" [03:15] — có thể chèn phụ đề chữ to; đây là thuật ngữ khóa.
- Mỗi khi nhắc "Honcho" hoặc "Deriver", cho hiện chữ nhỏ trên màn để khán giả bắt đầu quen tên.
- Đừng đọc bảng hiểu lầm [10:00] quá nhanh — để khán giả kịp đối chiếu với suy nghĩ của mình.
