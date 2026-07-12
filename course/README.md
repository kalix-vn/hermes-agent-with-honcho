# 🧠 Khóa học: Hermes Agent + Honcho Memory (từ số 0 đến vận hành thật)

> Bộ **kịch bản giảng dạy chi tiết** (teaching script) cho toàn khóa. Mỗi module là một file
> Markdown độc lập, viết theo cấu trúc "vừa để giảng viên quay/giảng, vừa để học viên
> mở ra làm theo và tua lại". Mọi lệnh, thao tác, lỗi thường gặp đều được ghi rõ.

---

## 🎯 Khóa học này dành cho ai?

- Người **mới hoàn toàn** với AI agent, chưa cần biết lập trình.
- Người muốn tự **host một AI assistant chạy 24/7** có **bộ nhớ dài hạn thật** (không phải chatbot quên trước quên sau).
- Người muốn hiểu **tại sao Hermes + Honcho** mạnh hơn một chatbot thường: Hermes lo *hành động & kỹ năng*, Honcho lo *trí nhớ & mô hình hóa người dùng*.

## 🧩 Học viên sẽ có gì sau khóa?

Một hệ thống Hermes Agent tự host, kết nối tầng bộ nhớ Honcho, biết:
- Ghi nhớ bạn **xuyên phiên, xuyên thiết bị, xuyên lần restart**.
- Nhắn tin qua **Telegram / dashboard web**.
- Kết nối **Gmail, Google Calendar…** qua Composio.
- Chạy **tác vụ định kỳ** (email triage, morning brief, security audit…).
- **Tự backup** lên GitHub và **tự cải thiện** kỹ năng theo thời gian.

---

## 🗺️ Lộ trình & mục lục

Khóa chia làm **5 phần**. Số phút là thời lượng gợi ý cho bản video/buổi giảng.

### PHẦN A — Nền tảng (hiểu trước khi làm)
| # | Module | Thời lượng | Nội dung cốt lõi |
|---|--------|-----------|------------------|
| 00 | [Tổng quan & cách dùng bộ kịch bản](./00-tong-quan-va-lo-trinh.md) | 8' | Bản đồ khóa học, quy ước, chuẩn bị tinh thần |
| 01 | [Hermes Agent là gì & tại sao dùng](./01-hermes-agent-la-gi.md) | 10' | Agent vs chatbot, so với OpenClaw/Claude Code |
| 02 | [Kiến trúc & 5 khái niệm cốt lõi](./02-kien-truc-va-5-khai-niem.md) | 12' | Memory · Skills · Soul · Crons · Self-improvement |
| 03 | [Honcho là gì & tại sao ghép với Hermes](./03-honcho-la-gi.md) | 14' | Peer/Session/Workspace, dialectic, representation |
| 04 | [Bảo mật & guardrails (đọc trước khi deploy)](./04-bao-mat-va-guardrails.md) | 10' | Prompt injection, chi phí, least-privilege, secrets |

### PHẦN B — Triển khai (dựng hệ thống)
| # | Module | Thời lượng | Nội dung cốt lõi |
|---|--------|-----------|------------------|
| 05 | [Chuẩn bị môi trường & tài khoản](./05-chuan-bi-moi-truong.md) | 10' | OpenAI key, GitHub, Railway, Telegram, Docker |
| 06 | [Cách A — Deploy local bằng Docker Compose](./06-trien-khai-local-docker.md) | 18' | 5 service, `docker compose up`, kiểm tra health |
| 07 | [Cách B — Deploy lên Railway (1-click + tự build template)](./07-trien-khai-railway.md) | 20' | One-click, 9 bước tự dựng, public domain |
| 08 | [Chạy lần đầu & tham quan Dashboard](./08-cau-hinh-lan-dau-va-dashboard.md) | 14' | Đăng nhập, Config, iterations/compression/session |

### PHẦN C — Bộ nhớ Honcho (điểm khác biệt của khóa)
| # | Module | Thời lượng | Nội dung cốt lõi |
|---|--------|-----------|------------------|
| 09 | [Kiểm chứng bộ nhớ Honcho hoạt động](./09-kiem-chung-bo-nho-honcho.md) | 12' | Test nhớ xuyên phiên, `hermes honcho status` |
| 10 | [Onboarding: User & Soul (persona của agent)](./10-onboarding-user-va-soul.md) | 12' | user.md, soul.md, dạy agent hiểu bạn |
| 16 | [Honcho nâng cao — tinh chỉnh & multi-agent](./16-honcho-nang-cao.md) | 16' | dialecticCadence/depth, recallMode, peers |

