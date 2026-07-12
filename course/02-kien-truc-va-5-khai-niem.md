# Module 02 — Kiến trúc & 5 khái niệm cốt lõi

> **Thời lượng:** ~12 phút · **Mức độ:** Cơ bản
> **Mục tiêu:** Nắm 5 khái niệm nền tảng của Hermes để về sau thao tác nào cũng hiểu "vì sao".
> **Yêu cầu trước:** [Module 01](./01-hermes-agent-la-gi.md)

## 🎯 Kết quả sau bài học
- Kể tên và giải thích **5 khái niệm**: Memory · Skills · Soul · Crons · Self-improvement.
- Hiểu **cấu trúc thư mục** của một Hermes agent và ý nghĩa các file quan trọng.
- Hiểu **progressive disclosure** — vì sao Hermes tiết kiệm token.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Trước khi dựng, ta cần hiểu 5 mảnh ghép tạo nên Hermes. Hiểu 5 cái này rồi thì mọi thao
tác về sau bạn đều biết mình đang chỉnh cái gì và tại sao."

**Thao tác màn hình:** chiếu sơ đồ 5 khái niệm.

```
        ┌──────────────────────── HERMES AGENT ────────────────────────┐
        │  ① MEMORY     ② SKILLS     ③ SOUL     ④ CRONS   ⑤ SELF-IMPROVE │
        │   (nhớ bạn)   (kỹ năng)   (tính cách) (định kỳ)  (tự nâng cấp) │
        └───────────────────────────────┬──────────────────────────────┘
                                         ▼
                                   LLM (bộ não)
```

---

## 🪜 Nội dung bài học

### ① Memory — trí nhớ

Khi cài Hermes, bạn nhận một **cấu trúc thư mục** gồm file markdown, config, biến môi trường, và
thư mục `memory/`. Hai file quan trọng nhất:

| File | Chứa gì |
|------|---------|
| `user.md` | Thông tin về **bạn**: tên, tuổi, nơi ở, sở thích, phong cách mong muốn |
| `memory.md` | **Sự thật dài hạn** agent cần luôn nhớ khi trò chuyện với bạn |

〔Nói〕 "Bạn **không cần tự sửa** các file này — Hermes tự cập nhật. Nhưng biết chúng tồn tại giúp
bạn hiểu 'hậu trường'."

> 📌 **Điểm mấu chốt của khóa:** Ở bản Hermes chuẩn, memory là các file `.md` cục bộ. Trong khóa
> này ta **thay/bổ sung** bằng **Honcho** — tầng nhớ mạnh hơn nhiều: nó không chỉ lưu chữ mà còn
> *suy luận* và *mô hình hóa* bạn. Chi tiết ở [Module 03](./03-honcho-la-gi.md).

### ② Skills — kỹ năng

**Skill = một file markdown** mô tả: *skill này là gì*, *khi nào dùng*, và *các bước thực hiện*.

〔Nói〕 "Thay vì mỗi lần bạn phải viết lại 5 bước 'cách kiểm tra email', ta có sẵn một *email
skill*. Bạn nói 'kiểm tra email', agent tra skill và làm theo — nhất quán, dự đoán được."

- Hermes có **~90 skill built-in** + **500+ skill cộng đồng** + bạn **tự tạo** được.
- **Progressive disclosure (tiết lộ dần):** lúc khởi động, agent chỉ nạp **tên + mô tả** của các
  skill, **không nạp toàn bộ nội dung**. Chỉ khi cần dùng skill nào mới nạp đầy đủ skill đó.

〔Nói〕 "Nhờ vậy agent không phải nhồi hàng trăm nghìn ký tự mỗi lần chạy → **tiết kiệm token, tiết
kiệm tiền**."

`【SCREENSHOT: ví dụ một file skill .md với phần 'khi nào dùng' + 'các bước'】`

### ③ Soul — tính cách / persona

**Soul = một file markdown mô tả cách agent hành xử**: nghiêm túc hay thân thiện, dùng emoji hay
không, xưng hô ra sao, giọng điệu thế nào.

〔Nói〕 "Bạn **không cần tự viết** file này. Chỉ cần nói 'hãy chỉnh soul của bạn để luôn ngắn gọn,
trực tiếp, mang tính giáo dục' — agent tự cập nhật." *(Ta thực hành ở [Module 10](./10-onboarding-user-va-soul.md).)*

### ④ Crons — tác vụ định kỳ (automations)

〔Nói〕 "Đây là lúc Hermes bắt đầu thật sự hữu ích. Bạn hẹn nó làm việc theo lịch: mỗi sáng gửi
tóm tắt email, mỗi tối nhắc uống thuốc, mỗi Chủ nhật chạy audit bảo mật…"

- **Agent reactive** = chờ bạn ra lệnh.
- **Agent proactive** = tự chạy nền theo lịch. Crons biến Hermes thành proactive.

*(Thực hành ở [Module 15](./15-tu-dong-hoa-cron.md).)*

### ⑤ Self-improvement loop — vòng lặp tự cải thiện

〔Nói〕 "Đây là điểm quan trọng nhất, tách Hermes khỏi OpenClaw. Khi bạn làm việc, agent học về
bạn, lưu vào memory, và **tự xây skill mới trong nền** — không cần bạn yêu cầu. Bạn lặp lại một
việc vài lần, nó tự tạo skill để nhớ *cách bạn thích làm việc đó*."

> 💡 Trong khóa này, vòng lặp đó được **tăng cường bằng Honcho**: Honcho chạy 'deriver' nền để
> liên tục cập nhật hiểu biết về bạn sau mỗi lượt trò chuyện.

---

## ⚠️ Lỗi/hiểu lầm thường gặp
| Hiểu lầm | Sự thật |
|----------|---------|
| "Phải tự viết user.md/soul.md/skill bằng tay" | Không — nói bằng lời, agent tự tạo/cập nhật. |
| "Bật nhiều skill thì agent luôn chậm/tốn token" | Không — progressive disclosure chỉ nạp skill khi cần. |
| "Cron chỉ chạy được mỗi ngày" | Không — mỗi giờ/tuần/tháng/tùy biểu thức đều được. |

## ✅ Checklist học viên
- [ ] Kể được 5 khái niệm và một câu mô tả mỗi cái.
- [ ] Giải thích được progressive disclosure.
- [ ] Hiểu vai trò `user.md` và `memory.md` (và biết Honcho sẽ thay thế/nâng cấp mảng này).

## 🧠 Tổng kết
5 mảnh ghép: **Memory** (nhớ) · **Skills** (kỹ năng, nạp dần) · **Soul** (tính cách) · **Crons**
(định kỳ) · **Self-improvement** (tự nâng cấp). Tất cả chỉ là các file được quản lý quanh LLM.
Khóa này nâng cấp mảng "Memory" bằng Honcho.

## ➡️ Tiếp theo
[Module 03 — Honcho là gì & tại sao ghép với Hermes](./03-honcho-la-gi.md)
