# 🎙️ VO — Bài 12: Tự động backup lên GitHub

> **Thời lượng mục tiêu:** ~10 phút · **Tông giọng:** an tâm, cẩn trọng, nhấn least-privilege.
> **Kịch bản dạy học tương ứng:** [`../12-github-backup.md`](../12-github-backup.md)
> ⚠️ **Điều kiện:** đã cấu hình dashboard (Bài 08); có tài khoản GitHub.

---

## [00:00] MỞ MÀN — nỗi sợ mất trắng

【B-ROLL: cảnh một màn hình báo lỗi server chết / container biến mất】

〔Đọc〕
"Hãy tưởng tượng: bạn đã dùng agent cả tháng. Nó nhớ bạn, có kỹ năng riêng, cấu hình chỉnh vừa ý.
Rồi một ngày, VPS hỏng, hoặc container bị xóa nhầm. **Mất sạch.** Bao nhiêu công tan biến.

Bài này để chuyện đó **không bao giờ xảy ra**. Ta cho agent tự sao lưu lên một repo GitHub riêng
tư. Vừa là backup, vừa là **lịch sử phiên bản** — để lỡ agent 'xuống phong độ', bạn quay lui được.
Bắt đầu."

【MÀN HÌNH: Title card — "Bài 12 · Tự động backup lên GitHub"】

---

## [00:45] BƯỚC 1 — Tạo repo private

【THAO TÁC: mở GitHub, New repository】
【MÀN HÌNH: đặt tên repo, chọn Visibility: Private】

〔Đọc〕
"Mở GitHub, bấm **New repository**. Đặt tên gì đó dễ nhớ, ví dụ `hermes-agent-backup`.

Và đây là phần **quan trọng nhất** của bước này: ở phần Visibility, chọn **Private** — riêng tư.
Không phải Public. Vì backup có thể chứa thông tin nhạy cảm, ta tuyệt đối không để lộ ra ngoài.

Bấm **Create repository**. Để trống, cứ mở sẵn tab này, lát nữa dùng tới."

---

## [01:45] BƯỚC 2 — Tạo Fine-grained PAT (least-privilege)

〔Đọc〕
"Giờ ta cần một 'chìa khóa' để agent đẩy dữ liệu lên repo. Nhưng ta sẽ làm theo nguyên tắc đã học ở
Bài 04: **least-privilege** — cấp đúng quyền tối thiểu, không hơn."

【THAO TÁC: GitHub → Settings → Developer settings → Personal access tokens → Fine-grained tokens】

〔Đọc〕
"Vào ảnh đại diện, chọn **Settings**, rồi **Developer settings**, rồi **Personal access tokens**,
chọn **Fine-grained tokens**, và bấm **Generate new token**.

Đặt tên cho nó, ví dụ `hermes-backup-repo`. Ở phần **Expiration** — thời hạn — đặt một hạn cụ thể,
ví dụ 90 ngày. Đừng chọn 'no expiration'; có hạn thì an toàn hơn nhiều."

【MÀN HÌNH: chọn Only select repositories → chọn đúng repo backup】

〔Đọc〕
"Phần **Repository access**: chọn **Only select repositories** — chỉ những repo được chọn — rồi
chọn **đúng cái repo** `hermes-agent-backup` vừa tạo. Không phải tất cả repo. Chỉ một cái.

Xuống phần **Permissions**, mục **Repository permissions**, tìm **Contents**, đặt thành **Read and
write** — đọc và ghi. Chỉ đúng một quyền này thôi.

Bấm **Generate token**, và copy ngay — vì nó **chỉ hiện đúng một lần**."

〔Đọc〕
"Để ý cái ta vừa làm: **đúng một quyền, trên đúng một repo**. Lỡ token này lộ ra, thiệt hại tối
thiểu — kẻ xấu không đụng được gì ngoài cái repo backup, và bạn revoke được ngay. Đó là
least-privilege trong thực tế."

【MÀN HÌNH: PAT với Contents read/write trên 1 repo】

---

## [04:00] BƯỚC 3 — Đặt token vào Hermes ĐÚNG CÁCH

【THAO TÁC: mở shell Hermes】
【MÀN HÌNH: gõ `hermes config set GITHUB_TOKEN <PAT>`】

〔Đọc〕
"Mở shell vào Hermes, rồi gõ: `hermes config set GITHUB_TOKEN` và dán cái PAT vào sau.

Nhắc lại lần nữa vì nó quá quan trọng: **không dán PAT vào ô chat** với agent. Lệnh
`hermes config set` này lưu token vào phần env bí mật của Hermes — nó không lọt vào log, không lọt
vào mô hình AI. Đó là cách đúng để giao chìa khóa cho agent."

【MÀN HÌNH: 'hermes config set GITHUB_TOKEN' báo đã lưu】

---

