# 🎙️ VO — Bài 05: Chuẩn bị môi trường & tài khoản

> **Thời lượng mục tiêu:** ~10 phút · **Tông giọng:** gọn gàng, thực dụng — bài "chuẩn bị nguyên liệu".
> **Kịch bản dạy học tương ứng:** [`../05-chuan-bi-moi-truong.md`](../05-chuan-bi-moi-truong.md)

---

## [00:00] MỞ MÀN — gom đủ "nguyên liệu"

【MÀN HÌNH: Title card — "Bài 05 — Chuẩn bị môi trường & tài khoản"】

〔Đọc〕
"Trước khi dựng bất cứ thứ gì, ta gom đủ 'nguyên liệu' đã. Cứ hình dung như nấu ăn: chuẩn bị sẵn
mọi thứ ra bàn, thì lúc nấu mới trơn tru.

Mình làm sạch bước này thật kỹ, để các module sau bạn không phải dừng giữa chừng đi tạo tài khoản.
Bài này ngắn thôi, nhưng làm cho đủ nhé — nó quyết định các bài sau chạy được ngay lần đầu hay
không."

---

## [00:40] BƯỚC 1 — Lấy OpenAI API key

【THAO TÁC: mở trình duyệt tới platform.openai.com → API keys → Create new secret key】
【MÀN HÌNH: trang tạo API key】

〔Đọc〕
"Bước một, và là bước bắt buộc: lấy một OpenAI API key. Bạn vào platform.openai.com, mở mục
'API keys', bấm 'Create new secret key', rồi sao chép nó ra.

Một điểm hay của repo này: cái key này dùng cho _cả_ Hermes phần chat _lẫn_ Honcho phần trích xuất
bộ nhớ. Bạn chỉ cần nhập nó _một lần_, các service khác sẽ tham chiếu lại. Tiện và đỡ nhầm."

【MÀN HÌNH: Settings → Limits → Usage limits → đặt hạn mức tháng】

〔Đọc〕
"Và đây là chỗ mình nhắc lại từ bài bảo mật, vì nó quan trọng: _đặt spend limit ngay_. Vào
'Settings', 'Limits', 'Usage limits', rồi đặt một hạn mức tháng. Khi đang học, mười tới hai mươi đô
là quá đủ. Cái này giúp bạn tránh một hóa đơn bất ngờ nếu lỡ có gì đó chạy loạn.

À, và một lưu ý: OpenAI không phải lựa chọn bắt buộc. Repo hỗ trợ các endpoint tương thích OpenAI —
như OpenRouter, DeepSeek, Together AI, hay một model chạy local qua vLLM — thông qua biến
`OPENAI_BASE_URL`. Nhưng nếu bạn mới bắt đầu, cứ dùng OpenAI cho đơn giản. Tùy chọn nâng cao mình
để ở Bài 07 và Bài 18."

---

## [03:00] BƯỚC 2 — Tài khoản GitHub

【MÀN HÌNH: github.com trang đăng ký】

〔Đọc〕
"Bước hai: tài khoản GitHub. Bạn cần nó để clone repo, và sau này để làm backup tự động ở Bài 12.
Nếu chưa có, tạo miễn phí tại github.com. Nhanh thôi, một hai phút."

---

## [03:30] BƯỚC 3 — Chọn con đường deploy

【MÀN HÌNH: bảng hai cột — "Docker local (Bài 06)" vs "Railway cloud (Bài 07)"】

〔Đọc〕
"Bước ba: chọn con đường deploy, rồi chuẩn bị cho đúng con đường đó.

Nếu bạn chọn Docker local — tức là Bài 06 — thì cần cài Docker Desktop, hoặc Docker Engine, kèm
Docker Compose. Link ở docs.docker.com.

Nếu bạn chọn Railway cloud — tức là Bài 07 — thì cần một tài khoản Railway, tại railway.com, và bạn
đăng nhập luôn bằng GitHub cho tiện.

Còn nếu bạn chưa chắc chọn cái nào? Lời khuyên của mình: cứ cài Docker để thử local trước. Nó nhẹ
nhàng và miễn phí. Hiểu hệ thống rồi thì đẩy lên Railway sau cũng chẳng muộn."

---

## [05:00] BƯỚC 4 — Tài khoản Telegram

【MÀN HÌNH: app Telegram trên điện thoại】

