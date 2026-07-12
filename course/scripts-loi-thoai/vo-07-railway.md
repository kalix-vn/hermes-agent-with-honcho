# 🎙️ VO — Bài 07: Deploy lên Railway (1-click + tự dựng template)

> **Thời lượng mục tiêu:** ~20 phút · **Tông giọng:** dẫn tay bình tĩnh, giải thích "vì sao" ở mỗi biến — bài dài, giữ nhịp chắc.
> **Kịch bản dạy học tương ứng:** [`../07-trien-khai-railway.md`](../07-trien-khai-railway.md)
> ⚠️ **Điều kiện:** có tài khoản Railway và OpenAI key (Bài 05).

---

## [00:00] MỞ MÀN — cả stack từ một repo

【MÀN HÌNH: Title card — "Bài 07 — Cách B: Deploy lên Railway"】

〔Đọc〕
"Đây là con đường để trợ lý của bạn chạy hai tư trên bảy — kể cả lúc bạn ngủ, kể cả khi tắt máy.

Railway cho phép chạy nhiều service từ _một_ repo — người ta gọi là monorepo. Ta sẽ có đủ:
PostgreSQL, Redis, Honcho API, Honcho Deriver, và Hermes — tất cả tự nối mạng nội bộ với nhau.

Có hai cách làm. Cách nhanh: bấm một nút, deploy trong vài phút. Cách tự dựng: chín bước, để bạn
hiểu sâu từng service. Mình sẽ làm _cả hai_, để bạn chọn theo nhu cầu."

---

## [01:15] PHẦN 1 — Cách nhanh: Deploy 1-click

【MÀN HÌNH: mở `../README.md`, bấm nút "Deploy on Railway"】

〔Đọc〕
"Bắt đầu bằng cách nhanh nhất. Mình mở file `README.md` của repo, và bấm cái nút 'Deploy on
Railway'. Hoặc bạn mở thẳng đường link railway.com/deploy, tên template
`hermes-agent-honcho-memory`."

【MÀN HÌNH: form deploy Railway hỏi API key + dashboard login】

〔Đọc〕
"Railway sẽ hỏi bạn vài thông tin. Một là `LLM_OPENAI_API_KEY` — OpenAI key của bạn, cái này bắt
buộc. Điểm hay: nó được dùng lại cho mọi service, nên bạn chỉ nhập _một lần_. Hai là username và
password cho dashboard.

Và đây là chỗ mình phải cảnh báo _rất_ rõ. Từ đợt siết bảo mật tháng Sáu năm hai không hai sáu, một
lần bind công khai _bắt buộc_ phải có xác thực. Nếu bạn không đặt
`HERMES_DASHBOARD_BASIC_AUTH_USERNAME` và `HERMES_DASHBOARD_BASIC_AUTH_PASSWORD`, thì bạn sẽ _không
mở được dashboard_. Đây không phải tùy chọn — nó là bắt buộc."

〔Đọc〕
"Nhập xong, Railway tự dựng đủ năm service cho bạn. Chờ nó provision xong, rồi mình nhảy tới Phần 3
để expose và đăng nhập. Nếu bạn chỉ cần nhanh gọn, cách này là đủ. Nhưng mình khuyên xem tiếp Phần
2 — vì hiểu từng service sẽ giúp bạn xử lý sự cố sau này dễ hơn nhiều."

---

## [03:30] PHẦN 2 — Tự dựng template (9 bước để hiểu sâu)

【MÀN HÌNH: mở phần "Railway template setup" trong `../README.md`】

〔Đọc〕
"Phần này dành cho ai muốn kiểm soát từng service, hoặc muốn thật sự hiểu kiến trúc. Mình bám sát
phần 'Railway template setup' trong README. Đi lần lượt chín bước.

Bước một: tạo template. Vào Railway, mục Account Settings, Templates, Create Template. Đặt tên, ví
dụ 'Hermes Agent + Honcho Memory'.

Bước hai: thêm PostgreSQL. Bấm Add Service, Database, PostgreSQL. Yên tâm — Postgres của Railway đã
hỗ trợ sẵn pgvector, đúng cái Honcho cần để tìm kiếm ngữ nghĩa.

