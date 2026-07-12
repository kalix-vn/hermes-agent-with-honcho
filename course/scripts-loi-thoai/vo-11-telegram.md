# 🎙️ VO — Bài 11: Kết nối Telegram

> **Thời lượng mục tiêu:** ~12 phút · **Tông giọng:** thực chiến, thân thiện, nhấn mạnh bảo mật mà không hù dọa.
> **Kịch bản dạy học tương ứng:** [`../11-ket-noi-telegram.md`](../11-ket-noi-telegram.md)
> ⚠️ **Điều kiện:** đã cấu hình lần đầu và đăng nhập được dashboard (Bài 08); có tài khoản Telegram (Bài 05).

---

## [00:00] MỞ MÀN — vì sao Telegram

【B-ROLL: cảnh cầm điện thoại, nhắn tin cho bot ngay trên đường đi】

〔Đọc〕
"Thú thật đi: bạn sẽ không muốn lúc nào cũng phải mở trình duyệt, đăng nhập dashboard chỉ để hỏi
agent một câu. Bất tiện lắm.

Cách dễ nhất để nhắn agent từ điện thoại — mọi lúc mọi nơi — là **Telegram**. Nhắn như nhắn cho
một người bạn. Trong bài này mình sẽ tạo bot, nối vào Hermes, và cực kỳ quan trọng: **giới hạn chỉ
mình bạn được nhắn**. Bắt đầu thôi."

【MÀN HÌNH: Title card — "Bài 11 · Kết nối Telegram"】

---

## [00:40] MỘT LƯU Ý BẢO MẬT — trước khi làm

〔Đọc〕
"Trước khi đụng vào, mình nói thẳng một điều. Cái bot bạn sắp tạo sẽ có một chuỗi ký tự gọi là
**token**. Ai cầm token đó cũng nhắn được bot của bạn.

Và nếu bạn không giới hạn ai được nhắn, thì **người lạ** có thể trò chuyện với agent — tức là điều
khiển được nó. Nên có hai việc bắt buộc: giữ kín token, và chỉ cho **đúng user ID của bạn** được
nhắn. Mình sẽ làm cả hai ngay trong bài."

---

## [01:20] BƯỚC 1 — Tạo bot với BotFather

【THAO TÁC: mở Telegram, tìm @BotFather】
【MÀN HÌNH: khoanh dấu tích xanh cạnh tên BotFather】

〔Đọc〕
"Mở Telegram lên. Tìm kiếm chữ **BotFather** — viết liền, B hoa, F hoa. Chú ý: chọn đúng cái có
**dấu tích xanh**, vì có nhiều tài khoản nhái.

Vào chat với BotFather, gõ lệnh: gạch chéo `newbot`. Nó sẽ hỏi bạn hai thứ.

Thứ nhất là **display name** — tên hiển thị, đặt gì cũng được, ví dụ `Hermes Agent`.

Thứ hai là **username**. Cái này khó tính hơn: nó phải **duy nhất** trên toàn Telegram, và **bắt
buộc kết thúc bằng gạch dưới b-o-t** — `_bot`. Ví dụ mình đặt `minh_hermes_92413_bot`. Nếu bị từ
chối, nghĩa là tên trùng hoặc chưa có đuôi `_bot` — cứ đổi cho tới khi nó nhận."

【MÀN HÌNH: BotFather trả về token, che một phần】

〔Đọc〕
"Xong xuôi, BotFather trả về một chuỗi trông như thế này — số, dấu hai chấm, rồi một mớ chữ và số:
`123456:ABC-DEF...`. **Đó là token.** Đây chính là chìa khóa bot. Copy lại, và tuyệt đối không để
lộ, không đăng lên đâu cả."

---

## [03:10] BƯỚC 2 — Lấy Telegram user ID của bạn

【THAO TÁC: tìm @userinfobot trên Telegram】

〔Đọc〕
"Giờ ta cần biết **ID số của chính bạn** trên Telegram — để lát nữa nói với Hermes rằng 'chỉ người
này được nhắn thôi'.

Vẫn trong Telegram, tìm bot tên **userinfobot** — viết liền. Bấm vào, gõ gạch chéo `start`. Nó sẽ
hiện ra một dãy số, đó là **ID Telegram** của bạn. Copy dãy số đó lại."

【MÀN HÌNH: userinfobot hiển thị ID, khoanh vùng dãy số】

〔Đọc〕
"Giữ hai thứ trong tay: token của bot, và ID của bạn. Sẵn sàng nối vào Hermes."

---

## [04:20] BƯỚC 3 — Cấu hình Telegram cho Hermes

【THAO TÁC: mở shell vào Hermes】
【MÀN HÌNH: gõ `docker compose exec hermes sh` rồi `hermes setup`】

〔Đọc〕
"Có vài cách cấu hình, nhưng cách chắc chắn hoạt động là qua dòng lệnh. Mình mở shell vào Hermes:
`docker compose exec hermes sh`. Nếu bạn chạy trên Railway thì dùng **nút Shell** của service
`hermes` thay cho lệnh này.

Vào rồi, gõ `hermes setup`, và đi tới bước có tên **messaging platform** — nền tảng nhắn tin — rồi
chọn **Telegram**."

