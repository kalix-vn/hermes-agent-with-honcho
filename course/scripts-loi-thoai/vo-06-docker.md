# 🎙️ VO — Bài 06: Deploy local bằng Docker Compose

> **Thời lượng mục tiêu:** ~18 phút · **Tông giọng:** dẫn tay từng bước, trấn an — "làm cùng nhau, không kẹt".
> **Kịch bản dạy học tương ứng:** [`../06-trien-khai-local-docker.md`](../06-trien-khai-local-docker.md)
> ⚠️ **Điều kiện:** đã cài Docker và có file `.env` (Bài 05).

---

## [00:00] MỞ MÀN — một lệnh, năm service

【MÀN HÌNH: Title card — "Bài 06 — Cách A: Deploy local bằng Docker Compose"】

〔Đọc〕
"Đây là cách nhanh nhất để thấy toàn bộ hệ thống sống dậy: một lệnh `docker compose up`, và Docker
tự dựng cả năm service, tự nối mạng nội bộ giữa chúng.

Nhưng mình không muốn bạn chỉ gõ lệnh cho có. Mình sẽ đi qua từng service để bạn hiểu cái nào làm
gì. Hiểu rồi thì khi có trục trặc, bạn biết chính xác chỗ nào để nhìn."

【MÀN HÌNH: mở `../docker-compose.yml`, cuộn qua 5 service: postgres, redis, honcho-api, deriver, hermes】

〔Đọc〕
"Mình mở file `docker-compose.yml` ra. Đây là năm nhân vật: `postgres` là cơ sở dữ liệu, `redis`
là cache và hàng đợi, `honcho-api` là API bộ nhớ, `deriver` là worker suy luận nền, và `hermes` là
dashboard bạn trò chuyện. Đúng năm service ta đã vẽ sơ đồ ở Bài 03. Giờ ta biến sơ đồ thành hệ
thống thật."

---

## [01:30] BƯỚC 1 — Kiểm tra lại `.env`

【THAO TÁC: mở terminal trong thư mục repo】
【MÀN HÌNH: `cd hermes-agent-with-honcho` rồi `cat .env | grep -v '^#' | grep .`】

〔Đọc〕
"Bước một: kiểm tra lại file `.env` trước khi dựng. Mình `cd` vào thư mục repo, rồi gõ một lệnh nhỏ
để in ra các dòng đang thực sự có giá trị — `cat .env`, lọc bỏ dòng comment và dòng trống.

_(xem output)_

Điều tối thiểu mình cần thấy là `OPENAI_API_KEY` bằng một key thật, bắt đầu bằng sk-. Còn các biến
về database hay Redis thì đã có sẵn giá trị mặc định trong compose rồi, nên không bắt buộc phải
điền."

〔Đọc〕
"Nếu muốn đổi thông tin đăng nhập dashboard local, bạn thêm ba dòng vào `.env`:
`HERMES_DASHBOARD_USERNAME`, `HERMES_DASHBOARD_PASSWORD`, và `HERMES_DASHBOARD_SECRET` — cái secret
này nên là một chuỗi dài từ ba mươi hai ký tự trở lên. Còn nếu bạn không đặt gì, mặc định đăng nhập
là `admin` và mật khẩu `hermes-local`. Nhớ hai giá trị đó, lát ta dùng."

---

## [03:15] BƯỚC 2 — Dựng & khởi động toàn bộ

【THAO TÁC: gõ lệnh build】
【MÀN HÌNH: `docker compose up -d --build`】

〔Đọc〕
"Bước hai, khoảnh khắc chính: gõ `docker compose up -d --build`.

Giải thích nhanh hai cái đuôi. `-d` nghĩa là chạy nền — chạy xong nó trả lại terminal cho bạn, chứ
không chiếm màn hình. Còn `--build` nghĩa là build image lần đầu.

Lần đầu tiên sẽ hơi lâu, bạn kiên nhẫn nhé — vì nó phải build Honcho từ mã nguồn, và kéo image
Hermes chính thức về. Cứ để nó chạy, đi pha ly cà phê cũng được."

【MÀN HÌNH: terminal đang build, chờ tới dòng 'Successfully built'】

〔Đọc〕
"_(chờ build xong)_ Khi bạn thấy nó dừng lại và trả terminal về cho bạn, thế là các service đã được
khởi động. Giờ ta đi kiểm tra sức khỏe của chúng."

---

## [05:00] BƯỚC 3 — Kiểm tra trạng thái

【THAO TÁC: gõ lệnh kiểm tra】
【MÀN HÌNH: `docker compose ps` — cột STATUS】

〔Đọc〕
"Bước ba: gõ `docker compose ps` để xem trạng thái.