Bước ba: thêm Redis. Add Service, Database, Redis. Xong hai viên gạch nền: database và cache."

---

## [05:30] BƯỚC 4 — Thêm Honcho API

【MÀN HÌNH: Add Service → GitHub Repo → Root Directory = honcho; panel biến môi trường】

〔Đọc〕
"Bước bốn: thêm Honcho API. Add Service, chọn GitHub Repo, trỏ vào repo này. Quan trọng: đặt
_Root Directory_ bằng `honcho`.

Rồi ta điền các biến môi trường. `HONCHO_MODE` bằng `api` — cùng một codebase, nhưng biến này bảo
nó chạy ở chế độ API. `DB_CONNECTION_URI` trỏ tới Postgres, bằng cú pháp tham chiếu của Railway —
hai ngoặc nhọn, `Postgres.DATABASE_URL`. `CACHE_URL` trỏ tới `Redis.REDIS_URL`. `CACHE_ENABLED`
bằng true. `AUTH_USE_AUTH` bằng false, vì ta gọi Honcho qua mạng nội bộ. Và `LLM_OPENAI_API_KEY` —
cái này bắt buộc, lát nữa lúc publish ta sẽ đánh dấu nó là Required."

【MÀN HÌNH: khung nhấn mạnh về DB URL scheme】

〔Đọc〕
"Nhớ cái mình gieo ở Bài 03 chứ? Honcho dùng SQLAlchemy nên cần prefix `postgresql+psycopg://`,
nhưng Railway lại trả `postgresql://` thuần. Bạn _không_ phải tự sửa — entrypoint tự ghi lại scheme
giúp bạn. Cứ dán `Postgres.DATABASE_URL` là chạy. Nó còn thông minh tới mức: nếu bạn để trống
`DB_CONNECTION_URI` hay `CACHE_URL`, nó tự fallback về `DATABASE_URL` và `REDIS_URL`.

Nếu muốn, bạn có thể đặt Healthcheck Path bằng /health cho _riêng_ service API này — vì API thì có
HTTP server."

---

## [08:00] BƯỚC 5 — Thêm Honcho Deriver

【MÀN HÌNH: Add Service → GitHub Repo → Root Directory = honcho; biến HONCHO_MODE=deriver】

〔Đọc〕
"Bước năm: thêm Honcho Deriver. Lại Add Service, GitHub Repo, cùng repo này, và Root Directory cũng
là `honcho`. Đúng vậy — cùng codebase với API, chỉ khác chế độ.

Các biến gần giống bước trước, nhưng `HONCHO_MODE` lần này bằng `deriver`. `DB_CONNECTION_URI` và
`CACHE_URL` trỏ tới cùng Postgres và Redis. Riêng `LLM_OPENAI_API_KEY` thì ta tham chiếu lại từ
service kia — hai ngoặc nhọn, `honcho-api.LLM_OPENAI_API_KEY` — để chỉ phải nhập key một lần."

【MÀN HÌNH: cảnh báo đỏ — "Deriver: ĐỂ TRỐNG Healthcheck Path"】

〔Đọc〕
"Và đây là lỗi phổ biến nhất khi tự dựng, nên mình nói thật to: Deriver _không_ có HTTP server. Vậy
nên bạn phải _để trống_ Healthcheck Path cho nó. Nếu bạn lỡ đặt một healthcheck HTTP, nó sẽ không
bao giờ pass, và deploy của bạn sẽ fail — dù thật ra deriver đang chạy hoàn toàn ổn. Nhớ Bài 03:
deriver là worker nền. Không HTTP, không healthcheck. Ghi lại điều này."

---

## [10:30] BƯỚC 6 — Thêm Hermes Agent

【MÀN HÌNH: Add Service → GitHub Repo → Root Directory = hermes; Settings → Networking → Generate Domain】

〔Đọc〕
"Bước sáu: thêm chính Hermes Agent. Add Service, GitHub Repo, repo này, nhưng lần này Root Directory
là `hermes`. Rồi vào Settings, Networking, và Generate Domain — vì đây là service _duy nhất_ ta cho
ra Internet.

