# 🎙️ VO — Bài 08: Chạy lần đầu & tham quan Dashboard

> **Thời lượng mục tiêu:** ~14 phút · **Tông giọng:** dẫn tour thân thiện, "cùng ngồi vào buồng lái".
> **Kịch bản dạy học tương ứng:** [`../08-cau-hinh-lan-dau-va-dashboard.md`](../08-cau-hinh-lan-dau-va-dashboard.md)

---

## [00:00] MỞ MÀN — vào buồng lái

【MÀN HÌNH: Title card — "Bài 08 — Chạy lần đầu & tham quan Dashboard"】

〔Đọc〕
"Hệ thống của bạn đã chạy rồi — dù bạn dựng bằng Docker ở Bài 06, hay trên Railway ở Bài 07. Giờ
là lúc vui: ta ngồi vào buồng lái.

Một lưu ý nhỏ để bạn khỏi bỡ ngỡ: trong repo này, Hermes phục vụ dưới dạng _web dashboard_, chứ
không phải giao diện dòng lệnh kiểu TUI như vài bản khác bạn thấy trên mạng. Nhưng đừng lo — các
_khái niệm cấu hình_ thì giống hệt nhau. Mình sẽ giải thích từng cái, để sau này bạn chỉnh có chủ
đích chứ không mò mẫm."

---

## [00:50] BƯỚC 1 — Gửi tin nhắn đầu tiên

【THAO TÁC: mở dashboard (localhost:3000 hoặc URL Railway), đăng nhập, gõ tin nhắn】
【MÀN HÌNH: gõ "Hello world — bạn đang chạy chứ?" và chờ phản hồi】

〔Đọc〕
"Bắt đầu bằng khoảnh khắc 'hello world'. Mình mở dashboard — ở bản Docker là localhost cổng ba
nghìn, ở Railway là cái URL bạn được cấp — rồi đăng nhập.

Mình gõ một câu đơn giản: 'Hello world — bạn đang chạy chứ?' và gửi.

_(chờ agent trả lời)_

Đây rồi, nó trả lời. Lần chạy đầu tiên có thể mất vài giây để khởi tạo, nên nếu hơi lâu một chút
thì bình thường."

〔Đọc〕
"Nếu nó _không_ trả lời, hoặc hiện lỗi — thì gần như chắc chắn là do OpenAI key chưa hợp lệ. Cách
sửa: đặt key thật, bằng cách sửa `.env` rồi chạy lại `docker compose up -d`, hoặc đặt ngay ở trang
Config của dashboard, hoặc ở biến môi trường bên Railway. Nhớ lại nguyên tắc: key đặt qua env hoặc
Config, _không_ dán vào ô chat."

---

## [02:45] BƯỚC 2 — Tham quan các khu vực của dashboard

【THAO TÁC: lần lượt mở từng mục ở sidebar】
【MÀN HÌNH: sidebar với Chat / Config / Skills / Memory / Crons】

〔Đọc〕
"Giờ đi một vòng cho biết mặt các khu vực chính.

'Chat' — nơi bạn trò chuyện chính, cái ta vừa dùng.

'Config', hay Settings — nơi đặt key LLM, chọn model, và chỉnh các thông số của agent.

'Skills' — danh sách kỹ năng, gồm built-in và những cái bạn đã bật. Nhớ Bài 02 chứ? Đây chính là
mấy file skill đó.

'Memory' — trạng thái bộ nhớ. Ở bản này, nó gắn với Honcho, và ta sẽ 'nghịch' nó thật kỹ ở Bài 09.

Và 'Crons', hay Tasks — các tác vụ định kỳ, để dành cho Bài 15.

Bạn không cần thuộc hết ngay. Chỉ cần biết cái gì nằm ở đâu, để lát cần thì tìm được."

---

## [04:30] BƯỚC 3 — Bốn "núm vặn" quan trọng

【MÀN HÌNH: bảng thiết lập — Max iterations · Tool progress · Context compression · Session reset】

〔Đọc〕
"Giờ tới phần cốt lõi của bài: những 'núm vặn' bạn hay gặp. Bạn không cần đổi hết đâu — mình chỉ
giải thích để bạn biết cái nào ảnh hưởng gì, đặc biệt là hai thứ: _chi phí_ và _trí nhớ_.

Núm thứ nhất: Max iterations — số lần gọi LLM tối đa cho _một_ yêu cầu. Cứ để mặc định, khoảng chín
mươi. Đặt cao hơn thì agent chạy sâu hơn, lâu hơn, nhưng cũng _tốn token_ hơn.

Núm thứ hai: Tool progress mode — mức độ hiện agent đang làm gì. Có các mức off, new, all, verbose.
Mình khuyên để `all` — bạn thấy hoạt động vừa đủ, không quá rối mắt.

Núm thứ ba: Context compression — ngưỡng nén hội thoại, một số từ không tới một.

Và núm thứ tư: Session reset mode — khi nào thì tạo phiên mới. Mình khuyên `inactivity` cộng
`daily reset`. Hai núm cuối này mình nói kỹ hơn, vì chúng đụng thẳng tới chi phí và trí nhớ."

---

## [07:00] GIẢI THÍCH SÂU — compression 0.8 & session reset

【MÀN HÌNH: minh họa context window đầy dần tới 80% rồi nén lại】

〔Đọc〕
"Nói về context compression trước. Mỗi LLM có một giới hạn context window — tức lượng thông tin nó
'ôm' được cùng lúc. Mình khuyên đặt ngưỡng nén là không phẩy tám. Nghĩa là: khi ngữ cảnh đầy khoảng
tám mươi phần trăm, agent mới nén nó lại thành một bản tóm tắt rồi đi tiếp. So với đặt không phẩy
năm, thì không phẩy tám giúp nó _nhớ được lâu hơn_ trước khi phải nén."

