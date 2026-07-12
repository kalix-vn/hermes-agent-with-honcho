# 🎙️ VO — Bài 16: Honcho nâng cao — tinh chỉnh & multi-agent

> **Thời lượng mục tiêu:** ~16 phút · **Tông giọng:** chuyên sâu nhưng bình dân hóa, ví von dễ hiểu, "làm chủ các núm vặn".
> **Kịch bản dạy học tương ứng:** [`../16-honcho-nang-cao.md`](../16-honcho-nang-cao.md)
> ⚠️ **Điều kiện:** đã kiểm chứng trí nhớ Honcho (Bài 09).

---

## [00:00] MỞ MÀN — mở nắp capo

【MÀN HÌNH: hình ẩn dụ bảng điều khiển với các núm vặn — chi phí ↔ độ sâu】

〔Đọc〕
"Honcho mặc định đã tốt — bạn thấy rồi ở Bài 09. Nhưng khi dùng nhiều, bạn sẽ muốn **tự tay điều
chỉnh**. Có nên để nó suy luận sâu hơn — thông minh hơn nhưng tốn hơn? Hay tiết kiệm lại? Và nếu cả
gia đình cùng nhắn một con bot, làm sao Honcho **không trộn** hồ sơ mọi người vào nhau?

Bài này cho bạn đúng các 'núm vặn' đó. Mình sẽ giải thích từng cái bằng ngôn ngữ đời thường, để bạn
làm chủ Honcho thực thụ. Bắt đầu."

【MÀN HÌNH: Title card — "Bài 16 · Honcho nâng cao"】

〔Đọc〕
"Một lưu ý: tất cả các núm này bạn chỉnh qua lệnh `hermes honcho` trong shell, hoặc mục cấu hình
memory tương ứng. Và có tài liệu Honcho đầy đủ của Hermes trên GitHub nếu bạn muốn đào sâu hơn nữa."

---

## [01:20] PHẦN 1 — Ba núm cốt lõi: cadence và depth

【MÀN HÌNH: bảng 3 núm — contextCadence, dialecticCadence, dialecticDepth】

〔Đọc〕
"Bắt đầu với ba núm quan trọng nhất — chúng quyết định cán cân giữa **chi phí** và **độ sâu**.

Núm thứ nhất: `contextCadence`. Nó nghĩa là cứ bao nhiêu lượt chat thì Honcho gọi API lấy context
một lần. Mặc định là **một** — tức mỗi lượt đều lấy. Tăng con số này lên thì gọi thưa hơn — **rẻ
hơn**, nhưng ngữ cảnh sẽ 'cũ' hơn một chút.

Núm thứ hai: `dialecticCadence`. Cứ bao nhiêu lượt thì chạy **suy luận LLM** một lần. Mặc định là
**hai**. Tăng lên thì suy luận thưa hơn — rẻ hơn, nhưng cập nhật chậm hơn.

Núm thứ ba: `dialecticDepth` — độ sâu suy luận. Đây là số vòng suy luận nhiều lượt. Mặc định là
**một**. Tăng lên thì nó nghĩ **sâu hơn — thông minh hơn**, nhưng cũng **tốn hơn**."

〔Đọc〕
"Nói gọn cho dễ nhớ. Muốn **tiết kiệm**: tăng `dialecticCadence`, và giữ `dialecticDepth` bằng một.
Muốn **thông minh tối đa** cho một use case quan trọng: tăng `dialecticDepth`, và tăng cả
`dialecticReasoningLevel` mà lát nữa mình nói tới."

---

## [03:40] PHẦN 2 — Độ sâu lập luận & ngân sách token

【MÀN HÌNH: bảng — dialecticReasoningLevel, contextTokens, dialecticMaxChars, messageMaxChars】

〔Đọc〕
"Nhóm núm thứ hai là về mức lập luận và ngân sách token.

`dialecticReasoningLevel` — mức lập luận nền. Mặc định là **low**. Nó có năm nấc: minimal, low,
medium, high, và max. Càng cao càng nghĩ kỹ, càng tốn.

`contextTokens` — ngân sách token cho phần context bơm vào. Mặc định là **null**, tức không giới
hạn.

`dialecticMaxChars` — tối đa bao nhiêu ký tự insight được chèn vào system prompt. Mặc định **sáu
trăm**.

Và `messageMaxChars` — tối đa ký tự mỗi message gửi tới API. Mặc định **hai mươi lăm nghìn**."