〔Đọc〕
"Nó sẽ hỏi hai thứ, đúng hai thứ bạn đã chuẩn bị. Một: **bot token** — dán token từ BotFather vào.
Hai: **allowed user IDs** — danh sách ID được phép nhắn — dán ID của bạn vào. Nếu muốn cho nhiều
người, ngăn cách bằng **dấu phẩy**."

【MÀN HÌNH: chỉ vào ô Bot token và ô Allowed user IDs】

〔Đọc〕
"Một mẹo: token nên được coi như một **secret**. Nếu Hermes yêu cầu đặt qua biến môi trường, bạn
dùng lệnh: `hermes config set TELEGRAM_BOT_TOKEN` rồi tới token. Và nhắc lại nguyên tắc vàng từ Bài
04: **không bao giờ dán token vào ô chat** với agent."

---

## [06:20] BƯỚC 4 — Nhắn thử từ điện thoại

【THAO TÁC: mở link bot, bấm Start, gõ hello】

〔Đọc〕
"Giờ là lúc vui. BotFather có cho bạn một đường link tới bot theo username. Bấm vào đó để mở cuộc
chat, bấm nút **Start**, rồi gõ đơn giản: `hello`.

_(giữ nhịp, chờ)_

Bạn sẽ thấy dòng chữ 'typing…' hiện lên — bot đang gõ — rồi nó trả lời. Vậy là điện thoại của bạn
giờ nói chuyện được với agent. Và nhớ điều quan trọng nhất: **mọi tin nhắn qua đây đều đi vào
Honcho** — tức là bot vẫn nhớ bạn y như trên dashboard."

【MÀN HÌNH: cuộc chat Telegram, bot trả lời】

---

## [07:40] BƯỚC 5 — Nếu bot "im lặng": đừng hoảng

〔Đọc〕
"Nào, thực tế thì: lần đầu kết nối, rất hay gặp cảnh bot **nhận được tin** — có dấu tích — nhưng
**không trả lời**, không cả 'typing'. Bình tĩnh, đây là chuyện thường. Và 'siêu năng lực' của
Hermes chính là **tự sửa được lỗi của mình**."

【MÀN HÌNH: chuyển sang dashboard】

〔Đọc〕
"Cách một, và cũng là cách mình thích nhất: **nhờ chính agent**. Quay về dashboard, gõ cho nó:

_'Mình đã cấu hình Telegram nhưng khi nhắn từ Telegram, bot nhận được — có dấu tích — mà không trả
lời, không typing. Nguyên nhân có thể là gì? Giúp mình kiểm tra và sửa.'_

Rất thường xuyên, agent tự phát hiện ra là **cổng kết nối Telegram — gateway — bị dừng**, và nó
khởi động lại giúp bạn luôn."

【MÀN HÌNH: agent tự chẩn đoán và restart gateway Telegram】

【THAO TÁC: mở log để kiểm tra thủ công】

〔Đọc〕
"Cách hai, nếu bạn muốn tự nhìn: mở log ra. Gõ `docker compose logs -f hermes` rồi lọc bằng
`grep -i telegram`. Bạn xem gateway đã kết nối Telegram chưa, có lỗi token hay lỗi quyền không. Hai
cách này gần như phủ hết mọi trường hợp bot im lặng."

---

## [09:40] CÁC LỖI KHÁC HAY GẶP

【MÀN HÌNH: bảng lỗi thường gặp cuộn nhẹ】

〔Đọc〕
"Điểm nhanh vài lỗi nữa để bạn khỏi bối rối.

Nếu thấy chữ **Unauthorized** — token sai hoặc đã bị thu hồi. Lấy lại token mới từ BotFather rồi đặt
lại.

Nếu bạn nhắn mà **bot phớt lờ hoàn toàn** — khả năng cao ID của bạn chưa nằm trong allowlist. Kiểm
tra lại đúng cái ID ở Bước 2.

Nếu **người lạ nhắn được bot** — nghĩa là bạn chưa giới hạn user ID. Cái này **bắt buộc** phải cấu
hình, đừng bỏ qua.

Và username bị từ chối thì như đã nói: phải kết thúc bằng `_bot` và không trùng."

---

## [10:50] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 11 tick xanh + nút "Bài tiếp: Backup lên GitHub"】

〔Đọc〕
"Tóm gọn cả bài: **BotFather** cho bạn token, **userinfobot** cho bạn ID, rồi `hermes setup` để nối
vào và giới hạn allowlist. Nhắn thử, và nếu im lặng thì nhờ chính agent restart gateway.

Giờ bạn đã cầm agent trong túi quần — nhắn được từ bất cứ đâu. Nhưng agent càng dùng càng quý: nó
tích lũy trí nhớ, kỹ năng, cấu hình. Lỡ server hỏng thì sao? Bài tiếp theo, ta cho nó **tự động sao
lưu lên GitHub** để không bao giờ mất trắng. Hẹn gặp ở bài mười hai."

【[11:50] HẾT】

---

### 🎬 Ghi chú sản xuất
- Che một phần token và ID thật trên màn hình khi quay — đừng để lộ credential thật.
- Đoạn [07:40] "bot im lặng" nên quay **thật** một lần lỗi nếu bắt được — chân thật hơn dàn dựng.
- Nhấn giọng ở hai chữ "bắt buộc" khi nói về allowlist — đây là điểm bảo mật cốt lõi của bài.
- Cảnh nhắn từ điện thoại (B-roll mở màn) nên quay ngoài trời/di chuyển để thấy tính "mọi lúc mọi nơi".
