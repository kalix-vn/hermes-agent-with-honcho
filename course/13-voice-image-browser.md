# Module 13 — Voice, hình ảnh & browser automation

> **Thời lượng:** ~10 phút · **Mức độ:** Trung cấp
> **Mục tiêu:** Bật và kiểm thử 3 khả năng đa phương thức: giọng nói (TTS/STT), đọc ảnh, và tự
> động hóa trình duyệt (screenshot/đọc web).
> **Yêu cầu trước:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md)

## 🎯 Kết quả sau bài học
- Gửi/nhận **voice message** (speech-to-text & text-to-speech).
- Gửi **ảnh** cho agent (với model có thị giác) và để nó mô tả.
- Cài **agent browser** để agent chụp màn hình + đọc nội dung trang web.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Agent không chỉ đọc/viết chữ. Nó nghe được (STT), nói được (TTS), nhìn ảnh được, và duyệt
web được. Ba khả năng này mở ra nhiều use case thực tế."

---

## 🪜 Các bước thực hiện

### Bước 1 — Kiểm thử giọng nói (STT + TTS)

**Thao tác (Telegram tiện nhất):** gửi một **voice message**:
> (nói) "Bạn nghe được mình không? Nhắc lại giúp mình câu vừa nói."

Mong đợi: agent **transcribe** đúng (STT). Rồi thử:
> "Gửi cho mình một voice message nói 'hello world'."

Mong đợi: agent trả về **voice** (TTS).

〔Nói〕 "Với cấu hình mặc định, agent đã có TTS/STT cơ bản (free). Muốn giọng tự nhiên hơn có thể
đổi nhà cung cấp TTS (vd. ElevenLabs) trong Config — không bắt buộc."

`【SCREENSHOT: voice message gửi và agent trả lời bằng voice】`

### Bước 2 — Gửi ảnh cho agent (thị giác)

**Thao tác:** đính kèm một ảnh (screenshot, hóa đơn, biểu đồ…) và hỏi:
> "Trong ảnh này có gì? Tóm tắt các ý chính."

> 💡 Cần **model có thị giác** (đa số model hiện đại đều có). Nếu agent nói không xem được ảnh →
> đổi sang model hỗ trợ vision trong Config.

`【SCREENSHOT: agent mô tả nội dung ảnh】`

### Bước 3 — Browser automation: thử → thường FAIL lần đầu

**Thao tác:** gửi:
> "Truy cập `example.com`, chụp màn hình và cho mình biết trang có gì."

〔Nói〕 "Lần đầu **thường báo lỗi** — kiểu 'Chrome/agent browser chưa được cài'. Đây là chuyện
bình thường, không phải bạn làm sai."

`【SCREENSHOT: lỗi 'agent browser is not installed'】`

### Bước 4 — Cài agent browser rồi thử lại

**Thao tác:** nếu agent chưa tự cài, ra lệnh:
> "Hãy **cài agent browser** rồi thử lại tác vụ chụp màn hình trang đó."

Sau khi cài, agent chụp được màn hình và mô tả nội dung (hero, nút, section…).

`【SCREENSHOT: agent chụp & mô tả trang web sau khi cài browser】`

### Bước 5 — Hiểu 2 loại "web": Search vs Browser automation

| Loại | Làm gì | Ghi chú |
|------|--------|---------|
| **Search** | Tìm kiếm web, lấy thông tin | Nhẹ, đủ cho phần lớn nhu cầu |
| **Browser automation** | Điều khiển trình duyệt thật: click, chụp, render JS | Nặng hơn; local browser là *headless* (không render JS phức tạp) |

〔Nói〕 "Local browser **headless** chỉ kéo được HTML, không render JS nặng. Nếu bạn làm **nhiều**
tác vụ duyệt web phức tạp (bypass CAPTCHA, nhiều tab, đa vùng), cân nhắc dịch vụ trả phí như
**Browserbase** hoặc **Firecrawl** (~$20/tháng, có credit free). Còn lại thì local browser là đủ."

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| "agent browser is not installed" | Runtime browser chưa cài | Ra lệnh "cài agent browser" rồi thử lại |
| Agent không đọc được ảnh | Model không có vision | Đổi sang model hỗ trợ ảnh |
| Trang JS-nặng đọc thiếu nội dung | Local browser headless | Dùng Browserbase/Firecrawl |
| Voice không hoạt động | Provider TTS/STT sai cấu hình | Kiểm tra Config; giữ mặc định free để test |

## ✅ Checklist học viên
- [ ] Gửi & nhận được voice message.
- [ ] Agent mô tả được nội dung một ảnh.
- [ ] Cài agent browser và chụp/đọc được một trang web.
- [ ] Phân biệt Search vs Browser automation.

## 🧠 Tổng kết
Agent nghe–nói–nhìn–duyệt web. Voice/ảnh gần như sẵn sàng; browser automation cần **cài agent
browser** lần đầu. Web phức tạp thì cân nhắc dịch vụ trả phí. Các khả năng này là nền cho use
case thật ở module sau.

## ➡️ Tiếp theo
[Module 14 — Kết nối công cụ thật với Composio](./14-ket-noi-cong-cu-composio.md)