Cái mình mong thấy: `postgres`, `redis`, `honcho-api`, và `hermes` đều ở trạng thái _healthy_ —
tức khỏe mạnh. Còn `deriver` thì ở trạng thái _running_, hay _Up_ — chứ không phải healthy."

【MÀN HÌNH: khoanh vùng deriver ở trạng thái Up (không healthy)】

〔Đọc〕
"Và đây là chỗ nhiều người tưởng mình hỏng, nên mình nói rõ. _Vì sao deriver không 'healthy'?_ Nhớ
lại Bài 03: deriver là một worker nền, nó _không chạy HTTP server_. Nên một healthcheck kiểu 'gọi
thử đường /health' sẽ không bao giờ pass được với nó. Vì vậy trong compose, mình đã _tắt hẳn
healthcheck_ cho deriver. Với nó, trạng thái `Up` là hoàn toàn bình thường và đúng. Đừng cố 'sửa'
cái này."

---

## [07:00] BƯỚC 4 — Xem log để chắc mọi thứ nối được nhau

【THAO TÁC: xem log】
【MÀN HÌNH: `docker compose logs -f`, `docker compose logs -f hermes`, `docker compose logs -f deriver`】

〔Đọc〕
"Bước bốn: đọc log, để chắc các service thật sự nối được vào nhau.

`docker compose logs -f` cho bạn xem log của _tất cả_ — bấm Control C để thoát. Muốn xem riêng
Hermes thì thêm tên: `docker compose logs -f hermes`. Muốn nhìn deriver xử lý hàng đợi thì
`docker compose logs -f deriver`."

【MÀN HÌNH: log hermes — highlight dòng "✅ Memory provider set to honcho"】

〔Đọc〕
"Trong log của `hermes`, bạn sẽ thấy vài dòng do entrypoint in ra. Có một dòng mình muốn bạn để ý
đặc biệt: dấu tick xanh, 'Memory provider set to honcho'. _Đây_ chính là khoảnh khắc Hermes chọn
Honcho làm bộ nhớ của nó. Và ngay trên đó, dòng 'Honcho URL' cho thấy nó biết gọi Honcho ở đâu —
qua mạng nội bộ của Docker, tại `honcho-api` cổng tám nghìn.

Thấy được dòng tick xanh đó, là bạn biết trái tim của khóa học này — sự kết hợp Hermes cộng Honcho
— đã hoạt động."

---

## [09:15] BƯỚC 5 — Kiểm tra sức khỏe Honcho API

【THAO TÁC: gõ lệnh curl】
【MÀN HÌNH: `curl -i http://localhost:8000/health` → HTTP/1.1 200 OK】

〔Đọc〕
"Bước năm: kiểm tra trực tiếp sức khỏe của Honcho API. Mình gõ `curl -i` rồi
`localhost:8000/health`.

_(xem output)_

Cái mình muốn thấy ở dòng đầu là `HTTP/1.1 200 OK`. Con số hai trăm nghĩa là Honcho API đang sống
và trả lời đàng hoàng. Nếu ra số khác, hoặc không kết nối được, thì quay lại xem log honcho-api."

---

## [10:30] BƯỚC 6 — Mở dashboard & đăng nhập

【THAO TÁC: mở trình duyệt tới localhost:3000, đăng nhập】
【MÀN HÌNH: màn hình đăng nhập rồi vào dashboard】

〔Đọc〕
"Bước sáu — phần thưởng: mở trình duyệt tới localhost cổng ba nghìn.

Bạn sẽ gặp màn hình đăng nhập. Nhập `admin` và mật khẩu `hermes-local` — hoặc giá trị bạn tự đặt
trong `.env`. Và... vào rồi. Đây là dashboard Hermes của bạn, chạy ngay trên máy bạn. Bài 08 mình sẽ
dẫn bạn đi tham quan nó kỹ hơn, còn bây giờ chỉ cần vào được là thắng."

---

## [11:45] BƯỚC 7 — Bảng dịch vụ & cổng

【MÀN HÌNH: bảng — Hermes 3000, Honcho API 8000, health 8000/health, Postgres 5432, Redis 6379】

〔Đọc〕
"Để bạn tiện tra sau này, đây là bảng cổng. Dashboard Hermes ở cổng ba nghìn. Honcho API ở cổng tám
nghìn. Đường health cũng ở tám nghìn, thêm /health. Postgres ở năm bốn ba hai. Redis ở sáu ba bảy
chín.

Và một điểm hardening có sẵn mà mình muốn bạn biết: Postgres và Redis _chỉ_ bind vào 127.0.0.1 —
tức localhost. Nghĩa là chúng không hề lộ ra mạng ngoài. Đúng tinh thần 'chỉ mở đúng cái cần mở' ở
Bài 04."