〔Đọc〕
"Về cái `dialecticMaxChars` sáu trăm: con số nhỏ này giữ cho system prompt **gọn** — insight súc
tích, đi thẳng vào vấn đề. Bạn có thể tăng nếu muốn agent 'ngấm' nhiều ngữ cảnh hơn, nhưng coi
chừng: prompt phình to là **tốn token và loãng**. Đừng tham."

【MÀN HÌNH: gõ `hermes honcho tokens` và `hermes honcho mode`】

〔Đọc〕
"Hai lệnh liên quan để bạn ghi nhớ: `hermes honcho tokens` để xem và đặt ngân sách token; và
`hermes honcho mode` để xem và đặt recall mode — cái ta nói ngay sau đây."

---

## [06:00] PHẦN 3 — recallMode: cách bơm ký ức vào agent

【MÀN HÌNH: bảng 3 giá trị — hybrid, context, tools】

〔Đọc〕
"`recallMode` quyết định Honcho **đưa ký ức vào agent bằng cách nào**. Có ba lựa chọn.

**hybrid** — mặc định. Vừa **bơm sẵn** context vào, vừa cho agent **tự gọi tool** để tra thêm khi
cần. Đây là kiểu cân bằng nhất.

**context**, hay inject-only — chỉ bơm context sẵn, agent không dùng tool.

**tools**, hay tools-only — không bơm gì sẵn cả; agent tự gọi tool khi nó thấy cần."

〔Đọc〕
"Lời khuyên: với người mới, cứ để **hybrid** — cân bằng nhất. Còn nếu bạn muốn **tiết kiệm token**,
`tools-only` là lựa chọn hay — vì nó chỉ tra ký ức khi thật sự cần — đổi lại agent phải chủ động
hơn. Bạn đặt bằng lệnh, ví dụ `hermes honcho mode hybrid`."

---

## [07:40] PHẦN 4 — sessionStrategy: session ánh xạ theo cái gì

【MÀN HÌNH: bảng 4 giá trị — per-directory, per-repo, per-session, global】

〔Đọc〕
"`sessionStrategy` — một phiên, một session, được tính theo cái gì. Bốn kiểu.

**per-directory** — mặc định — mỗi thư mục làm việc là một session.

**per-repo** — mỗi repo là một session.

**per-session** — mỗi phiên tách riêng.

Và **global** — một session xuyên suốt tất cả.

Bạn xem và đặt bằng `hermes honcho strategy`, và liệt kê các ánh xạ hiện có bằng
`hermes honcho sessions`."

〔Đọc〕
"Điểm mấu chốt: mặc định `per-directory` vốn hợp cho một **coding assistant** — làm việc theo thư
mục dự án. Nhưng khóa này của chúng ta là **trợ lý đời sống**, chat qua Telegram. Với kiểu dùng đó,
**global** hoặc **per-session** thường hợp hơn nhiều. Đây là một chỉnh đáng làm sớm."

---

## [09:20] PHẦN 5 — observationMode: quan sát peer

【MÀN HÌNH: bảng 2 giá trị — directional, unified】

〔Đọc〕
"`observationMode` — chế độ quan sát. Nghe hơi trừu tượng, mình giải thích.

**directional** — mặc định — là quan sát **có hướng**. Nghĩa là 'A quan sát B' được tách biệt với
'B quan sát A'. Hai chiều riêng.

**unified** — gộp quan sát lại làm một.

Vì sao directional quan trọng? Nó giúp tách bạch 'Honcho hiểu gì **về bạn**' với 'Honcho hiểu gì
**về agent**'. Cái này đặc biệt có ý nghĩa khi bạn chạy nhiều agent — multi-agent."

---

## [10:40] PHẦN 6 — Multi-agent & nhiều người dùng: peer mapping

【MÀN HÌNH: bảng — pinUserPeer, userPeerAliases, runtimePeerPrefix】

〔Đọc〕
"Đây là phần thực tế nhất cho nhiều người. Khi bạn triển khai một gateway — Telegram hay Slack — mà
có **nhiều người** cùng nhắn **một** agent, bạn cần **ánh xạ danh tính**, gọi là peer mapping. Ba
cấu hình.

`pinUserPeer` — đặt thành true thì **gộp tất cả** người dùng, trừ agent, về **một** peer.

`userPeerAliases` — ánh xạ từng runtime ID sang một tên peer. Ví dụ ID `7654321` map thành `alice`.

`runtimePeerPrefix` — đặt namespace cho những ID lạ, ví dụ `telegram_7654321`."

