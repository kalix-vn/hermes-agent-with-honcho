# Module 01 — Hermes Agent là gì & tại sao dùng

> **Thời lượng:** ~10 phút · **Mức độ:** Cơ bản
> **Mục tiêu:** Hiểu bản chất "AI agent", phân biệt với chatbot, và biết khi nào *nên/không nên* dùng Hermes.
> **Yêu cầu trước:** [Module 00](./00-tong-quan-va-lo-trinh.md)

## 🎯 Kết quả sau bài học
- Giải thích được **agent khác chatbot ở điểm nào** (biết *hành động*, không chỉ *trả lời*).
- Nêu được **3 lý do** Hermes phổ biến (self-learning, chạy 24/7, đa LLM).
- Tự đánh giá được **use case của mình có hợp với Hermes không**.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Hãy hình dung Hermes Agent như một **trợ lý AI cá nhân** chạy 24/7. Nó không chỉ trả lời
như ChatGPT — nó **làm việc**: viết báo cáo, nghiên cứu, soạn email, xem lịch, tìm web. Và quan
trọng nhất: **nó học về bạn khi bạn dùng**, nên càng ngày càng hợp ý bạn hơn."

---

## 🪜 Nội dung bài học

### 1. Chatbot vs Agent — khác biệt cốt lõi

**Thao tác màn hình:** vẽ/chiếu sơ đồ đơn giản.

```
CHATBOT:   bạn hỏi ──► LLM ──► câu trả lời (rồi quên)

AGENT:     bạn giao việc ──► LLM ──► chọn công cụ (web, code, email...)
                              ▲            │
                              └── quan sát kết quả, lặp lại đến khi xong
                                           │
                                    ghi nhớ vào memory
```

〔Nói〕 "Chatbot chỉ *nói*. Agent *làm* — nó có công cụ (tools), có bộ nhớ, và **lặp lại nhiều
lượt gọi LLM** cho tới khi hoàn thành mục tiêu. Đó là toàn bộ 'phép thuật': một phần mềm bao
quanh LLM, quản lý ngữ cảnh + công cụ + trí nhớ, rồi gọi LLM lặp đi lặp lại."

`【SCREENSHOT: sơ đồ chatbot vs agent】`

### 2. Bản chất Hermes chỉ là phần mềm bao quanh LLM

〔Nói〕 "LLM (GPT, Claude, Gemini…) chỉ làm được một việc: đưa text vào → trả text ra. Hermes là
lớp phần mềm **quản lý ngữ cảnh** (thông tin đưa vào LLM), **cấp công cụ** (browser, code…), và
**quản lý trí nhớ/phiên**. Nó gọi LLM nhiều lần để đạt mục tiêu."

Nhấn mạnh: **LLM là bộ não thuê ngoài** — bạn có thể đổi OpenAI ↔ Anthropic ↔ Gemini ↔ model
local mà agent vẫn chạy. (Trong repo này, mặc định dùng OpenAI cho cả chat lẫn trích xuất bộ nhớ.)

### 3. Vì sao Hermes phổ biến — 3 điểm mạnh

1. **Vòng lặp tự học (self-learning).** Đây là điểm tách Hermes khỏi các framework như OpenClaw:
   Hermes **tự xây skill trong nền** dựa trên cách bạn dùng, mà không cần bạn yêu cầu. Càng dùng
   càng giỏi. *(Chi tiết ở [Module 02](./02-kien-truc-va-5-khai-niem.md).)*
2. **Chạy 24/7, proactive.** Đặt trên server → luôn bật, có thể chạy tác vụ định kỳ (cron) mà
   không cần bạn ra lệnh. *(Module 15.)*
3. **Đa LLM.** Không khóa vào một nhà cung cấp.

### 4. Khi nào KHÔNG nên dùng Hermes?

> ⚠️ Nói thẳng để học viên chọn đúng công cụ:
- Nếu bạn chỉ cần **một automation đơn lẻ, cố định** (vd. "mỗi khi có form mới thì lưu vào Sheet")
  → dùng một workflow đơn giản (Zapier/n8n) hoặc script sẽ gọn hơn.
- Hermes hợp với người **trò chuyện thường xuyên, giao nhiều loại việc**, muốn một trợ lý "sống"
  cùng mình và hiểu mình dần.

### 5. Hermes trong khóa này khác gì bản gốc?

〔Nói〕 "Bản gốc trên mạng dùng bộ nhớ mặc định của Hermes. Khóa này ghép thêm **Honcho** — một
tầng nhớ chuyên sâu hơn hẳn. Vì sao và Honcho là gì, ta tìm hiểu ở Module 03."

---

## ⚠️ Hiểu lầm thường gặp
| Hiểu lầm | Sự thật |
|----------|---------|
| "Agent thông minh sẵn, cắm là chạy hoàn hảo" | Không. Nó cần bạn cấu hình, cấp công cụ, và *dạy* dần. |
| "Đây là ChatGPT tự host" | Không. ChatGPT chỉ chat; Hermes *hành động* và *nhớ*. |
| "Càng nhiều iterations càng tốt" | Không. Nhiều iterations = tốn token/tiền hơn. Mặc định là đủ. |
| "Tự học nghĩa là không cần dạy gì" | Nó học *từ cách bạn dùng*. Bạn dùng càng rõ ràng, nó học càng tốt. |

## ✅ Checklist học viên
- [ ] Phân biệt được chatbot vs agent bằng lời của mình.
- [ ] Nêu được 3 điểm mạnh của Hermes.
- [ ] Xác định được use case cá nhân có hợp Hermes không.

## 🧠 Tổng kết
Hermes = phần mềm bao quanh LLM, cấp công cụ + bộ nhớ + vòng lặp, để **hành động** chứ không chỉ
trả lời. Nổi bật vì **tự học**, **chạy 24/7**, **đa LLM**. Khóa này còn ghép thêm Honcho để trí
nhớ mạnh hơn.

## ➡️ Tiếp theo
[Module 02 — Kiến trúc & 5 khái niệm cốt lõi](./02-kien-truc-va-5-khai-niem.md)