---

## [12:45] BƯỚC 8 — Dừng & dọn dẹp

【THAO TÁC: gõ lệnh dừng】
【MÀN HÌNH: `docker compose down` và `docker compose down -v`】

〔Đọc〕
"Bước tám: khi cần dừng. Có hai lệnh, và bạn phải phân biệt rõ, vì một cái _rất_ nguy hiểm.

`docker compose down` — dừng hệ thống nhưng _giữ nguyên dữ liệu_, tức là các volume. Lần sau bật
lại, trí nhớ vẫn còn.

Còn `docker compose down -v` — với chữ v — thì dừng _và xóa sạch_ dữ liệu, cả Postgres lẫn Redis."

【MÀN HÌNH: cảnh báo đỏ trên cờ `-v`】

〔Đọc〕
"Mình nhấn mạnh: cái `-v` đó xóa luôn _toàn bộ bộ nhớ đã học_. Chỉ dùng nó khi bạn thật sự muốn làm
lại từ con số không. Gõ nhầm cái này là mất hết những gì agent đã học về bạn. Nên mỗi lần gõ, dừng
một giây tự hỏi: mình có chắc muốn xóa không?"

---

## [14:00] KHI GẶP TRỤC TRẶC — bảng lỗi thường gặp

【MÀN HÌNH: bảng "Triệu chứng — Nguyên nhân — Cách sửa"】

〔Đọc〕
"Giờ mình gói vài trục trặc hay gặp, để nếu bạn kẹt thì có đường ra ngay.

`hermes` mãi không lên healthy? Gần như luôn là do OpenAI key sai hoặc thiếu, hoặc nó chưa nối được
Honcho. Xem `docker compose logs hermes` và kiểm tra lại `OPENAI_API_KEY`.

Dashboard mở ra nhưng không đăng nhập được? Sai user hoặc mật khẩu — hoặc lỡ có dư khoảng trắng, dư
dấu nháy trong biến. Mẹo hay: entrypoint in ra một 'fingerprint' — độ dài cộng tám ký tự sha — của
mật khẩu trong log, để bạn so khớp mà không lộ mật khẩu.

Chat báo lỗi hoặc không trả lời? Thường là `OPENAI_API_KEY` vẫn còn là placeholder. Đặt key thật
trong `.env` hoặc trang Config, rồi chạy lại `docker compose up -d`.

`deriver` cứ restart liên tục? Nó chưa kết nối được Postgres hoặc Redis. Đảm bảo hai cái đó healthy
trước đã, rồi xem log deriver.

Báo `port is already allocated`, cổng ba nghìn hay tám nghìn? Có tiến trình khác đang chiếm cổng —
tắt nó đi, hoặc đổi cổng map trong compose."

〔Đọc〕
"Và một câu để bạn ghim: _chat thật thì cần key thật._ Với một key placeholder, mọi service vẫn
boot, dashboard vẫn mở ra — nhưng phần chat và trích xuất bộ nhớ chỉ chạy khi có một key hợp lệ."

---

## [16:30] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 06 tick xanh + hai nút "Bài 07 Railway" / "Bài 08 Dashboard"】

〔Đọc〕
"Điểm lại. Chỉ một lệnh `docker compose up -d --build` là dựng xong cả năm service. Deriver không
'healthy' là chuyện bình thường vì nó là worker nền. Bạn kiểm tra qua `docker compose ps`, qua
`curl` đường /health, và qua dòng log 'provider set to honcho'. Đây là môi trường lý tưởng để học
và thử trước khi lên cloud.

Từ đây bạn có hai lựa chọn. Muốn hệ thống chạy hai tư trên bảy kể cả khi tắt máy, thì xem Bài 07 —
đưa nó lên Railway. Còn nếu hệ thống chạy rồi và bạn muốn dùng ngay, nhảy sang Bài 08 — ta vào tham
quan dashboard. Hẹn gặp ở bài kế."

【[18:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- Quay lệnh dài (`docker compose up -d --build`, các lệnh logs) cận cảnh terminal, gõ chậm.
- Đoạn build lần đầu [03:15] có thể tua nhanh (time-lapse) kèm chú thích "quá trình này mất vài phút".
- Dòng log "✅ Memory provider set to honcho" [07:00] nên zoom + khoanh — đây là 'proof' trực quan.
- Cảnh báo `docker compose down -v` [12:45]: dùng hiệu ứng đỏ/âm thanh nhấn để khán giả không gõ nhầm.
- "200" đọc "hai trăm"; cổng "3000/8000/5432/6379" đọc theo cách đã ghi trong lời để nhất quán.
