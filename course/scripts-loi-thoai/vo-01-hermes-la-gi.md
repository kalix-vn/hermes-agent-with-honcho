# 🎙️ VO — Bài 01: Hermes Agent là gì & tại sao dùng

> **Thời lượng mục tiêu:** ~10 phút · **Tông giọng:** thân thiện, rõ ràng, khơi tò mò — bài nền tảng đầu tiên.
> **Kịch bản dạy học tương ứng:** [`../01-hermes-agent-la-gi.md`](../01-hermes-agent-la-gi.md)

---

## [00:00] MỞ MÀN — hình dung một trợ lý "sống"

【MÀN HÌNH: Title card — "Bài 01 — Hermes Agent là gì?"】

〔Đọc〕
"Chào bạn, mình quay lại đây. Trước khi gõ bất cứ lệnh nào, mình muốn bạn hiểu _thứ chúng ta sắp
dựng_ thật ra là gì.

Hãy hình dung Hermes Agent như một trợ lý AI cá nhân chạy hai tư trên bảy. Nó không chỉ trả lời
như ChatGPT — nó _làm việc_: viết báo cáo, nghiên cứu, soạn email, xem lịch, tìm trên web. Và quan
trọng nhất: nó học về bạn khi bạn dùng, nên càng ngày càng hợp ý bạn hơn."

---

## [00:45] CHATBOT vs AGENT — khác biệt cốt lõi

【MÀN HÌNH: sơ đồ hai khối — "CHATBOT: hỏi → trả lời rồi quên" / "AGENT: giao việc → chọn công cụ → lặp lại → ghi nhớ"】

〔Đọc〕
"Đây là câu hỏi nền tảng nhất: agent khác chatbot ở chỗ nào?

Một chatbot chỉ _nói_. Bạn hỏi, nó gọi mô hình AI, nó trả lời, rồi nó quên. Hết.

Còn một agent thì _làm_. Bạn giao việc, nó gọi mô hình AI, nhưng thay vì trả lời ngay, nó _chọn
công cụ_ — mở web, viết code, gửi email — rồi _quan sát kết quả_, rồi lặp lại nhiều lượt cho tới
khi hoàn thành mục tiêu. Và sau cùng, nó _ghi nhớ_ vào bộ nhớ.

Đó là toàn bộ 'phép thuật'. Không có gì huyền bí cả: một agent chỉ là một phần mềm bao quanh mô
hình AI — quản lý ngữ cảnh, quản lý công cụ, quản lý trí nhớ — rồi gọi mô hình lặp đi lặp lại."

【MÀN HÌNH: highlight vòng lặp "chọn công cụ → quan sát → lặp lại"】

---

## [02:15] BẢN CHẤT — Hermes là lớp phần mềm bao quanh LLM

〔Đọc〕
"Nói rõ hơn một chút. Một mô hình ngôn ngữ lớn — gọi tắt là LLM, ví dụ GPT, Claude, hay Gemini —
thật ra chỉ làm được đúng một việc: đưa chữ vào, trả chữ ra. Thế thôi.

Hermes là lớp phần mềm ngồi bao quanh cái LLM đó. Nó quản lý ngữ cảnh — tức là thông tin đưa vào
mô hình. Nó cấp công cụ — trình duyệt, code, email. Và nó quản lý trí nhớ với phiên làm việc. Rồi
nó gọi LLM nhiều lần để đạt mục tiêu bạn giao.

Có một điểm mình muốn bạn nhớ kỹ: LLM là _bộ não thuê ngoài_. Bạn hoàn toàn có thể đổi từ OpenAI
sang Anthropic, sang Gemini, hay một model chạy local — mà agent vẫn chạy bình thường. Trong repo
của khóa này, mặc định mình dùng OpenAI cho cả phần chat lẫn phần trích xuất bộ nhớ."

---

## [03:45] VÌ SAO HERMES PHỔ BIẾN — ba điểm mạnh

【MÀN HÌNH: ba thẻ lần lượt hiện: "① Tự học" · "② Chạy 24/7" · "③ Đa LLM"】

〔Đọc〕
"Vậy tại sao nhiều người chọn Hermes? Mình gói lại thành ba điểm mạnh.

Thứ nhất, vòng lặp tự học. Đây chính là thứ tách Hermes ra khỏi các framework khác như OpenClaw.
Hermes _tự xây kỹ năng trong nền_ dựa trên cách bạn dùng, mà không cần bạn yêu cầu. Càng dùng, nó
càng giỏi. Chi tiết cái này mình để dành cho Bài 02.

