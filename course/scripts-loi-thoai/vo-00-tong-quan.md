# 🎙️ VO — Bài 00: Tổng quan & mở màn

> **Thời lượng mục tiêu:** ~8 phút · **Tông giọng:** thân thiện, tự tin, rõ ràng, không hù dọa kỹ thuật.
> **Kịch bản dạy học tương ứng:** [`../00-tong-quan-va-lo-trinh.md`](../00-tong-quan-va-lo-trinh.md)

---

## [00:00] MỞ MÀN — Hook "trí nhớ"

【B-ROLL: cắt sẵn 20–30 giây "wow moment" quay từ Bài 09 — agent nhớ đúng thông tin phiên trước】

〔Đọc〕
"Bạn có để ý không: hầu hết trợ lý AI đều bị 'mất trí nhớ'. Hết cuộc trò chuyện là quên. Đổi
thiết bị là quên. Server khởi động lại — quên sạch.

Còn cái bạn vừa thấy thì khác. Nó nhớ tôi là ai, tôi đang học gì, tôi thích được trả lời thế nào —
dù đây là một phiên hoàn toàn mới.

Trong khóa này, chúng ta sẽ tự tay dựng một trợ lý AI như vậy. Chạy hai tư đây bảy — à, chạy
_24/7_ — và có **trí nhớ thật**. Bí mật nằm ở một thứ tên là **Honcho**. Bắt đầu thôi."

【MÀN HÌNH: Title card — "Hermes Agent + Honcho — Khóa học từ số 0"】

---

## [00:35] CHÀO & LỜI HỨA

〔Đọc〕
"Chào bạn, chào mừng đến với khóa Hermes Agent cộng Honcho. Mình sẽ đi **từ số 0**. Bạn **không
cần biết lập trình**. Bạn sẽ gõ vài lệnh, nhưng mình giải thích từng lệnh làm gì, nên yên tâm.

Lời hứa của mình: học xong, bạn có một trợ lý AI tự host, nhớ được bạn xuyên thời gian, nhắn tin
qua Telegram, đọc được Gmail và lịch của bạn, tự chạy việc mỗi ngày, và **càng dùng càng hiểu bạn
hơn**. Không phải chatbot — mà một trợ lý biết _hành động_ và biết _nhớ_."

---

## [01:15] HERMES vs HONCHO — hai vai trò

【MÀN HÌNH: sơ đồ 2 khối — "Hermes = Đôi tay & kỹ năng" / "Honcho = Ký ức & thấu hiểu"】

〔Đọc〕
"Có hai nhân vật chính. Thứ nhất là **Hermes** — đây là bộ não hành động. Nó gọi mô hình AI, dùng
công cụ như duyệt web, viết code, gửi email, và nó có một dashboard để mình trò chuyện.

Thứ hai là **Honcho** — đây là tầng trí nhớ. Nó không chỉ lưu lại lời bạn nói, mà **xây một mô
hình về bạn**: sở thích, thói quen, mục tiêu — rồi liên tục cập nhật khi hiểu bạn hơn.

Nói ngắn gọn: **Hermes biết làm. Honcho giúp nó hiểu và nhớ bạn.** Ghép lại, ta có một trợ lý cá
nhân thật sự."

---

## [02:10] KHÓA HỌC ĐI TỚI ĐÂU — bản đồ 5 phần

【MÀN HÌNH: mục lục 5 phần, highlight từng phần khi nhắc tới】

〔Đọc〕
"Khóa chia làm năm phần.

Phần A — **Nền tảng**. Ta hiểu Hermes là gì, Honcho là gì, và cực kỳ quan trọng: **bảo mật**. Vì
mình sắp trao cho AI khá nhiều quyền, nên phải biết cách phòng vệ trước.

Phần B — **Triển khai**. Ta dựng hệ thống. Mình sẽ chỉ _hai cách_: chạy trên máy bạn bằng Docker,
hoặc chạy trên cloud bằng Railway để nó bật hai tư bảy.

Phần C — **Bộ nhớ Honcho**. Đây là phần khiến khóa này khác mọi tutorial Hermes khác. Ta chứng
minh trí nhớ hoạt động, và học cách tinh chỉnh nó.

Phần D — **Kết nối và tự động hóa**. Telegram, Gmail, lịch, và các tác vụ tự động chạy mỗi ngày.

