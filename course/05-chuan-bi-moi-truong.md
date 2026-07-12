# Module 05 — Chuẩn bị môi trường & tài khoản

> **Thời lượng:** ~10 phút · **Mức độ:** Cơ bản
> **Mục tiêu:** Chuẩn bị đủ tài khoản, key và công cụ để 100% các module sau chạy trơn tru trên
> lần đầu.
> **Yêu cầu trước:** [Module 04](./04-bao-mat-va-guardrails.md)

## 🎯 Kết quả sau bài học
- Có **OpenAI API key** (đã đặt spend limit) và biết dán vào đâu.
- Có sẵn tài khoản **GitHub**, **Railway** (nếu deploy cloud), **Telegram**.
- Cài xong **Docker** (nếu deploy local) và **clone repo**.

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Trước khi dựng, ta gom đủ 'nguyên liệu'. Làm sạch bước này thì các module sau không phải
dừng lại giữa chừng đi tạo tài khoản."

---

## 🪜 Các bước thực hiện

### Bước 1 — Lấy OpenAI API key (bắt buộc)

**Thao tác:** vào <https://platform.openai.com> → **API keys** → **Create new secret key** → sao chép.

〔Nói〕 "Key này dùng cho **cả Hermes (chat) lẫn Honcho (trích xuất bộ nhớ)** — trong repo mình
chỉ cần nhập **một lần**, các service khác tham chiếu lại."

> ⚠️ **Đặt spend limit ngay** (nhắc lại từ Module 04): **Settings → Limits → Usage limits** →
> đặt hạn mức tháng (vd. $10–20 khi học). Tránh hóa đơn bất ngờ.

`【SCREENSHOT: trang tạo API key + trang đặt usage limit】`

> 💡 **Không bắt buộc OpenAI:** repo hỗ trợ endpoint tương thích OpenAI (OpenRouter, DeepSeek,
> Together AI, vLLM local…) qua `OPENAI_BASE_URL`. Người mới cứ dùng OpenAI cho đơn giản; tùy
> chọn nâng cao xem [Module 07](./07-trien-khai-railway.md) (Bước 7) và [Module 18](./18-van-hanh-chi-phi-troubleshooting.md).

### Bước 2 — Tài khoản GitHub (bắt buộc)

- Cần để **clone repo** và làm **backup tự động** ([Module 12](./12-github-backup.md)).
- Nếu chưa có: tạo miễn phí tại <https://github.com>.

### Bước 3 — Chọn con đường deploy → chuẩn bị tương ứng

| Nếu chọn… | Cần chuẩn bị |
|-----------|-------------|
| **Docker local (Module 06)** | Cài **Docker Desktop / Docker Engine** + Docker Compose: <https://docs.docker.com/get-docker/> |
| **Railway cloud (Module 07)** | Tài khoản **Railway**: <https://railway.com> (đăng nhập bằng GitHub) |

〔Nói〕 "Chưa chắc chọn cái nào thì cứ cài Docker để thử local trước — nhẹ nhàng và miễn phí."

### Bước 4 — Tài khoản Telegram (cho Module 11)

- Cài app Telegram trên điện thoại/máy tính, đăng nhập.
- Chưa cần tạo bot vội — sẽ làm ở [Module 11](./11-ket-noi-telegram.md).

### Bước 5 — Clone repo về máy

**Lệnh:**
```bash
git clone https://github.com/Avanix-AI/hermes-agent-with-honcho.git
cd hermes-agent-with-honcho
```

**Thao tác:** mở thư mục repo, chiếu cấu trúc để học viên quen mặt:
```
hermes-agent-with-honcho/
├── docker-compose.yml     # dựng 5 service ở local (Module 06)
├── .env.example           # mẫu biến môi trường → copy thành .env
├── hermes/                # service Hermes (Dockerfile, config.yaml, entrypoint)
├── honcho/                # service Honcho (api + deriver)
├── README.md              # tài liệu song ngữ
└── course/                # 👈 bộ kịch bản khóa học (đang đọc)
```

`【SCREENSHOT: cây thư mục repo trong VS Code】`

### Bước 6 — Tạo file `.env` từ mẫu

**Lệnh:**
```bash
cp .env.example .env
```
Mở `.env`, tối thiểu điền:
```bash
OPENAI_API_KEY=sk-...            # key ở Bước 1
# (tùy chọn) đổi mật khẩu dashboard local:
# HERMES_DASHBOARD_USERNAME=admin
# HERMES_DASHBOARD_PASSWORD=doi-mat-khau-manh
```

> ⚠️ `.env` **đã nằm trong `.gitignore`** — tuyệt đối không commit. Kiểm chứng:
> ```bash
> git status        # .env KHÔNG được xuất hiện trong danh sách thay đổi
> ```

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| `git: command not found` | Chưa cài Git | Cài Git: <https://git-scm.com> |
| `docker: command not found` | Chưa cài/khởi động Docker | Cài & mở Docker Desktop |
| OpenAI báo `insufficient_quota` | Chưa nạp tiền / hết hạn mức | Nạp credit + kiểm tra usage limit |
| `.env` xuất hiện trong `git status` | `.gitignore` bị sửa | Không commit; khôi phục `.gitignore` |

## ✅ Checklist học viên
- [ ] Có `OPENAI_API_KEY` và **đã đặt spend limit**.
- [ ] Có tài khoản GitHub (+ Railway nếu deploy cloud).
- [ ] Đã cài Docker (nếu deploy local).
- [ ] Đã `git clone` repo và tạo `.env` với `OPENAI_API_KEY`.
- [ ] Xác nhận `.env` **không** hiện trong `git status`.

## 🧠 Tổng kết
Nguyên liệu: OpenAI key (có spend limit), GitHub, và Docker *hoặc* Railway. Clone repo, tạo
`.env`. Xong bước này là sẵn sàng dựng hệ thống ở module tiếp theo.

## ➡️ Tiếp theo
- Deploy local: [Module 06 — Docker Compose](./06-trien-khai-local-docker.md)
- Deploy cloud: [Module 07 — Railway](./07-trien-khai-railway.md)