【MÀN HÌNH: minh họa mỗi kênh/thiết bị là một session riêng】

〔Đọc〕
"Còn session reset. Mỗi kênh, mỗi thiết bị là một _session_ riêng. Đặt `inactivity` cộng
`daily reset` nghĩa là: im lặng một lúc, hoặc sang một ngày mới, thì agent tạo một phiên tươi mới.

Bạn có thể hỏi: 'ủa, reset phiên thì không mất trí nhớ à?' Câu trả lời — và đây là điểm mạnh của
việc có Honcho: _không_. Ký ức quan trọng vẫn được Honcho lưu lại. Reset session chỉ giúp gọn ngữ
cảnh, giảm chi phí, mà _không_ mất trí nhớ dài hạn. Nghe hơi khó tin đúng không? Đừng lo — Bài 09
mình sẽ _chứng minh_ điều này ngay trước mắt bạn."

〔Đọc〕
"À, và núm cuối: Model — LLM dùng để chat. Cứ chọn model mạnh nhất, mới nhất mà bạn có quyền truy
cập, ví dụ dòng GPT mới nhất."

---

## [09:30] BƯỚC 4 — Chỉnh cấu hình ở đâu

【MÀN HÌNH: hai lối — "Dashboard → Config" và "hermes setup trong shell"】

〔Đọc〕
"Có hai nơi để chỉnh cấu hình.

Cách một, khuyến nghị cho người mới: Dashboard, mục Config. Đổi key, đổi model, chỉnh thông số ngay
trên web. Trực quan.

Cách hai, cho người thích nâng cao: chạy `hermes setup` trong shell của container. Cái này mở lại
nguyên một wizard cấu hình đầy đủ."

【THAO TÁC: mở shell vào container Hermes (bản Docker)】
【MÀN HÌNH: `docker compose exec hermes sh` rồi `hermes setup`, `hermes --help`】

〔Đọc〕
"Để mình cho bạn xem cách hai. Với bản Docker, mình gõ `docker compose exec hermes sh` để mở một
shell vào bên trong container Hermes. Rồi ở trong đó, `hermes setup` mở wizard cấu hình — provider,
model, iterations, đủ cả. Còn `hermes --help` liệt kê các lệnh cho bạn xem.

Trên Railway thì tương tự: bạn dùng nút 'Shell' hoặc 'Connect' của service `hermes` để vào.

Và nhắc lại lần nữa cho chắc: đừng dán API key vào ô chat. Key luôn đặt qua Config, qua env, hoặc
qua `hermes config set`."

---

## [11:30] BƯỚC 5 — Đặt secret bằng CLI

【MÀN HÌNH: `hermes config set OPENAI_API_KEY sk-...`】

〔Đọc〕
"Và nếu có lúc bạn cần đặt một biến bí mật ngay từ shell, thì có lệnh `hermes config set` — ví dụ
`hermes config set OPENAI_API_KEY` rồi tới cái key. Secret này được lưu vào thư mục env riêng của
Hermes, _không_ lọt vào log chat. Đúng tinh thần bảo mật ở Bài 04."

---

## [12:15] DỌN VÀI LỖI THƯỜNG GẶP

【MÀN HÌNH: bảng "Triệu chứng — Cách sửa"】

〔Đọc〕
"Vài trục trặc hay gặp, để bạn khỏi hoảng.

Chat im lặng hoặc báo lỗi model? Kiểm tra key, kiểm tra quota, hoặc bạn đang chọn một model mình
không có quyền — đổi model trong Config.

Đổi Config mà không thấy ăn? Bạn chưa lưu, hoặc bản Railway thì cần redeploy sau khi đổi env.

Agent chạy rất lâu và tốn tiền? Max iterations đặt quá cao, hoặc prompt của bạn mơ hồ — hạ
iterations về mặc định và ra lệnh rõ ràng hơn.

Và nếu nó cứ 'quên' giữa một cuộc trò chuyện dài? Context compression đang để quá thấp — đặt lên
không phẩy tám."

---

## [13:00] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 08 tick xanh + nút "Bài tiếp: Kiểm chứng bộ nhớ Honcho"】

〔Đọc〕
"Tóm lại: dashboard là buồng lái của bạn. Bốn núm quan trọng nhất — iterations lo chi phí, tool
progress để `all`, compression để không phẩy tám, và session reset để `inactivity` cộng daily. Và
điểm mấu chốt: reset session _không_ làm mất trí nhớ dài hạn, vì đã có Honcho gánh phần đó.

Mình cứ nói đi nói lại 'Honcho lưu trí nhớ dài hạn' suốt mấy bài rồi. Ở bài tiếp theo, mình sẽ
ngừng nói và bắt đầu _chứng minh_ — ngay trước mặt bạn, bằng một phép thử. Đây là bài 'wow' của cả
khóa. Hẹn gặp ở Bài 09."

【[14:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- "0.8" đọc "không phẩy tám" — thống nhất mọi lần nhắc.
- Quay cận cảnh sidebar khi giới thiệu Chat/Config/Skills/Memory/Crons [02:45] để khán giả định vị.
- Đoạn "reset không mất trí nhớ" [07:00] là cầu nối sang Bài 09 — nhấn giọng, tạo tò mò, đừng giải thích hết.
- Che key thật khi minh họa `hermes config set` [11:30].
