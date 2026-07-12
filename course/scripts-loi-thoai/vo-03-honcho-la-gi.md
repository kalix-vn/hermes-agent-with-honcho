# 🎙️ VO — Bài 03: Honcho là gì & tại sao ghép với Hermes

> **Thời lượng mục tiêu:** ~14 phút · **Tông giọng:** tò mò dẫn dắt, "aha" dần — đây là trái tim khác biệt của khóa.
> **Kịch bản dạy học tương ứng:** [`../03-honcho-la-gi.md`](../03-honcho-la-gi.md)

---

## [00:00] MỞ MÀN — "bộ nhớ hiểu người"

【MÀN HÌNH: Title card — "Bài 03 — Honcho là gì?" — phụ đề nhỏ: "bộ nhớ hiểu người, không phải kho lưu chữ"】

〔Đọc〕
"Đây là bài mình chờ để kể cho bạn nghe. Vì đây chính là thứ khiến khóa học này khác mọi tutorial
Hermes khác trên mạng.

Bộ nhớ mặc định của một agent thường chỉ là _tóm tắt lại tin nhắn cũ_. Honcho làm khác hẳn. Nó xây
một mô hình về bạn — sở thích, niềm tin, phong cách giao tiếp — và liên tục cập nhật mô hình đó khi
nó hiểu bạn hơn.

Honcho do Plastic Labs làm, mã nguồn mở, và trong khóa này mình sẽ _tự host_ nó. Nếu chỉ được nhớ
một câu về Honcho, thì hãy nhớ câu này: Honcho là _bộ nhớ hiểu người_, không phải _kho lưu chữ_."

---

## [01:15] HONCHO GIẢI QUYẾT VẤN ĐỀ GÌ

【MÀN HÌNH: ba biểu tượng "quên" — hết phiên, đổi thiết bị, restart server】

〔Đọc〕
"Ta bắt đầu từ nỗi đau. Trợ lý AI thông thường: hết phiên là quên. Đổi thiết bị là quên. Restart
server — quên sạch. Và kể cả khi nó nhớ, nó chỉ nhớ _chữ đã nói_, chứ không _hiểu bạn là người thế
nào_.

Honcho được sinh ra để giải quyết đúng chuyện đó. Về mặt kỹ thuật, nó là _hạ tầng bộ nhớ cho agent
có trạng thái_. Nó làm ba việc. Một: nhận tin nhắn bạn lưu vào — cái này đồng bộ, nhanh. Hai: suy
luận trong nền, bất đồng bộ, để cập nhật hiểu biết về từng 'peer'. Và ba: trả lời truy vấn — có
thể là ngữ cảnh phiên, kết quả tìm kiếm, hoặc _một insight bằng ngôn ngữ tự nhiên_ về bạn.

Đừng lo nếu vài từ nghe lạ — như 'peer', 'đồng bộ', 'bất đồng bộ'. Mình sẽ làm rõ ngay bây giờ."

---

## [02:45] BỐN KHÁI NIỆM LƯU TRỮ — phần "đồng bộ"

【MÀN HÌNH: sơ đồ phân cấp — Workspace → Peer → Session → Message】

〔Đọc〕
"Trước hết là bốn khái niệm về _lưu trữ_. Hình dung chúng lồng vào nhau như búp bê Nga.

Ngoài cùng là _Workspace_ — không gian làm việc. Nó là cái thùng chứa cấp cao nhất, cô lập dữ liệu
giữa các ứng dụng khác nhau. Ví dụ một workspace tên 'hermes-railway'. Ẩn dụ: đây là 'tòa nhà'.

Bên trong workspace là các _Peer_. Và đây là điểm hay nhất: một peer là _bất kỳ chủ thể nào_ — có
thể là người dùng, mà cũng có thể là chính con AI agent. Cả hai đều là công dân hạng nhất. Ẩn dụ:
peer là 'con người'.

Trong một peer, ta có các _Session_ — mỗi session là một cuộc hội thoại, một thread. Ẩn dụ: 'cuộc
trò chuyện'.

Và nhỏ nhất là _Message_ — một tin nhắn, được gắn nhãn peer nào đã nói. Ẩn dụ: 'câu nói'."

