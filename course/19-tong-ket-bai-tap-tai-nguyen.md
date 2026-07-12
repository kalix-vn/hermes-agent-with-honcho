# Module 19 — Tổng kết, bài tập & tài nguyên

> **Thời lượng:** ~8 phút · **Mức độ:** Tất cả
> **Mục tiêu:** Chốt lại toàn bộ hành trình, giao đồ án "tốt nghiệp", và chỉ đường học tiếp.
> **Yêu cầu trước:** Đã đi qua các phần A–D.

## 🎯 Kết quả sau bài học
- Tự đánh giá bằng **checklist tốt nghiệp**.
- Hoàn thành một **đồ án** tổng hợp nhiều kỹ năng đã học.
- Biết nguồn tài nguyên để đi xa hơn.

---

## 🧭 Nhìn lại toàn bộ hành trình

〔Nói〕 "Chúc mừng! Từ số 0, giờ bạn có một trợ lý AI tự host, có trí nhớ Honcho thật, chat qua
Telegram, chạm được Gmail/lịch, chạy tác vụ tự động, tự backup và tự cải thiện."

Sơ đồ tổng những gì đã dựng:
```
Bạn ──(Telegram/Dashboard)──► HERMES ──► công cụ: web, browser, Composio(Gmail/Calendar), cron
                                 │
                                 ├──► HONCHO (API + Deriver) ──► Postgres(pgvector) + Redis
                                 │        └─ nhớ bạn xuyên phiên, mô hình hóa bạn, dialectic
                                 └──► GitHub backup (auto-commit, quay lui phiên bản)
```

---

## ✅ Checklist "tốt nghiệp"

**Nền tảng & bảo mật**
- [ ] Giải thích được Hermes vs Honcho, và 5 khái niệm cốt lõi.
- [ ] Không bao giờ dán secret vào chat; chỉ expose Hermes.

**Triển khai**
- [ ] Dựng được hệ thống (Docker *hoặc* Railway) với 5 service khỏe.
- [ ] Dashboard có đăng nhập; deriver không healthcheck HTTP.

**Bộ nhớ Honcho**
- [ ] Chứng minh được trí nhớ xuyên phiên (wow moment).
- [ ] Chỉnh được ≥1 núm Honcho (cadence/mode/strategy).

**Kết nối & tự động hóa**
- [ ] Telegram hoạt động, có allowlist.
- [ ] Backup GitHub tự động chạy.
- [ ] Kết nối Composio (Gmail/Calendar) và làm được việc thật.
- [ ] Có ≥2 cron hữu ích.

**Vận hành**
- [ ] Biết xem log, kiểm soát chi phí, tra sự cố, và quy trình khẩn cấp.

> 🎓 Đủ hết = bạn đã làm chủ hệ thống Hermes + Honcho.

---

## 📝 Đồ án tổng hợp (chọn 1)

### Đồ án 1 — "Trợ lý buổi sáng" hoàn chỉnh
Xây một cron **morning brief 7h** gộp: email quan trọng 24h + lịch hôm nay + top 3 việc cần làm.
Yêu cầu: dùng Composio, định dạng do bạn quy định, và qua **2 vòng phản hồi** để agent tự cải thiện
độ dài/nội dung. **Nộp:** ảnh brief ngày 1 vs ngày 3 (thấy sự cải thiện) + `cron/jobs.json`.

### Đồ án 2 — "Gia sư cá nhân hóa"
Cron học ngoại ngữ mỗi tối: dạy 5 từ + quiz từ hôm trước, và **nhờ Honcho nhớ** từ bạn hay sai để
lặp lại. **Nộp:** minh chứng phiên mới nhớ đúng trình độ/từ hay sai của bạn (test kiểu Module 09).

### Đồ án 3 — "Bot gia đình đa người dùng"
Cho 2 người cùng nhắn bot qua Telegram, cấu hình **peer mapping** (Module 16) để Honcho **không
trộn hồ sơ**. **Nộp:** minh chứng mỗi người được trả lời theo hồ sơ riêng.

---

## 📚 Tài nguyên đi xa hơn

- **Repo khóa học:** [`kalix-vn/hermes-agent-with-honcho`](https://github.com/kalix-vn/hermes-agent-with-honcho) — đọc `README.md`, `docker-compose.yml`, `hermes/`, `honcho/`.
- **Hermes Agent:** <https://github.com/NousResearch/hermes-agent>
- **Tài liệu tích hợp Honcho (Hermes):** [features/honcho.md](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md)
- **Honcho (Plastic Labs):** <https://github.com/plastic-labs/honcho> · <https://honcho.dev>
- **Composio:** <https://app.composio.dev>
- **Railway:** <https://railway.com>
- **Kịch bản video gốc (tham khảo bối cảnh):** [`../plan.md`](../plan.md)

### Hướng mở rộng gợi ý
- Thêm kênh **Slack** (hợp cho công việc) bên cạnh Telegram.
- Dùng **multi-model**: model rẻ cho task nhẹ, model mạnh cho suy luận sâu.
- Kết nối **Notion/Drive/Sheets** cho quy trình phức tạp hơn.
- Bật **Honcho auth (JWT)** nếu cần expose API cho client ngoài.
- Nâng browser lên **Browserbase/Firecrawl** khi làm nhiều web automation.

---

## 🧠 Lời kết

〔Nói〕 "Đây không phải phép màu. Nhưng đặt đúng, nó tiết kiệm cho bạn hàng giờ mỗi tuần và ngày
càng hiểu bạn hơn nhờ Honcho. Sức mạnh thật nằm ở chỗ bạn **sáng tạo ra use case của riêng mình**
rồi cứ thế dùng và phản hồi. Chúc bạn xây được trợ lý xịn!"

## ➡️ Quay lại
[Mục lục khóa học](./README.md)
