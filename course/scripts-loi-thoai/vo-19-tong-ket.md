# 🎙️ VO — Bài 19: Tổng kết, bài tập & tài nguyên

> **Thời lượng mục tiêu:** ~8 phút · **Tông giọng:** ấm áp, tự hào, truyền cảm hứng "khép lại và mở ra"; đây là bài chốt khóa.
> **Kịch bản dạy học tương ứng:** [`../19-tong-ket-bai-tap-tai-nguyen.md`](../19-tong-ket-bai-tap-tai-nguyen.md)
> ⚠️ **Điều kiện:** đã đi qua các phần A đến D.

---

## [00:00] MỞ MÀN — nhìn lại chặng đường

【B-ROLL: montage nhanh cả khóa — dashboard, Telegram, wow moment nhớ đúng, cron chạy sáng sớm】

〔Đọc〕
"Bạn làm được rồi. Dừng lại một giây và nhìn lại xem mình đã đi xa cỡ nào.

Từ **con số không** — không cần biết lập trình — giờ bạn có một trợ lý AI **tự host**, có trí nhớ
Honcho **thật**, chat được qua **Telegram**, chạm được **Gmail** và **lịch**, chạy **tác vụ tự
động**, **tự backup**, và **tự cải thiện** theo bạn. Đây không phải chatbot. Đây là một trợ lý biết
hành động và biết nhớ. Chúc mừng bạn."

【MÀN HÌNH: Title card — "Bài 19 · Tổng kết & tốt nghiệp"】

---

## [00:50] SƠ ĐỒ TỔNG — tất cả những gì đã dựng

【MÀN HÌNH: sơ đồ kiến trúc tổng — Bạn → Hermes → công cụ + Honcho + GitHub backup】

〔Đọc〕
"Đây là bức tranh toàn cảnh những gì bạn đã xây.

**Bạn** — qua Telegram hoặc dashboard — nói chuyện với **Hermes**. Hermes là đôi tay: nó dùng web,
browser, Composio để chạm Gmail và Calendar, và chạy cron.

Song song, Hermes nối vào **Honcho** — gồm API và Deriver — chạy trên **Postgres** với pgvector, và
**Redis**. Đây là tầng trí nhớ: nó nhớ bạn xuyên phiên, mô hình hóa bạn, và suy luận dialectic.

Và tất cả được **backup lên GitHub**, tự động commit, quay lui phiên bản được. Nhìn sơ đồ này, bạn
thấy rõ mình đã ghép được một hệ thống hoàn chỉnh cỡ nào."

---

## [02:00] CHECKLIST TỐT NGHIỆP

【MÀN HÌNH: checklist tốt nghiệp theo 5 nhóm, tick dần】

〔Đọc〕
"Giờ tự chấm điểm mình bằng **checklist tốt nghiệp**. Mình đọc, bạn tự đối chiếu.

**Nền tảng và bảo mật**: bạn giải thích được Hermes khác Honcho ở đâu, và năm khái niệm cốt lõi? Bạn
có chắc mình **không bao giờ dán secret vào chat**, và chỉ expose Hermes?

**Triển khai**: bạn dựng được hệ thống — Docker hoặc Railway — với năm service khỏe? Dashboard có
đăng nhập, và deriver không healthcheck HTTP?

**Bộ nhớ Honcho**: bạn chứng minh được trí nhớ xuyên phiên — cái wow moment ở Bài 09? Và chỉnh được
ít nhất một núm Honcho?

**Kết nối và tự động hóa**: Telegram chạy có allowlist? Backup GitHub tự động? Composio nối Gmail và
Calendar làm được việc thật? Có ít nhất hai cron hữu ích?

**Vận hành**: bạn biết xem log, kiểm soát chi phí, tra sự cố, và nắm quy trình khẩn cấp?

Nếu tick đủ hết — thì xin chúc mừng, bạn đã **thật sự làm chủ** hệ thống Hermes cộng Honcho."

---

## [04:00] ĐỒ ÁN TỐT NGHIỆP — chọn một

【MÀN HÌNH: 3 thẻ đồ án】

〔Đọc〕
"Và để 'tốt nghiệp' cho ra trò, mình giao **một đồ án** — bạn chọn một trong ba.

