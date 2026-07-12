# Module 11 — Kết nối Telegram

> **Thời lượng:** ~12 phút · **Mức độ:** Cơ bản
> **Mục tiêu:** Nhắn tin với agent từ điện thoại qua Telegram, giới hạn chỉ mình bạn được nhắn, và
> biết cách debug khi bot "im lặng".
> **Yêu cầu trước:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md); có tài khoản Telegram (Module 05)

## 🎯 Kết quả sau bài học
- Tạo bot Telegram bằng **BotFather** và lấy **bot token**.
- Cấu hình Hermes dùng token đó và **giới hạn user ID** được phép nhắn.
- Nhắn "hello" từ Telegram và nhận trả lời; biết cách sửa khi gateway lỗi.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Bạn sẽ không muốn lúc nào cũng mở trình duyệt để chat. Telegram là kênh dễ nhất để nhắn
agent từ điện thoại. Lưu ý bảo mật: phải **giới hạn ai được nhắn**, nếu không người lạ có token
là điều khiển được agent của bạn."

---

## 🪜 Các bước thực hiện

### Bước 1 — Tạo bot với BotFather

**Thao tác trên Telegram:**
1. Tìm **`@BotFather`** (đúng cái có **dấu tích xanh**).
2. Gõ `/newbot`.
3. Đặt **display name** (vd. `Hermes Agent`).
4. Đặt **username** — phải **duy nhất** và **kết thúc bằng `_bot`** (vd. `minh_hermes_92413_bot`).
5. BotFather trả về một **token** dạng `123456:ABC-DEF...`.

> ⚠️ **Token = chìa khóa bot.** Ai có token cũng nhắn được bot của bạn. **Không để lộ.**

`【SCREENSHOT: BotFather trả về token (che một phần)】`

### Bước 2 — Lấy Telegram user ID của bạn (để giới hạn)

**Thao tác:** trên Telegram tìm **`@userinfobot`** (hoặc bot "User Info") → gõ `/start` → nó hiện
**ID số** của bạn → sao chép.

`【SCREENSHOT: userinfobot hiển thị ID】`

### Bước 3 — Cấu hình Telegram cho Hermes

〔Nói〕 "Trong bản dashboard này, có 2 cách phổ biến: (a) qua trang **Config/Integrations** của
dashboard nếu có mục Telegram; (b) qua **`hermes setup`** trong shell."

**Cách qua shell (chắc chắn có):**
```bash
docker compose exec hermes sh     # (Railway: dùng nút Shell của service hermes)
hermes setup                      # tới bước 'messaging platform' → chọn Telegram
```
Khi được hỏi:
- **Bot token** → dán token ở Bước 1.
- **Allowed user IDs** → dán ID ở Bước 2 (nhiều người thì ngăn cách bởi dấu phẩy).

> 💡 Token nên đặt như một **secret**. Nếu Hermes yêu cầu qua biến env, đặt bằng:
> ```bash
> hermes config set TELEGRAM_BOT_TOKEN <token>
> ```
> (Không dán token vào ô chat — nhắc lại Module 04.)

### Bước 4 — Nhắn thử từ Telegram

**Thao tác:** mở link bot (BotFather cho link theo username) → bấm **Start** → gõ `hello`.
Mong đợi: bot "typing…" rồi trả lời.

`【SCREENSHOT: cuộc chat Telegram với bot trả lời】`

### Bước 5 — Nếu bot "im lặng" → debug (rất hay gặp)

〔Nói〕 "Lần đầu kết nối, đôi khi bot nhận tin (có dấu tích) nhưng không trả lời. Đừng hoảng —
'siêu năng lực' của Hermes là **tự sửa**."

**Cách 1 — nhờ chính agent (từ dashboard):**
> "Mình đã cấu hình Telegram nhưng khi nhắn từ Telegram, bot nhận (có tích ✓) mà không trả lời/không
> 'typing'. Nguyên nhân có thể là gì? Giúp mình kiểm tra và sửa."

Thường agent phát hiện **Hermes gateway bị dừng** và khởi động lại giúp bạn.

**Cách 2 — kiểm tra thủ công (log):**
```bash
docker compose logs -f hermes | grep -i telegram
```
Xem gateway đã connect Telegram chưa, có lỗi token/permission không.

`【SCREENSHOT: agent tự chẩn đoán và fix gateway Telegram】`

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| Bot nhận tin nhưng không trả lời | Gateway Telegram bị dừng | Nhờ agent restart gateway, hoặc restart service hermes |
| "Unauthorized" | Token sai/bị revoke | Lấy lại token từ BotFather, đặt lại |
| Nhắn mà bot phớt lờ | User ID của bạn chưa nằm trong allowlist | Thêm đúng ID (Bước 2) |
| Người lạ nhắn được bot | Không giới hạn user ID | **Bắt buộc** cấu hình allowed IDs |
| Username bị từ chối | Không kết thúc `_bot` hoặc trùng | Đặt username khác, kết thúc `_bot` |

## ✅ Checklist học viên
- [ ] Có bot token từ BotFather (đã giữ kín).
- [ ] Đã lấy Telegram user ID và đưa vào allowlist.
- [ ] Nhắn "hello" từ Telegram và nhận trả lời.
- [ ] Biết 2 cách debug khi bot im lặng.

## 🧠 Tổng kết
BotFather → token; userinfobot → ID; cấu hình + giới hạn allowlist. Nhắn thử, và nếu lỗi thì
nhờ chính agent sửa gateway. Giờ bạn chat được từ điện thoại — và mọi tin đều vào Honcho.

## ➡️ Tiếp theo
[Module 12 — Tự động backup lên GitHub](./12-github-backup.md)