〔Đọc〕
"Để mình cho một ví dụ đời thường. Cả **gia đình** dùng chung một con bot Telegram. Bạn **chắc chắn
không** muốn Honcho trộn hồ sơ của bố với hồ sơ của em vào làm một — bố hỏi gì lại lôi ngữ cảnh của
em ra thì hỏng. Cách giải: dùng `userPeerAliases`, cho mỗi Telegram ID map thành một peer riêng. Thế
là **mỗi người có một mô hình riêng**, không lẫn ngữ cảnh. Sạch sẽ."

【MÀN HÌNH: gõ `hermes honcho peer`, `hermes honcho identity`, `hermes honcho status`】

〔Đọc〕
"Ba lệnh liên quan: `hermes honcho peer` để xem và cập nhật tên peer; `hermes honcho identity` để
gieo danh tính cho AI peer; và quan trọng nhất — `hermes honcho status` để **kiểm tra toàn bộ cấu
hình** sau khi bạn chỉnh. Luôn chạy `status` để xác nhận thay đổi đã ăn."

【MÀN HÌNH: 'hermes honcho status' hiển thị cadence, mode, strategy, peers sau khi tinh chỉnh】

---

## [13:00] PHẦN 7 — Self-hosted Honcho: base URL & JWT

〔Đọc〕
"Một điểm kỹ thuật cuối. Vì repo này **tự host** Honcho — chạy trên hạ tầng của chính bạn — nên khi
setup wizard hỏi, bạn sẽ gặp hai thứ.

**Base URL** — đây là `HONCHO_BASE_URL`, địa chỉ nội bộ trong Docker hoặc Railway.

**JWT bearer token** — cái này **tùy chọn**. Bạn chỉ cần nó khi bật `AUTH_USE_AUTH=true`, và nó được
ký bằng `AUTH_JWT_SECRET` của server. Token local lưu ở `hosts.<host>.apiKey` trong file
`honcho.json`, tách biệt với credential cloud."

〔Đọc〕
"Lời khuyên gọn: nếu bạn đang **học** hoặc chạy **local**, cứ để `AUTH_USE_AUTH=false` cho nhẹ đầu.
Còn khi lên **production** hoặc expose ra ngoài, thì bật auth và JWT lên cho an toàn."

---

## [14:20] LỖI HAY GẶP — điểm nhanh

【MÀN HÌNH: bảng lỗi thường gặp】

〔Đọc〕
"Vài lỗi hay gặp khi vọc các núm này.

**Chi phí LLM tăng vọt** — thường vì `dialecticDepth` hoặc `ReasoningLevel` đặt quá cao. Hạ về một
và low, tăng `dialecticCadence` lên.

**Hồ sơ nhiều người bị trộn** — chưa cấu hình peer mapping; dùng `userPeerAliases` hoặc
`runtimePeerPrefix`.

**Insight bơm vào quá dài, tràn prompt** — `dialecticMaxChars` để lớn quá; kéo về khoảng sáu trăm.

**Đổi cấu hình mà không thấy ăn** — chưa reload hoặc redeploy; chạy lại `hermes honcho status`, và
redeploy nếu bạn chỉnh qua env."

---

## [15:20] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 16 tick xanh + nút "Bài tiếp: Use case & tự cải thiện"】

〔Đọc〕
"Tóm lại toàn bộ bảng điều khiển. **Cadence và Depth** là cần gạt giữa chi phí và thông minh.
**recallMode, sessionStrategy, observationMode** là cách Honcho nhớ và ánh xạ. Và **peer mapping**
là cách tách hồ sơ khi nhiều người, nhiều agent. Nắm được nhóm này là bạn đã làm chủ Honcho ở tầng
sâu.

Đủ nền tảng rồi. Bài tiếp theo, ta rời khỏi cấu hình và quay lại **giá trị thật**: những use case cụ
thể đáng tự động hóa, và cách khai thác vòng lặp tự cải thiện để agent càng dùng càng giỏi. Hẹn gặp
ở bài mười bảy."

【[16:10] HẾT】

---

### 🎬 Ghi chú sản xuất
- Đây là bài "nặng" nhất về khái niệm — chèn `【MÀN HÌNH: bảng】` đúng lúc để mắt khán giả bám theo, đừng đọc chay.
- Giữ nhịp chậm hơn các bài thao tác; cho khán giả kịp ghi chú tên từng núm.
- Ví dụ "cả gia đình dùng chung bot" ([10:40]) là mấu chốt dễ nhớ — kể có cảm xúc, có thể minh họa 2 avatar.
- Luôn kết mỗi nhóm bằng lệnh `hermes honcho status` trên màn hình để nhấn thói quen "chỉnh xong phải verify".