Các biến môi trường cho Hermes. Đầu tiên, kết nối tới Honcho qua mạng nội bộ:
`HONCHO_BASE_URL` bằng `http://` rồi tham chiếu `honcho-api.RAILWAY_PRIVATE_DOMAIN` cổng tám nghìn.
Chú ý chữ _PRIVATE_ — đây là địa chỉ nội bộ, không lộ ra ngoài.

Tiếp theo, key LLM: `OPENAI_API_KEY` tham chiếu lại `honcho-api.LLM_OPENAI_API_KEY` — lại dùng lại,
nhập một lần."

【MÀN HÌNH: ba biến auth dashboard】

〔Đọc〕
"Và ba biến bảo mật _bắt buộc_ cho một domain công khai:
`HERMES_DASHBOARD_BASIC_AUTH_USERNAME`, ví dụ admin.
`HERMES_DASHBOARD_BASIC_AUTH_PASSWORD` — một mật khẩu mạnh.
Và `HERMES_DASHBOARD_BASIC_AUTH_SECRET` — một chuỗi bí mật ba mươi hai byte, để giữ phiên đăng nhập
qua các lần restart. Thiếu cái secret này thì cứ mỗi lần service restart là bạn bị đăng xuất."

---

## [13:00] BƯỚC 7 — (Tùy chọn) LLM base URL tùy chỉnh

【MÀN HÌNH: các biến OPENAI_BASE_URL và DERIVER/EMBEDDING config overrides】

〔Đọc〕
"Bước bảy là tùy chọn — bạn có thể bỏ qua nếu dùng OpenAI. Còn nếu bạn muốn dùng một provider tương
thích OpenAI, như OpenRouter, DeepSeek, Together AI, hay vLLM chạy local, thì:

Với Hermes, đặt `OPENAI_BASE_URL` trỏ tới endpoint đó, ví dụ openrouter.ai/api/v1.

Với Honcho — cả api lẫn deriver — thì đặt ba biến: `DERIVER_MODEL_CONFIG__OVERRIDES__BASE_URL`,
`EMBEDDING_MODEL_CONFIG__OVERRIDES__BASE_URL`, và `EMBEDDING_MODEL_CONFIG__MODEL` — ví dụ model
embedding là `text-embedding-3-small`. Nghe hơi dài, nhưng README có sẵn để bạn copy nguyên. Người
mới cứ bỏ qua bước này."

---

## [14:30] BƯỚC 8 & 9 — Publish và thêm nút deploy

【MÀN HÌNH: đánh dấu LLM_OPENAI_API_KEY là Required, bấm Publish Template】

〔Đọc〕
"Bước tám: publish. Bạn đánh dấu `LLM_OPENAI_API_KEY` — cái trên service `honcho-api` — là
_Required_. Vì tất cả các service khác đều tham chiếu ngược về nó, nên người deploy sau này chỉ phải
nhập key đúng _một lần_. Rồi bấm Publish Template.

Bước chín, cho ai muốn chia sẻ template của mình: thêm một nút Deploy on Railway vào README, bằng
đoạn markdown có sẵn trong tài liệu. Thế là người khác bấm một cái là dựng được y hệt bạn."

【MÀN HÌNH: sơ đồ 5 service trên canvas Railway đã nối với nhau】

〔Đọc〕
"Nhìn lại canvas Railway: năm service đã nối với nhau đẹp đẽ. Đây chính là sơ đồ Bài 03, giờ sống
trên cloud."

---

## [16:00] PHẦN 3 — Expose ra Internet & đăng nhập

【MÀN HÌNH: service hermes → Settings → Networking → Generate Domain, nhập cổng 3000】

〔Đọc〕
"Phần cuối: đưa nó ra Internet. Mở service `hermes`, vào Settings, Networking, Public Networking,
Generate Domain. Railway tạo cho bạn một địa chỉ dạng `https://<tên>.up.railway.app`, và tự lo luôn
HTTPS. Nếu nó hỏi cổng, bạn nhập ba nghìn.

