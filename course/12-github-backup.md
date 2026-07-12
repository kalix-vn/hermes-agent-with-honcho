# Module 12 — Tự động backup lên GitHub

> **Thời lượng:** ~10 phút · **Mức độ:** Trung cấp
> **Mục tiêu:** Cho agent tự sao lưu cấu hình/skills/memory lên một repo GitHub **private**, để
> không mất công sức khi server hỏng, và có thể "quay lui" phiên bản.
> **Yêu cầu trước:** [Module 08](./08-cau-hinh-lan-dau-va-dashboard.md); có tài khoản GitHub

## 🎯 Kết quả sau bài học
- Tạo repo **private** + **fine-grained PAT** chỉ có quyền `contents: read/write` trên đúng repo đó.
- Đặt token đúng cách (`hermes config set GITHUB_TOKEN ...`), **không** dán vào chat.
- Ra lệnh cho agent backup và bật **auto-commit** khi có thay đổi quan trọng.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Càng dùng, agent càng quý — nó tích lũy memory, skills, cấu hình. Nếu mất VPS/mất container
mà không backup thì mất trắng. GitHub vừa là **backup**, vừa là **lịch sử phiên bản** để quay lui
khi agent 'xuống phong độ'."

---

## 🪜 Các bước thực hiện

### Bước 1 — Tạo repo GitHub **private**

**Thao tác:** GitHub → **New repository** → tên vd. `hermes-agent-backup` → **Visibility: Private**
→ **Create repository**. Để trống, mở sẵn tab này.

> ⚠️ **Bắt buộc Private.** Backup có thể chứa thông tin nhạy cảm.

`【SCREENSHOT: tạo repo private】`

### Bước 2 — Tạo Fine-grained Personal Access Token (least-privilege)

**Thao tác:** GitHub → ảnh đại diện → **Settings → Developer settings → Personal access tokens →
Fine-grained tokens → Generate new token**:
- **Name:** `hermes-backup-repo`
- **Expiration:** đặt hạn (vd. 90 ngày) — bảo mật hơn "no expiration".
- **Repository access:** **Only select repositories** → chọn đúng repo `hermes-agent-backup`.
- **Permissions → Repository permissions → Contents → Read and write**.
- **Generate token** → sao chép (chỉ hiện 1 lần).

〔Nói〕 "Ta cấp **đúng một quyền, trên đúng một repo** — least-privilege như đã học ở Module 04.
Lỡ lộ thì thiệt hại tối thiểu, và revoke được ngay."

`【SCREENSHOT: cấu hình PAT với contents read/write trên 1 repo】`

### Bước 3 — Đặt token vào Hermes (ĐÚNG CÁCH)

**Mở shell Hermes** rồi:
```bash
hermes config set GITHUB_TOKEN <dán-PAT-ở-đây>
```
> ⚠️ **Không** dán PAT vào ô chat. Lệnh này lưu token vào env bí mật của Hermes, không vào log/LLM.

`【SCREENSHOT: 'hermes config set GITHUB_TOKEN' báo đã lưu】`

### Bước 4 — Ra lệnh backup lần đầu

**Thao tác (từ dashboard/Telegram):** gửi prompt kèm URL repo:
> "Mình đã cấp cho bạn một GitHub fine-grained PAT có quyền trên **một** repo. Đây là URL:
> `https://github.com/<user>/hermes-agent-backup`. Hãy **backup cấu hình và trạng thái Hermes hiện
> tại** lên repo này, **KHÔNG** đưa lên bất kỳ secret/API key/thông tin nhạy cảm nào."

Agent sẽ clone repo, chọn lọc file và push. (Có thể hỏi phê duyệt lệnh — chọn "Always" cho thao
tác clone/push repo backup này.)

`【SCREENSHOT: repo GitHub sau backup — có skills/state/memory/cron/config】`

### Bước 5 — Rà soát repo (an toàn)

**Thao tác:** mở repo, kiểm tra **không có secret nào lọt** (env, token, key). Nếu thấy → yêu cầu
agent xóa file đó và commit lại.

> 💡 Backup của bản Docker/Railway khác VPS: nhiều secret nằm ở env service (không nằm trong thư
> mục agent), nên rủi ro lộ thấp hơn — nhưng vẫn phải rà.

### Bước 6 — Bật auto-commit khi có thay đổi

**Thao tác:** gửi:
> "Từ giờ, **mỗi khi có thay đổi quan trọng** (memory, skills, cấu hình), hãy tự tạo commit mới
> lên repo backup này. Vẫn tuyệt đối không đưa secret lên."

Từ đây agent tự checkpoint trong nền. Xem lịch sử qua tab **Commits** của repo.

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| `403`/`permission denied` khi push | PAT thiếu quyền `contents:write` hoặc sai repo | Tạo lại PAT đúng quyền/đúng repo |
| Backup trống/thiếu | Agent chưa hiểu cần backup gì | Nêu rõ: skills, memory, config, cron |
| Vô tình có secret trong repo | Agent đưa nhầm file env | Xóa file + rotate secret bị lộ ngay |
| Token hết hạn sau vài tháng | Đặt expiration | Tạo PAT mới, `hermes config set` lại |

## ✅ Checklist học viên
- [ ] Repo backup **private**.
- [ ] PAT fine-grained: chỉ `contents: read/write` trên đúng repo.
- [ ] Token đặt qua `hermes config set GITHUB_TOKEN` (không qua chat).
- [ ] Đã backup lần đầu và **rà soát không lộ secret**.
- [ ] Đã bật auto-commit khi có thay đổi.

## 🧠 Tổng kết
Repo private + PAT least-privilege + `hermes config set` = backup an toàn. Ra lệnh backup, rà
soát, rồi bật auto-commit. Giờ mọi tiến hóa của agent đều có lịch sử và quay lui được.

## ➡️ Tiếp theo
[Module 13 — Voice, hình ảnh & browser automation](./13-voice-image-browser.md)