## [05:10] BƯỚC 4 — Ra lệnh backup lần đầu

【THAO TÁC: từ dashboard hoặc Telegram, gửi prompt kèm URL repo】

〔Đọc〕
"Giờ ta ra lệnh cho agent, từ dashboard hoặc ngay trên Telegram. Gửi cho nó — nhớ kèm **URL của
repo**:

_'Mình đã cấp cho bạn một GitHub fine-grained PAT có quyền trên một repo. Đây là URL:
https://github.com/tên-bạn/hermes-agent-backup. Hãy backup cấu hình và trạng thái Hermes hiện tại
lên repo này. KHÔNG đưa lên bất kỳ secret, API key, hay thông tin nhạy cảm nào.'_

Agent sẽ clone repo, chọn lọc các file cần thiết, rồi push lên. Nó có thể hỏi bạn **phê duyệt**
lệnh — với thao tác clone và push lên đúng cái repo backup này, bạn cứ chọn **Always** cho gọn."

【MÀN HÌNH: repo GitHub sau backup — có skills, state, memory, cron, config】

---

## [06:40] BƯỚC 5 — Rà soát repo cho an toàn

【THAO TÁC: mở repo, kiểm tra từng thư mục】

〔Đọc〕
"Đừng tin tuyệt đối — hãy **kiểm tra**. Mở repo lên, dò xem có **secret** nào lọt vào không: file
env, token, key. Nếu thấy bất cứ cái nào, quay lại yêu cầu agent xóa file đó và commit lại ngay.

Một lưu ý: với bản Docker hoặc Railway, phần lớn secret nằm ở env của service — **không** nằm trong
thư mục dữ liệu của agent — nên rủi ro lộ thấp hơn so với chạy trên VPS trần. Nhưng dù vậy, **vẫn
phải rà**. Cẩn thận không bao giờ thừa với backup."

---

## [07:40] BƯỚC 6 — Bật auto-commit

【THAO TÁC: gửi lệnh bật auto-commit】

〔Đọc〕
"Backup một lần thì tốt, nhưng ta muốn nó **tự động mãi mãi**. Gửi cho agent:

_'Từ giờ, mỗi khi có thay đổi quan trọng — memory, skills, cấu hình — hãy tự tạo commit mới lên repo
backup này. Vẫn tuyệt đối không đưa secret lên.'_

Từ đây, agent tự **checkpoint** trong nền, không cần bạn nhắc. Muốn xem lịch sử, mở tab **Commits**
của repo — mỗi lần agent tiến hóa là một commit. Và vì có lịch sử, bạn **quay lui** được về bất kỳ
phiên bản nào."

【MÀN HÌNH: tab Commits của repo với nhiều mốc auto-commit】

---

## [08:40] LỖI HAY GẶP — điểm nhanh

【MÀN HÌNH: bảng lỗi thường gặp】

〔Đọc〕
"Vài lỗi để bạn không bối rối.

Nếu push báo **403** hoặc **permission denied** — PAT thiếu quyền `contents: write`, hoặc bạn chọn
sai repo. Tạo lại PAT cho đúng.

Nếu backup **trống hoặc thiếu** — có thể agent chưa hiểu cần backup gì. Nói rõ ra: skills, memory,
config, cron.

Nếu lỡ có **secret trong repo** — xóa file đó, và quan trọng: **rotate** — đổi mới ngay cái secret
đã bị lộ.

Và nhớ: PAT có hạn, vài tháng sau sẽ hết. Lúc đó tạo PAT mới rồi `hermes config set` lại là xong."

---

## [09:20] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 12 tick xanh + nút "Bài tiếp: Voice, ảnh & browser"】

〔Đọc〕
"Vậy là: repo **private**, cộng PAT **least-privilege**, cộng `hermes config set` — bằng một backup
an toàn. Ra lệnh backup, rà soát kỹ, rồi bật auto-commit. Từ giờ mọi tiến hóa của agent đều có lịch
sử và quay lui được. Bạn ngủ ngon.

Bài tiếp theo, ta mở rộng giác quan cho agent: nó sẽ **nghe được, nói được, nhìn được ảnh, và duyệt
web**. Ba khả năng đa phương thức mở ra hàng loạt use case thật. Hẹn gặp ở bài mười ba."

【[10:10] HẾT】

---

### 🎬 Ghi chú sản xuất
- Che token GitHub và tên user thật trên màn hình khi quay.
- Nhấn mạnh hai lần chữ "Private" và "least-privilege" — đây là hai điểm bảo mật cốt lõi của bài.
- Đoạn [06:40] rà soát repo nên quay chậm, cho khán giả thấy rõ việc kiểm tra thật sự.
- Nếu quay được cảnh agent tự tạo commit trong nền (tab Commits cập nhật), chèn vào [07:40] rất thuyết phục.
