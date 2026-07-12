# 🎙️ VO — Bài 18: Vận hành, chi phí & troubleshooting

> **Thời lượng mục tiêu:** ~14 phút · **Tông giọng:** bình tĩnh, tự tin, "cẩm nang gối đầu giường"; nhấn nút khẩn cấp.
> **Kịch bản dạy học tương ứng:** [`../18-van-hanh-chi-phi-troubleshooting.md`](../18-van-hanh-chi-phi-troubleshooting.md)
> ⚠️ **Điều kiện:** đã deploy — Docker (Bài 06) hoặc Railway (Bài 07).

---

## [00:00] MỞ MÀN — dựng xong không phải là hết

【MÀN HÌNH: 5 khối service — hermes, honcho-api, deriver, postgres, redis】

〔Đọc〕
"Dựng xong hệ thống không có nghĩa là xong việc. Để nó chạy **ổn định lâu dài**, bạn cần ba kỹ năng:
biết **nhìn log** để tìm lỗi, biết **cắt chi phí**, và biết **sửa nhanh** khi có trục trặc.

Tin vui là: chín mươi phần trăm sự cố nằm ở **vài chỗ quen thuộc**. Bài này mình gom hết vào một chỗ
— coi như cẩm nang gối đầu giường để bạn tự chủ hệ thống. Bắt đầu."

【MÀN HÌNH: Title card — "Bài 18 · Vận hành, chi phí & troubleshooting"】

---

## [00:50] PHẦN 1 — Bản đồ log: nhìn đúng chỗ

【THAO TÁC: gõ các lệnh docker compose logs】
【MÀN HÌNH: `docker compose ps` rồi lần lượt các service】

〔Đọc〕
"Đầu tiên và quan trọng nhất: **nhìn đúng log**. Với bản Docker, mở terminal ra.

`docker compose ps` cho bạn trạng thái tổng quan — service nào sống, service nào chết.

Rồi xem từng cái: `docker compose logs -f hermes` là UI, agent, và các gateway — Telegram, dashboard,
honcho client.

`docker compose logs -f honcho-api` là API bộ nhớ — nơi lưu message và kiểm tra health.

`docker compose logs -f deriver` là suy luận nền — và đây là chỗ **lỗi LLM key của Honcho lộ ra**,
nhớ kỹ chỗ này.

Còn `postgres` và `redis` là database và cache.

Với bản **Railway**, mỗi service có tab **Logs** và **Deployments** riêng — cứ mở đúng service bạn
đang nghi ngờ."

【MÀN HÌNH: bảng — triệu chứng thuộc về service nào】

〔Đọc〕
"Và đây là bảng 'đọc bệnh' nhanh. Không đăng nhập được, chat lỗi, hay Telegram im — nhìn log
**hermes**. Không nhớ, representation không cập nhật — nhìn **deriver**. API bộ nhớ lỗi, `/health`
fail — nhìn **honcho-api**. Còn deriver hay api crash ngay khi khởi động — thì soi **postgres** và
**redis**. Nhớ bảng này là bạn khoanh vùng được hầu hết mọi lỗi."

---

## [03:30] PHẦN 2 — Kiểm soát chi phí: token là tiền

【MÀN HÌNH: bảng các đòn bẩy giảm chi phí】

〔Đọc〕
"Phần hai: chi phí. Nhớ công thức đơn giản này — chi phí đến từ **số lần gọi LLM** nhân với **kích
thước context**. Muốn giảm tiền, bạn tác động vào hai yếu tố đó. Đây là các đòn bẩy.

Một: đặt **spend limit** ngay ở nhà cung cấp — ví dụ OpenAI có mục Usage limits. Cái này là 'phanh
tay' an toàn nhất.

Hai: hạ **max iterations** về mặc định trong Config.

Ba: bật **context compression** hợp lý, khoảng không phẩy tám.

Bốn: đặt **session reset** kiểu inactivity cộng daily — reset khi không hoạt động và reset hằng
ngày.

Năm: tăng `dialecticCadence` của Honcho, giữ depth bằng một.

Sáu: đổi `recallMode` sang `tools` — chỉ tra ký ức khi cần.

Bảy: dùng **model rẻ** cho task nhẹ.

Tám: dùng provider rẻ hơn qua `OPENAI_BASE_URL` — như OpenRouter hay DeepSeek."

〔Đọc〕
"Một điểm nhiều người quên: Honcho có **hai nguồn** tốn token, không phải một. Nguồn thứ nhất là
chat qua Hermes. Nguồn thứ hai là **deriver** — suy luận nền. Nên khi tối ưu chi phí, đừng quên các
núm cadence và depth của Honcho ở Bài 16."

---

## [06:20] PHẦN 3 — Bảo trì định kỳ

〔Đọc〕
"Phần ba: bảo trì. Có vài việc nên làm đều đặn để hệ thống không 'mục' dần.

**Rotate secret** — đổi mới định kỳ các khóa: OpenAI key, GitHub PAT, Telegram token. Nhắc lại từ
Bài 04 và Bài 12.

**Kiểm tra backup** thật sự đang chạy — mở tab Commits của repo backup mà xem, đừng chỉ tin nó chạy.