### PHẦN D — Kết nối & tự động hóa (làm cho nó *hữu ích*)
| # | Module | Thời lượng | Nội dung cốt lõi |
|---|--------|-----------|------------------|
| 11 | [Kết nối Telegram](./11-ket-noi-telegram.md) | 12' | BotFather, giới hạn người nhắn, debug gateway |
| 12 | [Tự động backup lên GitHub](./12-github-backup.md) | 10' | PAT fine-grained, `hermes config set`, auto-commit |
| 13 | [Voice, hình ảnh & browser automation](./13-voice-image-browser.md) | 10' | TTS/STT, đọc ảnh, cài agent browser |
| 14 | [Kết nối công cụ thật với Composio](./14-ket-noi-cong-cu-composio.md) | 14' | Gmail, Calendar, dạy agent chọn đúng skill |
| 15 | [Tác vụ định kỳ (Crons/Automations)](./15-tu-dong-hoa-cron.md) | 14' | Email triage, morning brief, security audit |

### PHẦN E — Vận hành & làm chủ
| # | Module | Thời lượng | Nội dung cốt lõi |
|---|--------|-----------|------------------|
| 17 | [Use case thực tế & vòng lặp tự cải thiện](./17-use-cases-va-self-improvement.md) | 14' | Kế toán tự động, habit tracker, daily wrap-up |
| 18 | [Vận hành, chi phí & troubleshooting](./18-van-hanh-chi-phi-troubleshooting.md) | 14' | Logs, chi phí token, sự cố hay gặp |
| 19 | [Tổng kết, bài tập & tài nguyên](./19-tong-ket-bai-tap-tai-nguyen.md) | 8' | Checklist tốt nghiệp, đồ án, đọc thêm |

> 💡 **Thứ tự đề xuất:** 00 → 05 tuần tự. Từ module 06 chọn **một** cách deploy (A *hoặc* B).
> Sau khi hệ thống chạy (module 08–09), phần D có thể học theo nhu cầu, không bắt buộc tuần tự.

### 🎁 Đi kèm khóa học
- **🌐 Trang mục lục trực quan (HTML):** [`landing.html`](./landing.html) — mở bằng trình duyệt để
  xem toàn bộ 20 bài dạng thẻ, có light/dark theme, link tới nội dung trên GitHub.
- **🎙️ Kịch bản lời thoại (word-for-word):** [`scripts-loi-thoai/`](./scripts-loi-thoai/) — VO đọc
  thẳng trước camera cho bài mở màn ([`vo-00`](./scripts-loi-thoai/vo-00-tong-quan.md)) và bài "wow
  moment" ([`vo-09`](./scripts-loi-thoai/vo-09-wow-moment.md)), kèm mốc thời gian &amp; cue màn hình.
- **🖼️ Ảnh/media:** [`assets/`](./assets/) — nơi chứa screenshot; chạy `grep -rn "【SCREENSHOT" .`
  để liệt kê mọi ảnh cần chụp.

---

## 🧾 Quy ước dùng chung trong mọi module

Mỗi file module đều có cùng khung sau — học viên chỉ cần lướt tiêu đề để biết đang ở đâu:

- **🎯 Kết quả sau bài học** — học xong làm được gì (đo được).
- **🧭 Bối cảnh / dẫn dắt** — lời thoại gợi ý cho giảng viên (talking track).
- **🪜 Các bước thực hiện** — thao tác màn hình + lệnh + lời thoại + gợi ý ảnh chụp `【SCREENSHOT】`.
- **⚠️ Lỗi thường gặp** — bảng triệu chứng → nguyên nhân → cách sửa.
- **✅ Checklist học viên** — để tự đối chiếu là đã làm đúng.
- **🧠 Tổng kết** và **➡️ Tiếp theo**.

Ký hiệu:
- `【SCREENSHOT: ...】` = chỗ giảng viên nên chụp/quay màn hình khi làm video.
- `〔Nói〕` = câu thoại gợi ý đọc trước camera.
- `> ⚠️` = cảnh báo dễ sai. `> 💡` = mẹo.

---

## 🛠️ Tài liệu gốc & nguồn tham khảo

- Repo triển khai (chính khóa học này bám theo): [`Avanix-AI/hermes-agent-with-honcho`](https://github.com/Avanix-AI/hermes-agent-with-honcho)
- Hermes Agent (NousResearch): <https://github.com/NousResearch/hermes-agent>
- Honcho (Plastic Labs): <https://github.com/plastic-labs/honcho> · <https://honcho.dev>
- Tài liệu tích hợp Honcho trong Hermes: [features/honcho.md](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md)
- Kịch bản video tham khảo gốc (Tech with Tim): xem [`../plan.md`](../plan.md)

> 📌 **Lưu ý quan trọng về sự khác biệt:** Video gốc (`plan.md`) dựng Hermes trên **VPS Hostinger** và
> dùng bộ nhớ mặc định. Khóa này dựng Hermes **kèm Honcho** trên **Docker/Railway** (theo repo).
> Vì vậy phần *khái niệm* (Phần A) tái sử dụng ý tưởng từ video, nhưng phần *thao tác deploy*
> (Phần B–C) bám theo **repo thật này** — chi tiết trong từng module.
