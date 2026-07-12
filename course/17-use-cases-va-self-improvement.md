# Module 17 — Use case thực tế & vòng lặp tự cải thiện

> **Thời lượng:** ~14 phút · **Mức độ:** Trung cấp
> **Mục tiêu:** Biến hệ thống thành thứ *hữu ích thật* qua các use case cụ thể, và hiểu cách khai
> thác vòng lặp tự cải thiện (Hermes skills + Honcho).
> **Yêu cầu trước:** [Module 14](./14-ket-noi-cong-cu-composio.md), [Module 15](./15-tu-dong-hoa-cron.md)

## 🎯 Kết quả sau bài học
- Triển khai được ≥1 use case đầu-cuối (vd. kế toán tự động).
- Biết cách "huấn luyện" agent qua phản hồi để nó tự cải thiện.
- Có tư duy chọn use case đáng tự động hóa (ROI thời gian).

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Nhiều tutorial dừng ở 'dựng xong'. Phần này mới là giá trị: **dùng nó vào việc thật**. Mình
sẽ đi vài use case mà mình thấy thật sự tiết kiệm thời gian, và cách để agent càng dùng càng giỏi."

---

## 🪜 Nội dung bài học

### 1. Use case A — Kế toán tự động (hóa đơn)

**Mục tiêu:** email nào là hóa đơn → tự lưu vào Google Drive, thư mục `receipts`.

**Thao tác — tạo cron:**
> "Mỗi khi mình nhận email mới, kiểm tra xem có phải hóa đơn/biên nhận không. Nếu đúng, tải file
> đính kèm và **lưu vào Google Drive, thư mục `receipts`**, đặt tên `YYYY-MM-DD_<người bán>`. Cuối
> ngày gửi mình danh sách hóa đơn đã lưu."

**Cần:** Composio (Gmail + Drive) — [Module 14](./14-ket-noi-cong-cu-composio.md).

`【SCREENSHOT: thư mục Drive receipts được agent tự điền】`

### 2. Use case B — Morning brief đa nguồn

> "Mỗi sáng 7h: tổng hợp email quan trọng 24h qua + sự kiện lịch hôm nay + (tùy) tin ngành mình
> quan tâm. Trả về **top action items** dạng gạch đầu dòng, tối đa 10 dòng."

〔Nói〕 "Càng nhiều nguồn kết nối, brief càng giá trị. Bắt đầu nhỏ, thêm dần."

### 3. Use case C — Tối ưu lịch

> "Xem lịch tuần này, chỉ ra khoảng trống, và đề xuất chèn 3 block: tập thể dục, deep work, học.
> Nếu mình đồng ý, tạo event tương ứng."

### 4. Use case D — Habit tracker / học ngoại ngữ

> "Mỗi ngày 21h: dạy mình **5 từ tiếng Nhật N4**, kèm ví dụ câu. Sau đó quiz mình 3 từ đã học hôm
> trước. Ghi nhớ từ nào mình hay sai để lặp lại."

〔Nói〕 "Đây là chỗ Honcho tỏa sáng: nó nhớ **bạn hay sai từ nào**, trình độ ra sao — nên bài học
cá nhân hóa dần."

### 5. Use case E — Daily wrap-up

> "Cuối mỗi ngày 22h: hỏi mình đã làm gì, tổng hợp những gì hoàn thành (từ email/lịch), và gợi ý 1
> điều cải thiện cho ngày mai."

### 6. Vòng lặp tự cải thiện — cách khai thác

**Nguyên tắc:** *phản hồi ngắn, cụ thể, lặp lại → agent tự sửa skill + Honcho ghi sở thích.*

Ví dụ vòng lặp với morning brief:
1. Ngày 1: brief hơi dài. Bạn nói: *"Ngắn hơn, tối đa 5 dòng, bỏ mục thời tiết."*
2. Agent cập nhật skill `morning-brief` + Honcho ghi 'user thích brief ngắn'.
3. Ngày 2: brief đã đúng ý hơn — **không cần nhắc lại**.

〔Nói〕 "Đó là điểm khác biệt cốt lõi so với framework khác: bạn **không phải** tự viết skill hay
nhắc lại mỗi ngày. Bạn *dùng và phản hồi*, nó *tự tiến hóa*."

`【SCREENSHOT: agent cập nhật skill sau phản hồi của bạn】`

### 7. Chọn use case đáng làm (tư duy ROI)

| Câu hỏi tự vấn | Vì sao |
|----------------|--------|
| Việc này mình làm **lặp lại** hằng ngày/tuần? | Lặp lại = đáng tự động |
| Nó tốn **thời gian thủ công** đáng kể? | ROI cao |
| Mình có **dữ liệu/tài khoản** để agent chạm? | Không có kết nối thì cron vô dụng |
| Rủi ro nếu agent làm sai có **chấp nhận được**? | Bắt đầu từ việc ít rủi ro |

〔Nói〕 "Đừng cố tự động hóa mọi thứ. Chọn 2–3 việc lặp lại tốn thời gian nhất — làm tốt vài cái
còn hơn làm dở chục cái."

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| Agent làm nhưng kết quả nhạt | Prompt use case mơ hồ | Nêu rõ input/output/định dạng |
| "Cải thiện" không thấy | Phản hồi chung chung ("tốt hơn đi") | Phản hồi cụ thể, đo được |
| Tự động hóa việc ít giá trị | Chọn sai use case | Áp bảng ROI ở mục 7 |
| Lo sợ agent hành động sai | Trao quyền write quá sớm | Read-only trước; xác nhận trước khi gửi/xóa |

## ✅ Checklist học viên
- [ ] Triển khai ≥1 use case đầu-cuối (chạy thật).
- [ ] Thực hiện 1 vòng phản hồi và thấy agent cải thiện.
- [ ] Chọn được 2–3 use case ROI cao cho riêng mình.

## 🧠 Tổng kết
Giá trị nằm ở use case thật: kế toán, brief, lịch, học tập, wrap-up. Khai thác vòng tự cải thiện
bằng phản hồi cụ thể — Hermes sửa skill, Honcho ghi sở thích. Chọn việc lặp lại, tốn thời gian, ít
rủi ro để bắt đầu.

## ➡️ Tiếp theo
[Module 18 — Vận hành, chi phí & troubleshooting](./18-van-hanh-chi-phi-troubleshooting.md)