〔Đọc〕
"Nhắc lại chỗ quan trọng: cả _bạn_ lẫn _agent_ đều là peer. Nhờ vậy Honcho mô hình hóa được cả
hai, và tách bạch được nhiều agent, nhiều người dùng, mà không lẫn lộn ngữ cảnh của ai với ai."

---

## [05:15] BA KHÁI NIỆM SUY LUẬN — phần "bất đồng bộ"

【MÀN HÌNH: sơ đồ Deriver (worker nền) → Representation → Dialectic/Chat】

〔Đọc〕
"Bốn khái niệm vừa rồi là phần 'lưu'. Giờ tới phần 'thông minh' — ba khái niệm về _suy luận_.

Sau khi một tin nhắn được lưu, một tiến trình nền tên _Deriver_ sẽ nghiền ngẫm nó và cập nhật hiểu
biết — mà _không_ làm chậm lúc bạn đang chat. Deriver là một worker nền, xử lý hàng đợi: nó cập nhật
representation, tạo tóm tắt phiên, rút ra kết luận.

Cái mà nó cập nhật gọi là _Representation_ — tạm dịch là 'chân dung', hay 'ảnh chụp'. Đây là một
ảnh chụp tĩnh, độ trễ thấp, về những gì Honcho biết về một peer.

Và khái niệm thứ ba, cũng là điểm nhấn: _Dialectic_, hay Chat. Đây là khi bạn hỏi Honcho bằng ngôn
ngữ tự nhiên — ví dụ: 'người dùng này thích phong cách học kiểu gì?' — và nó trả lời bằng một
insight có căn cứ suy luận, chứ không phải chữ thô."

【MÀN HÌNH: minh họa ví dụ hỏi–đáp dialectic (không cần gõ code)】

〔Đọc〕
"Để bạn hình dung: bạn nói với nó 'tôi thích giải thích ngắn gọn, có ví dụ'. Deriver xử lý trong
nền. Rồi sau này bạn hỏi 'người dùng thích phong cách giải thích thế nào?' — và nó trả lời 'ưa ngắn
gọn, kèm ví dụ cụ thể'. Nó không đọc lại nguyên văn — nó _tổng hợp và lập luận_. Đó chính là
'dialectic', suy luận biện chứng. Một kho lưu trữ thông thường không bao giờ làm được điều này."

---

## [08:00] KIẾN TRÚC THẬT TRONG REPO — năm service

【MÀN HÌNH: mở `../README.md` phần Architecture — sơ đồ 5 service nối nhau】

〔Đọc〕
"Giờ ta rời lý thuyết, nhìn vào hệ thống thật mà lát nữa bạn sẽ dựng. Trong repo này, Honcho không
phải một cục — nó gồm _năm service_ phối hợp với nhau.

Một, `hermes-agent` — đây là dashboard chat và bộ não hành động, cái bạn trực tiếp trò chuyện.

Hai, `honcho-api` — API bộ nhớ, nơi lưu message và trả về ngữ cảnh hay insight.

Ba, `honcho-deriver` — chính là worker nền ta vừa nói, lo suy luận và cập nhật representation.

Bốn, PostgreSQL với pgvector — nơi lưu message và tìm kiếm ngữ nghĩa bằng vector.

Năm, Redis — làm cache và hàng đợi tác vụ cho deriver.

Hermes ở trên cùng gọi xuống Honcho API; Honcho API nói chuyện với Postgres và Redis; còn Deriver
chạy nền, đọc hàng đợi và cập nhật vào Postgres."

【MÀN HÌNH: khung nhấn mạnh — "2 điều sẽ gặp lại khi deploy"】

〔Đọc〕
"Mình gieo trước hai điều, vì lát nữa lúc deploy bạn sẽ đụng lại chúng và sẽ 'à, ra thế'.

Thứ nhất: Deriver _không có HTTP server_. Nó là worker nền thuần túy. Nên tuyệt đối đừng đặt
healthcheck kiểu HTTP cho nó — làm vậy là deploy fail ngay.