Rồi mở cái URL đó ra, đăng nhập bằng username và password bạn đã đặt ở bước sáu. Nếu muốn dùng tên
miền riêng, cùng panel đó có mục Custom Domain: nhập tên miền của bạn, thêm một bản ghi CNAME mà
Railway hiển thị, và Railway tự cấp chứng chỉ TLS cho bạn."

【MÀN HÌNH: panel Networking — chỉ hermes có public domain, các service khác private】

〔Đọc〕
"Và mình nhắc lại nguyên tắc vàng từ Bài 04, vì nó cực kỳ quan trọng: _chỉ_ expose Hermes. _Đừng_
Generate Domain cho `honcho-api`, cho `honcho-deriver`, cho Postgres, hay Redis. Hermes đã gọi
Honcho qua mạng nội bộ rồi — qua `RAILWAY_PRIVATE_DOMAIN`. Nếu vì lý do nào đó bạn buộc phải public
Honcho API, thì phải bật `AUTH_USE_AUTH` bằng true và khóa JWT trước. Còn mặc định: mở đúng một cửa,
là Hermes."

---

## [18:00] KHI GẶP TRỤC TRẶC — bảng lỗi thường gặp

【MÀN HÌNH: bảng "Triệu chứng — Cách sửa"】

〔Đọc〕
"Vài trục trặc hay gặp trên Railway, để bạn không kẹt.

Deploy `honcho-deriver` bị fail? Chín mươi phần trăm là bạn lỡ đặt Healthcheck Path cho deriver.
Xóa trống nó đi.

Mở dashboard bị từ chối, không login được? Bạn thiếu mấy biến `HERMES_DASHBOARD_BASIC_AUTH`. Đặt
username với password rồi _redeploy_.

Honcho API lỗi kết nối database? Sai hoặc thiếu `DB_CONNECTION_URI` — dùng tham chiếu
`Postgres.DATABASE_URL`, entrypoint tự sửa scheme.

Đổi biến rồi mà vẫn login sai? Rất có thể bạn sửa env nhưng _chưa redeploy_ service. Trên Railway,
đổi env là phải redeploy mới ăn. Log Hermes có in fingerprint để bạn so khớp.

Và session cứ rớt sau mỗi lần restart? Bạn thiếu `..._BASIC_AUTH_SECRET`. Đặt một secret cố định từ
ba mươi hai byte trở lên."

---

## [19:00] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 07 tick xanh + nút "Bài tiếp: Chạy lần đầu & Dashboard"】

〔Đọc〕
"Tóm lại, Railway dựng cả stack từ một monorepo. Và nếu chỉ nhớ ba điều, hãy nhớ ba điều này: một,
deriver _không_ có healthcheck HTTP. Hai, _chỉ_ expose Hermes. Ba, dashboard public thì _bắt buộc_
basic-auth. Làm đúng ba cái đó là bạn có một trợ lý chạy hai tư trên bảy, không bao giờ ngủ.

Dù bạn đến đây bằng Docker hay bằng Railway, điểm hẹn tiếp theo là chung: Bài 08 — ta chạy lần đầu
và đi tham quan dashboard, làm quen buồng lái. Hẹn gặp ở Bài 08."

【[20:00] HẾT】

---

### 🎬 Ghi chú sản xuất
- Bài dài — cân nhắc chèn chapter markers theo từng "Bước" để khán giả nhảy tới đúng chỗ.
- Cú pháp tham chiếu Railway `${{...}}` khó đọc: luôn hiện _nguyên văn trên màn hình_ và nói "đúng như trên màn".
- Hai cảnh báo màu đỏ (deriver không healthcheck [08:00]; chỉ expose Hermes [16:00]) nên nhấn giọng + hiệu ứng.
- `postgresql+psycopg://` / `text-embedding-3-small` / tên biến dài: dựa vào cue màn hình, tránh đọc vấp.
- "3000/8000" và "32 byte" đọc theo cách đã ghi trong lời để nhất quán toàn khóa.
