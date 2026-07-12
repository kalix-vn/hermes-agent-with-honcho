# Module 08 — Chạy lần đầu & tham quan Dashboard

> **Thời lượng:** ~14 phút · **Mức độ:** Cơ bản → Trung cấp
> **Mục tiêu:** Làm quen giao diện dashboard, gửi tin nhắn đầu tiên, và hiểu các thiết lập agent
> quan trọng (iterations, tool progress, context compression, session reset).
> **Yêu cầu trước:** [Module 06](./06-trien-khai-local-docker.md) **hoặc** [Module 07](./07-trien-khai-railway.md)

## 🎯 Kết quả sau bài học
- Gửi "hello world" và nhận phản hồi từ agent.
- Hiểu ý nghĩa **max iterations, tool progress mode, context compression, session reset**.
- Biết chỉnh các thiết lập này qua **dashboard Config** hoặc `hermes setup` (trong container/shell).

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Hệ thống đã chạy. Giờ ta làm quen 'buồng lái'. Trong repo này, Hermes phục vụ dưới dạng
**web dashboard** (không phải giao diện terminal TUI như một số bản khác). Nhưng các *khái niệm
cấu hình* thì giống nhau — mình sẽ giải thích từng cái để sau này bạn chỉnh có chủ đích."

---

## 🪜 Các bước thực hiện

### Bước 1 — Đăng nhập & gửi tin nhắn đầu tiên

**Thao tác:** mở dashboard (localhost:3000 hoặc URL Railway), đăng nhập, gõ:
> `Hello world — bạn đang chạy chứ?`

Mong đợi: agent trả lời. Lần chạy đầu có thể mất vài giây để khởi tạo.

`【SCREENSHOT: chat "hello world" và phản hồi】`

> ⚠️ Nếu không trả lời/hiện lỗi → gần như chắc chắn do **OpenAI key** chưa hợp lệ. Đặt key thật
> (trong `.env` rồi `docker compose up -d`, hoặc ở **trang Config** của dashboard / biến env Railway).

### Bước 2 — Tham quan các khu vực chính của dashboard

**Thao tác:** lần lượt mở & mô tả:
- **Chat** — nơi trò chuyện chính.
- **Config / Settings** — nơi đặt key LLM, chọn model, chỉnh thông số agent.
- **Skills** — danh sách kỹ năng (built-in + đã bật). *(Chi tiết Module 02.)*
- **Memory** — trạng thái bộ nhớ; ở bản này gắn với **Honcho** *(Module 09)*.
- **Crons / Tasks** — tác vụ định kỳ *(Module 15)*.

`【SCREENSHOT: sidebar dashboard với các mục Chat/Config/Skills/Memory/Crons】`

### Bước 3 — Hiểu các thiết lập agent quan trọng

〔Nói〕 "Đây là những 'núm vặn' hay gặp. Không cần đổi hết — mình giải thích để bạn biết cái nào
ảnh hưởng gì, đặc biệt là **chi phí** và **trí nhớ**."

| Thiết lập | Ý nghĩa | Gợi ý cho người mới |
|-----------|---------|---------------------|
| **Max iterations** | Số lần gọi LLM tối đa cho **một** yêu cầu | Để mặc định (~90). Cao hơn = chạy sâu/lâu hơn nhưng **tốn token** |
| **Tool progress mode** | Hiện agent đang làm gì: `off` / `new` / `all` / `verbose` | Để **`all`** — thấy hoạt động vừa đủ, không quá rối |
| **Context compression** | Ngưỡng nén hội thoại khi context sắp đầy (0.0–1.0) | Đặt **`0.8`** — nhớ lâu hơn trước khi nén |
| **Session reset mode** | Khi nào tạo phiên mới | **`inactivity + daily reset`** — gọn context, giảm chi phí |
| **Model** | LLM dùng để chat | Model mạnh mới nhất bạn có quyền (vd. dòng GPT mới nhất) |

**Giải thích sâu (talking track):**
- 〔Context compression 0.8〕 "LLM có giới hạn context window. `0.8` nghĩa là khi ngữ cảnh đầy
  ~80% mới nén lại thành bản tóm tắt để đi tiếp — nhớ được lâu hơn so với `0.5`."
- 〔Session reset〕 "Mỗi kênh/thiết bị là một *session*. `inactivity + daily reset` = im lặng một
  lúc hoặc sang ngày mới thì tạo phiên tươi. Ký ức quan trọng **vẫn được Honcho lưu lại** — nên
  reset session không mất trí nhớ dài hạn." *(Điểm mạnh của việc có Honcho — [Module 09](./09-kiem-chung-bo-nho-honcho.md).)*

### Bước 4 — Chỉnh cấu hình ở đâu?

Có 2 nơi:
1. **Dashboard → Config** (khuyến nghị cho người mới): đổi key, model, thông số ngay trên web.
2. **`hermes setup` trong container/shell** (nâng cao): chạy lại wizard cấu hình đầy đủ.

**Mở shell vào container Hermes (bản Docker):**
```bash
docker compose exec hermes sh
# trong container:
hermes setup            # mở wizard cấu hình (provider/model/iterations/...)
hermes --help           # xem các lệnh
```
> 💡 Trên Railway, dùng nút **"Shell"/"Connect"** của service `hermes` để vào tương tự.

> ⚠️ **Đừng dán API key vào ô chat** (nhắc lại Module 04). Key đặt qua Config/env/`hermes config set`.

### Bước 5 — (Tùy chọn) Đặt secret bằng CLI

Khi cần đặt biến bí mật từ shell:
```bash
hermes config set OPENAI_API_KEY sk-...      # ví dụ
```
Secret được lưu vào thư mục env riêng của Hermes, **không** vào log chat.

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| Chat im lặng / lỗi model | Key sai, hết quota, hoặc chọn model không có quyền | Kiểm tra key + usage; đổi model trong Config |
| Đổi Config nhưng không ăn | Chưa lưu/redeploy | Lưu Config; bản Railway cần redeploy nếu đổi env |
| Agent chạy rất lâu/tốn tiền | Max iterations quá cao / prompt mơ hồ | Hạ iterations về mặc định; ra lệnh rõ ràng |
| "Quên" giữa chừng cuộc dài | Context compression quá thấp | Đặt `0.8` |

## ✅ Checklist học viên
- [ ] Gửi & nhận được tin nhắn đầu tiên.
- [ ] Biết vị trí Chat/Config/Skills/Memory/Crons.
- [ ] Giải thích được iterations, tool progress, compression `0.8`, session reset.
- [ ] Biết 2 cách chỉnh config (dashboard vs `hermes setup`).

## 🧠 Tổng kết
Dashboard là buồng lái. Bốn núm quan trọng: iterations (chi phí), tool progress (`all`),
compression (`0.8`), session reset (`inactivity+daily`). Reset session **không** mất trí nhớ dài
hạn vì đã có Honcho — ta chứng minh ở module sau.

## ➡️ Tiếp theo
[Module 09 — Kiểm chứng bộ nhớ Honcho hoạt động](./09-kiem-chung-bo-nho-honcho.md)