Phần E — **Vận hành**. Cách giữ hệ thống ổn định, kiểm soát chi phí, và xử lý sự cố.

Tổng cộng hai mươi bài. Có mục lục và mốc thời gian ở phần mô tả để bạn nhảy tới bất cứ đâu."

---

## [03:40] CHỌN CON ĐƯỜNG — Docker hay Railway

【MÀN HÌNH: bảng so sánh Docker local vs Railway】

〔Đọc〕
"Trước khi đi tiếp, một quyết định nhỏ. Có hai cách dựng, và bạn chỉ cần **chọn một**.

Cách một: **Docker trên máy bạn**. Miễn phí, tuyệt vời để học và thử. Nhược điểm: tắt máy là nó
tắt theo.

Cách hai: **Railway trên cloud**. Tốn vài đô một tháng, nhưng chạy hai tư bảy, kể cả khi bạn ngủ.

Lời khuyên của mình cho người mới: **làm Docker trước** để hiểu hệ thống, rồi khi thích thì đẩy
lên Railway. Mình sẽ hướng dẫn cả hai, nên bạn không bỏ lỡ gì."

---

## [04:40] CÁCH DÙNG BỘ TÀI LIỆU

【MÀN HÌNH: cuộn nhanh một file module để thấy cấu trúc 🎯 / 🪜 / ⚠️ / ✅】

〔Đọc〕
"Mỗi bài đều có tài liệu viết sẵn, cùng một khung: mục tiêu ở đầu, các bước thực hiện có kèm lệnh,
một bảng lỗi thường gặp, và một checklist để bạn tự đối chiếu.

Nghĩa là bạn có thể **vừa xem video vừa mở tài liệu làm theo**, và tua lại bất cứ lúc nào. Mình
thiết kế để bạn dựng được _ngay lần đầu_, không kẹt giữa chừng."

---

## [05:30] MỘT LỜI THẲNG THẮN — kỳ vọng đúng

〔Đọc〕
"Mình muốn nói thẳng một điều. Cái này **không phải phép màu** làm bạn giàu sau một đêm như quảng
cáo trên mạng. Nó cũng không hợp nếu bạn chỉ cần _một_ automation cố định — lúc đó công cụ khác gọn
hơn.

Nhưng nếu bạn muốn một trợ lý **sống cùng mình**, xử lý nhiều loại việc, và hiểu bạn dần theo thời
gian — thì đây đúng là thứ bạn cần. Và khi đặt đúng, nó tiết kiệm cho bạn hàng giờ mỗi tuần."

---

## [06:20] AN TOÀN LÀ ƯU TIÊN

〔Đọc〕
"Một điểm nữa trước khi bắt tay. Vì ta trao quyền cho AI — nó tự chạy việc, tự sửa file, tự gọi
công cụ — nên bảo mật không phải phần phụ. Hãy coi trợ lý này như **một nhân viên mới ngày đầu**:
mình mở quyền _từ từ_, không trao chìa khóa toàn bộ ngay.

Đó là lý do ngay Phần A đã có hẳn một bài về bảo mật. Đừng bỏ qua nó — mình hứa sẽ ngắn gọn và
thực tế."

---

## [07:00] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: quay lại title card + nút "Bài tiếp theo: Hermes Agent là gì"】

〔Đọc〕
"Tóm lại: Hermes lo hành động, Honcho lo trí nhớ. Năm phần, hai mươi bài, hai cách dựng. Bạn chọn
một con đường và mình đi cùng bạn tới cuối.

Ở bài tiếp theo, ta trả lời câu hỏi nền tảng: **AI agent thật ra là gì, và khác chatbot ở chỗ
nào?** Hiểu cái đó rồi thì mọi thao tác sau bạn đều biết _tại sao_. Hẹn gặp ở bài một."

【[08:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- Đoạn `[00:00]` hook nên **cắt từ Bài 09** — quay bài đó trước.
- Từ viết tắt đọc: "24/7" → đọc "hai tư trên bảy" hoặc "hai tư bảy" (thống nhất một kiểu).
- Nhịp: mục lục (02:10) đừng đọc quá nhanh — cho khán giả kịp thấy bức tranh.
- Chèn `【MÀN HÌNH】` đúng lúc nhắc tới để giữ nhịp mắt–tai.