Thứ hai, chạy hai tư trên bảy và chủ động. Đặt nó trên một server thì nó luôn bật, và có thể tự
chạy các tác vụ định kỳ — mình gọi là cron — mà không cần bạn ra lệnh. Mình sẽ làm cái này ở Bài
15.

Thứ ba, đa LLM. Bạn không bị khóa vào một nhà cung cấp duy nhất. Nhà cung cấp này tăng giá hay có
model mới tốt hơn, bạn đổi được ngay."

---

## [05:30] KHI NÀO KHÔNG NÊN DÙNG HERMES

【MÀN HÌNH: biểu tượng cân nhắc — "Hợp / Không hợp"】

〔Đọc〕
"Mình muốn nói thẳng, để bạn chọn đúng công cụ chứ không phí thời gian.

Nếu bạn chỉ cần _một_ automation đơn lẻ, cố định — kiểu 'mỗi khi có form mới thì lưu vào Google
Sheet' — thì thật ra một workflow đơn giản như Zapier, hoặc n8n, hoặc một đoạn script sẽ gọn hơn
nhiều. Đừng dùng dao mổ trâu để cắt bánh.

Hermes hợp với ai? Hợp với người trò chuyện với trợ lý thường xuyên, giao nhiều loại việc khác
nhau, và muốn một trợ lý 'sống' cùng mình, hiểu mình dần theo thời gian. Nếu đó là bạn, thì bạn
đang ở đúng chỗ."

---

## [06:45] BA HIỂU LẦM THƯỜNG GẶP

【MÀN HÌNH: bảng "Hiểu lầm — Sự thật"】

〔Đọc〕
"Trước khi đi tiếp, mình dọn sẵn vài hiểu lầm hay gặp.

Hiểu lầm một: 'Agent thông minh sẵn, cắm là chạy hoàn hảo.' Không đâu. Nó cần bạn cấu hình, cấp
công cụ, và _dạy_ dần.

Hiểu lầm hai: 'Đây chỉ là ChatGPT tự host thôi.' Không. ChatGPT chỉ chat. Hermes _hành động_ và
_nhớ_.

Hiểu lầm ba: 'Càng nhiều vòng lặp càng tốt.' Cũng không. Càng nhiều vòng lặp thì càng tốn token,
tốn tiền. Mặc định thường là đủ.

Và cuối cùng: 'Tự học nghĩa là mình không cần dạy gì cả.' Sai. Nó học _từ cách bạn dùng_. Bạn dùng
càng rõ ràng, nó học càng tốt."

---

## [08:15] HERMES TRONG KHÓA NÀY KHÁC BẢN GỐC

【MÀN HÌNH: sơ đồ "Hermes + Honcho" với mũi tên bộ nhớ】

〔Đọc〕
"Một điểm nữa để bạn phân biệt. Bản Hermes gốc mà bạn thấy trên mạng dùng bộ nhớ mặc định của
Hermes. Khóa này thì khác: mình ghép thêm _Honcho_ — một tầng nhớ chuyên sâu hơn hẳn.

Vì sao lại cần Honcho, và Honcho thật ra là gì — đó là câu chuyện của Bài 03. Còn bây giờ, bạn chỉ
cần nhớ: khóa này không phải Hermes 'trơn', mà là Hermes cộng một bộ não trí nhớ mạnh hơn."

---

## [09:00] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist ba ý tick xanh + nút "Bài tiếp: Kiến trúc & 5 khái niệm"】

〔Đọc〕
"Tóm lại một câu: Hermes là phần mềm bao quanh LLM, cấp cho nó công cụ, bộ nhớ và một vòng lặp, để
nó _hành động_ chứ không chỉ trả lời. Nó nổi bật vì tự học, chạy hai tư trên bảy, và không khóa
vào một nhà cung cấp.

Ở bài tiếp theo, mình mổ xẻ Hermes ra thành năm mảnh ghép cốt lõi. Hiểu năm mảnh đó rồi thì về sau
mỗi lần bạn chỉnh cái gì, bạn đều biết _mình đang chỉnh cái gì và tại sao_. Hẹn gặp ở Bài 02."

【[10:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- Sơ đồ chatbot vs agent ở [00:45] nên hiện _song song_ hai khối để khán giả so sánh trực tiếp.
- "24/7" đọc thống nhất "hai tư trên bảy" — giống Bài 00.
- Nhấn giọng ở [03:45] khi nói "tự học" — đây là điểm bán hàng chính, được nhắc lại xuyên khóa.
- Giữ đoạn "khi nào KHÔNG nên dùng" [05:30] thành thật, không né — nó tạo uy tín cho người dạy.