〔Đọc〕
"Bước bốn: cài Telegram. Cái này để dành cho Bài 11, khi ta kết nối kênh nhắn tin. Bây giờ bạn chỉ
cần cài app Telegram trên điện thoại hoặc máy tính và đăng nhập. Chưa cần tạo bot vội — chuyện đó
để Bài 11 làm."

---

## [05:40] BƯỚC 5 — Clone repo về máy

【THAO TÁC: mở terminal, gõ lệnh git clone】
【MÀN HÌNH: `git clone https://github.com/kalix-vn/hermes-agent-with-honcho.git` rồi `cd hermes-agent-with-honcho`】

〔Đọc〕
"Bước năm: kéo repo về máy. Mình mở terminal và gõ:
`git clone`, rồi địa chỉ repo, `github.com/kalix-vn/hermes-agent-with-honcho`. Xong thì `cd` vào
thư mục vừa tải về.

_(chờ clone xong)_

Rồi. Giờ mình mở thư mục ra cho bạn quen mặt."

【MÀN HÌNH: cây thư mục repo trong VS Code — highlight docker-compose.yml, .env.example, hermes/, honcho/】

〔Đọc〕
"Vài thứ đáng chú ý. `docker-compose.yml` — file này dựng cả năm service ở local, ta dùng ở Bài 06.
`.env.example` — đây là file mẫu biến môi trường, lát nữa ta copy nó thành `.env`. Thư mục `hermes`
là service Hermes. Thư mục `honcho` là service Honcho, gồm cả api lẫn deriver. Còn thư mục `course`
chính là bộ kịch bản khóa học mà bạn đang xem đây."

---

## [07:15] BƯỚC 6 — Tạo file `.env` từ mẫu

【THAO TÁC: gõ `cp .env.example .env`, mở file .env】
【MÀN HÌNH: file .env với dòng OPENAI_API_KEY=sk-...】

〔Đọc〕
"Bước sáu, bước cuối: tạo file `.env` từ mẫu. Mình gõ `cp .env.example .env` — tức là copy file mẫu
thành file `.env` thật.

Rồi mở `.env` ra, tối thiểu điền một dòng: `OPENAI_API_KEY` bằng cái key bạn lấy ở bước một. Nếu
muốn, bạn có thể bỏ comment và đổi luôn mật khẩu dashboard local ở đây — `HERMES_DASHBOARD_USERNAME`
và `HERMES_DASHBOARD_PASSWORD`. Nhưng cái đó không bắt buộc lúc này."

【MÀN HÌNH: chạy `git status` — .env KHÔNG xuất hiện】

〔Đọc〕
"Và đây là một thói quen an toàn mình muốn bạn tập ngay. File `.env` đã nằm trong `.gitignore` —
nghĩa là nó sẽ không bao giờ lên Git. Để kiểm chứng, gõ `git status`. Nếu làm đúng, bạn _không_
thấy `.env` trong danh sách thay đổi. Nếu lỡ thấy nó ở đó, dừng lại — đừng commit, và khôi phục lại
`.gitignore`. Secret không bao giờ được lên Git, nhớ chứ?"

---

## [09:00] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist năm ý tick xanh + hai nút "Bài 06 Docker" / "Bài 07 Railway"】

〔Đọc〕
"Vậy là xong nguyên liệu. Điểm lại: OpenAI key và _đã đặt spend limit_. Tài khoản GitHub, cộng
Railway nếu bạn deploy cloud. Docker nếu bạn deploy local. Đã clone repo, đã tạo `.env` với key. Và
đã xác nhận `.env` không hiện trong `git status`.

Từ đây, con đường tách làm hai. Muốn dựng trên máy mình, đi Bài 06 — Docker. Muốn chạy hai tư trên
bảy trên cloud, nhảy sang Bài 07 — Railway. Bạn chỉ cần theo một nhánh, nhưng mình hướng dẫn cả
hai. Hẹn gặp ở nhánh bạn chọn."

【[10:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- Che/mờ key thật khi quay màn hình OpenAI [00:40] — không để lộ secret trên video.
- Lệnh `git clone` và `cp .env.example .env` nên quay cận cảnh terminal, gõ chậm để khán giả làm theo.
- Nhấn mạnh bước `git status` [07:15] — đây là thói quen an toàn được lặp lại xuyên khóa.
- Cuối bài có hai lối rẽ: cân nhắc để hai nút bấm rõ ràng (Bài 06 / Bài 07) trong phần cuối video.