**Đồ án một — Trợ lý buổi sáng hoàn chỉnh.** Xây một cron morning brief lúc bảy giờ, gộp email quan
trọng, lịch hôm nay, và top ba việc cần làm. Dùng Composio, định dạng do bạn quy định, và cho nó đi
qua **hai vòng phản hồi** để tự cải thiện. Nộp: ảnh brief ngày một so với ngày ba — để thấy nó khá
lên — kèm file `cron/jobs.json`.

**Đồ án hai — Gia sư cá nhân hóa.** Một cron học ngoại ngữ mỗi tối: dạy năm từ, quiz từ hôm trước,
và **nhờ Honcho nhớ** từ bạn hay sai để lặp lại. Nộp: minh chứng một phiên mới nhớ đúng trình độ và
các từ bạn hay sai — kiểu test như Bài 09.

**Đồ án ba — Bot gia đình đa người dùng.** Cho hai người cùng nhắn bot qua Telegram, cấu hình **peer
mapping** như Bài 16 để Honcho **không trộn hồ sơ**. Nộp: minh chứng mỗi người được trả lời theo hồ
sơ riêng của mình.

Chọn cái nào gần với đời bạn nhất — làm xong một cái là bạn có một trợ lý thật sự dùng được."

---

## [05:40] TÀI NGUYÊN ĐI XA HƠN

【MÀN HÌNH: danh sách link tài nguyên】

〔Đọc〕
"Khóa học khép lại, nhưng hành trình của bạn thì không. Đây là các nguồn để đi xa hơn.

**Repo khóa học** — `Avanix-AI/hermes-agent-with-honcho` — đọc kỹ README, `docker-compose.yml`, và
các thư mục `hermes` và `honcho`.

**Hermes Agent** của NousResearch, và **tài liệu tích hợp Honcho** của Hermes.

**Honcho** của Plastic Labs, tại honcho.dev.

Và các dịch vụ bạn đã dùng: **Composio**, **Railway**.

Tất cả link mình để trong phần mô tả và trong file module gốc."

〔Đọc〕
"Còn vài hướng mở rộng nếu bạn muốn nghịch tiếp: thêm kênh **Slack** cho công việc bên cạnh Telegram;
dùng **multi-model** — model rẻ cho việc nhẹ, model mạnh cho suy luận sâu; nối thêm **Notion, Drive,
Sheets** cho quy trình phức tạp; bật **Honcho auth JWT** nếu cần expose API ra ngoài; và nâng browser
lên **Browserbase** hoặc **Firecrawl** khi làm nhiều web automation."

---

## [07:00] LỜI KẾT — kết thúc khóa học

【MÀN HÌNH: title card cuối + dòng chữ "Cảm ơn bạn đã đồng hành"】

〔Đọc〕
"Và một lời thật lòng để khép lại. Cái này **không phải phép màu**. Nhưng nếu bạn đặt nó đúng chỗ,
nó tiết kiệm cho bạn **hàng giờ mỗi tuần**, và **ngày càng hiểu bạn hơn** nhờ Honcho.

Sức mạnh thật sự không nằm ở những gì mình dạy trong hai mươi bài này — mà nằm ở chỗ **bạn tự sáng
tạo ra use case của riêng mình**, rồi cứ thế dùng và phản hồi, để nó lớn lên cùng bạn.

Cảm ơn bạn đã đi cùng mình từ số không tới đây. Giờ tới lượt bạn: đi ra, xây một thứ hữu ích, và
biến nó thành **của riêng bạn**. Chúc bạn xây được một trợ lý thật xịn. Hẹn gặp lại."

【[08:00] HẾT KHÓA HỌC】

---

### 🎬 Ghi chú sản xuất
- Đây là bài cảm xúc — quay chậm hơn, giọng ấm, để khoảng lặng ở lời kết cho khán giả 'ngấm'.
- Montage mở màn nên tái sử dụng cảnh đắt nhất từ cả khóa (đặc biệt wow moment Bài 09) để gợi hoài niệm.
- Checklist tốt nghiệp ([02:00]): để lên hình đủ lâu cho khán giả tự chấm; cân nhắc chèn hiệu ứng tick dần.
- Kết thúc bằng lời kêu gọi hành động rõ ràng ("đi ra, xây một thứ hữu ích") + màn hình cảm ơn/subscribe.