Thứ hai: Honcho dùng SQLAlchemy, nên nó cần URL Postgres ở dạng `postgresql+psycopg://`. Railway
lại trả về dạng `postgresql://` thuần. Đừng lo — entrypoint trong repo tự chuyển đổi giúp bạn từ
biến `DATABASE_URL`. Chi tiết ở Bài 06 và 07."

---

## [11:00] HERMES "NÓI CHUYỆN" VỚI HONCHO THẾ NÀO

【MÀN HÌNH: đoạn config `memory: provider: honcho` + biến `HONCHO_BASE_URL`】

〔Đọc〕
"Câu hỏi tự nhiên: làm sao Hermes biết dùng Honcho làm bộ nhớ? Câu trả lời gọn: qua config.

Trong file `hermes/config.yaml`, có một dòng đặt `memory`, `provider`, `honcho`. Chỉ vậy là Hermes
chọn Honcho làm memory provider. Rồi nó kết nối bằng biến môi trường `HONCHO_BASE_URL` — và thêm
`HONCHO_API_KEY` nếu bạn bật xác thực.

Khi Honcho được kích hoạt, Hermes có thêm một bộ công cụ mới: `honcho_profile`, `honcho_search`,
`honcho_context`, `honcho_reasoning`, và `honcho_conclude`. Kèm theo là bộ lệnh dòng lệnh
`hermes honcho`. Bạn chưa cần thuộc tên chúng đâu — mình chỉ muốn bạn biết chúng tồn tại, vì ta sẽ
dùng thật ở Bài 09 và tinh chỉnh sâu ở Bài 16."

---

## [12:15] DỌN VÀI HIỂU LẦM

【MÀN HÌNH: bảng "Hiểu lầm — Sự thật"】

〔Đọc〕
"Vài hiểu lầm hay gặp, dọn cho sạch.

'Honcho chỉ là một database lưu chat.' Không — nó _suy luận_ và _mô hình hóa_ người dùng, chứ không
chỉ lưu.

'Suy luận nền sẽ làm chat bị chậm.' Không — Deriver chạy bất đồng bộ, tách hẳn khỏi đường chat.

'Chỉ người dùng mới là peer.' Sai — cả agent cũng là peer, và đó là nền cho multi-agent, tách ngữ
cảnh.

Và 'không có Redis với Postgres thì Honcho vẫn chạy.' Không — Honcho _cần_ Postgres có pgvector, và
_cần_ Redis. Nhớ điều này trước khi deploy."

---

## [13:00] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: sơ đồ đầy đủ + nút "Bài tiếp: Bảo mật & guardrails"】

〔Đọc〕
"Tóm gọn cả bài. Honcho là bộ nhớ hiểu người. Phần 'lưu', đồng bộ: Workspace, tới Peer, tới
Session, tới Message. Phần 'hiểu', bất đồng bộ: Deriver tạo ra Representation và trả lời qua
Dialectic. Repo triển khai nó thành năm service. Còn Hermes gắn vào Honcho qua một dòng config và
biến `HONCHO_BASE_URL`. Đây chính là thứ khiến trợ lý của bạn 'càng dùng càng hiểu bạn'.

Nhưng khoan dựng đã. Vì ta sắp trao cho AI khá nhiều quyền, nên bài tiếp theo là một bài _bắt buộc_:
bảo mật và guardrails. Đừng bỏ qua — mình hứa ngắn gọn và thực tế. Hẹn gặp ở Bài 04."

【[14:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- Ẩn dụ búp bê Nga / tòa nhà–con người–cuộc trò chuyện–câu nói ở [02:45]: nên có animation lồng ghép để 'dính' trí nhớ.
- Tên service (`honcho-api`, `honcho-deriver`, pgvector, Redis) giữ nguyên tiếng Anh, đọc rõ từng chữ.
- Hai cảnh báo deploy [08:00] (deriver không HTTP; scheme `postgresql+psycopg`) nên có cue chữ to — học viên sẽ tua lại đúng chỗ này ở Bài 06/07.
- `postgresql+psycopg://` đọc: "pốt-grét-quy-eo cộng p-si-cốp" hoặc chiếu chữ và nói "đúng như trên màn hình" để tránh đọc sai.