**Theo dõi dung lượng Postgres** — message và representation cứ tích lũy dần; dọn dữ liệu cũ khi cần.

Và **cập nhật image** khi Hermes hoặc Honcho ra bản vá bảo mật — rebuild hoặc redeploy để nhận bản
mới."

---

## [08:00] PHẦN 4 — Bảng tra sự cố toàn stack

【MÀN HÌNH: bảng tra sự cố lớn, cuộn chậm】

〔Đọc〕
"Phần bốn là 'bảo bối' của bài — bảng tra sự cố cho toàn hệ thống. Mình điểm những cái hay gặp
nhất.

**Dashboard không mở, login fail** — xem log hermes; đặt lại biến `HERMES_DASHBOARD_BASIC_AUTH`, so
'fingerprint' trong log, rồi redeploy sau khi sửa env.

**Chat không trả lời** — thường key OpenAI sai hoặc hết quota; đổi model hoặc nạp thêm.

**Nhớ không hoạt động** — xem deriver; có thể thiếu key LLM của Honcho, hoặc Postgres/Redis chết,
hoặc đơn giản là đợi deriver xử lý xong.

**honcho-api health fail** — DB URL sai; entrypoint tự sửa scheme, nên kiểm tra `DB_CONNECTION_URI`.

**Deriver deploy fail trên Railway** — nhớ bỏ Healthcheck Path, vì deriver là worker, **không có
HTTP**.

**Telegram im lặng** — gateway dừng; nhờ agent restart hoặc restart service.

**port already allocated** ở bản local — đổi cổng hoặc tắt tiến trình đang chiếm cổng.

**Agent chạy lâu, đốt token** — hạ iterations và ra lệnh rõ ràng hơn.

**Đổi env mà không ăn** — phải **redeploy**; Railway thì redeploy service, Docker thì `up -d` lại.

Và **Postgres đầy** — tăng dung lượng hoặc dọn dữ liệu cũ."

---

## [11:00] PHẦN 5 — Nút "khẩn cấp"

【MÀN HÌNH: khối đỏ "EMERGENCY" với 4 bước】

〔Đọc〕
"Phần cuối, và mong bạn **không bao giờ phải dùng** — nhưng phải biết. Nếu bạn nghi ngờ bị **xâm
nhập**, hoặc thấy agent **hành xử lạ**, đây là quy trình khẩn cấp.

Một — **dừng ngay**. Bản local: `docker compose down`. Bản Railway: tắt service `hermes`.

Hai — **revoke secret**. Xóa ngay OpenAI key, GitHub PAT, Telegram token đang dùng. Cắt hết chìa
khóa.

Ba — **kéo domain xuống**. Gỡ public domain của Hermes để cắt mọi truy cập từ bên ngoài.

Bốn — khi đã an toàn, **khôi phục từ backup GitHub**. Đây chính là lúc bạn cảm ơn Bài 12.

Nhớ thứ tự: dừng, revoke, gỡ domain, khôi phục. Bốn bước, bình tĩnh làm tuần tự."

---

## [12:30] NHẮC LẠI NGUYÊN TẮC VÀNG

【MÀN HÌNH: 4 nguyên tắc vàng】

〔Đọc〕
"Trước khi khép lại, nhắc bốn nguyên tắc vàng xuyên suốt khóa.

Secret sống trong **env**, không trong chat, không trong Git.

Chỉ expose **Hermes**; Honcho, database, Redis luôn để **private**.

Đổi env thì phải **redeploy** mới ăn.

Và deriver **không** healthcheck HTTP — nó là worker."

---

## [13:00] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 18 tick xanh + nút "Bài tiếp: Tổng kết & đồ án"】

〔Đọc〕
"Tóm lại: vận hành là **nhìn đúng log**, cộng **kiểm soát token**, cộng **bảo trì**, cộng **biết tra
sự cố**. Và luôn nhớ nút khẩn cấp: dừng, revoke, gỡ domain, khôi phục backup. Có bảng này trong tay,
bạn **tự chủ** được hệ thống — không còn phụ thuộc ai.

Vậy là ta đã đi qua gần hết hành trình. Bài cuối cùng, ta **nhìn lại toàn bộ** những gì đã dựng, mình
giao cho bạn một **đồ án tốt nghiệp**, và chỉ đường để bạn đi xa hơn. Hẹn gặp ở bài mười chín — bài
chốt khóa."

【[13:50] HẾT】

---

### 🎬 Ghi chú sản xuất
- Bài này là "tài liệu tra cứu" — nhấn mạnh khán giả nên **bookmark/lưu lại**; cân nhắc để bảng lên hình lâu.
- Khối "khẩn cấp" ([11:00]) dùng màu đỏ và nhịp dứt khoát để tạo trọng lượng — đây là phần an toàn.
- Khi quay lệnh log, che nội dung nhạy cảm (key, token) nếu chúng vô tình xuất hiện trong output.
- Đọc "honcho-api", "DB_CONNECTION_URI", "OPENAI_BASE_URL" rõ từng ký tự — đây là tên biến/service, không dịch.
