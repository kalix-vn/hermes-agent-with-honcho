# 🎙️ VO — Bài 17: Use case thực tế & vòng lặp tự cải thiện

> **Thời lượng mục tiêu:** ~14 phút · **Tông giọng:** thực dụng, truyền cảm hứng, "đây mới là phần đáng giá".
> **Kịch bản dạy học tương ứng:** [`../17-use-cases-va-self-improvement.md`](../17-use-cases-va-self-improvement.md)
> ⚠️ **Điều kiện:** đã nối Composio (Bài 14) và biết tạo cron (Bài 15).

---

## [00:00] MỞ MÀN — nơi giá trị thật sự nằm

【B-ROLL: montage nhanh — hóa đơn tự lưu, brief buổi sáng, lịch được tối ưu】

〔Đọc〕
"Rất nhiều tutorial dừng lại ở chỗ 'dựng xong hệ thống, chúc mừng'. Nhưng thật ra, **dựng xong mới
là điểm bắt đầu**. Giá trị thật nằm ở chỗ: bạn **dùng nó vào việc thật**.

Bài này mình sẽ đi qua vài use case mà mình thấy **thật sự tiết kiệm thời gian**, và — quan trọng
không kém — cách để agent **càng dùng càng giỏi**, tự nó tiến hóa theo bạn. Bắt đầu."

【MÀN HÌNH: Title card — "Bài 17 · Use case thực tế & tự cải thiện"】

---

## [00:45] USE CASE A — Kế toán tự động

【THAO TÁC: gửi prompt tạo cron kế toán】

〔Đọc〕
"Use case đầu tiên, và cũng là cái nhiều người mê nhất: **kế toán tự động**. Ý tưởng: email nào là
hóa đơn thì tự lưu vào Google Drive, thư mục `receipts`. Không phải tải tay, không phải đặt tên tay.

Mình tạo cron bằng lời:

_'Mỗi khi mình nhận email mới, kiểm tra xem có phải hóa đơn hoặc biên nhận không. Nếu đúng, tải file
đính kèm và lưu vào Google Drive, thư mục receipts, đặt tên theo dạng năm-tháng-ngày gạch dưới tên
người bán. Cuối ngày gửi mình danh sách hóa đơn đã lưu.'_

Cái này cần Composio nối Gmail và Drive — đúng như Bài 14. Đặt xong một lần, từ đó tới cuối năm bạn
khỏi lo gom hóa đơn thủ công."

【MÀN HÌNH: thư mục Drive receipts được agent tự điền】

---

## [02:40] USE CASE B — Morning brief đa nguồn

【THAO TÁC: gửi prompt tạo cron morning brief】

〔Đọc〕
"Use case thứ hai: **bản tin buổi sáng** gom nhiều nguồn. Mình gõ:

_'Mỗi sáng bảy giờ: tổng hợp email quan trọng trong hai mươi tư giờ qua, cộng với các sự kiện lịch
hôm nay, và nếu có thể thì thêm tin ngành mình quan tâm. Trả về top action items dạng gạch đầu dòng,
tối đa mười dòng.'_

Nguyên tắc ở đây: **càng nhiều nguồn kết nối, bản tin càng giá trị**. Nhưng đừng ôm đồm ngay từ đầu
— **bắt đầu nhỏ, thêm dần**. Nối Gmail và Calendar trước, chạy vài ngày cho quen, rồi mới thêm
nguồn."

---

## [04:00] USE CASE C — Tối ưu lịch

【THAO TÁC: gửi prompt tối ưu lịch】

〔Đọc〕
"Use case thứ ba: **tối ưu lịch**. Mình nhờ agent nhìn vào lịch và giúp mình sắp xếp:

_'Xem lịch tuần này, chỉ ra các khoảng trống, và đề xuất chèn ba block: tập thể dục, deep work, và
học. Nếu mình đồng ý, tạo event tương ứng.'_

Để ý cái hay: nó **đề xuất trước, chờ mình đồng ý rồi mới tạo**. Đây là một thói quen tốt — với các
thao tác ghi, hãy để agent xin xác nhận, đừng để nó tự tung tự tác."

---

## [05:10] USE CASE D — Học ngoại ngữ / habit tracker

【THAO TÁC: gửi prompt học ngoại ngữ】

〔Đọc〕
"Use case thứ tư là cái mình rất thích, vì đây là chỗ **Honcho tỏa sáng**: học ngoại ngữ. Mình gõ:

_'Mỗi ngày chín giờ tối: dạy mình năm từ tiếng Nhật trình độ N4, kèm ví dụ câu. Sau đó quiz mình ba
từ đã học hôm trước. Ghi nhớ từ nào mình hay sai để lặp lại.'_

Nghe cái câu cuối chứ? 'Ghi nhớ từ nào mình hay sai'. Đây chính là chỗ Honcho phát huy: nó nhớ **bạn
hay sai từ nào**, trình độ bạn tới đâu — nên bài học **cá nhân hóa dần theo bạn**. Một cái app học từ
vựng thường không làm được điều đó."

---

## [06:30] USE CASE E — Daily wrap-up

〔Đọc〕
"Use case thứ năm, nhẹ nhàng mà hữu ích: **tổng kết cuối ngày**. Mình gõ:

_'Cuối mỗi ngày mười giờ tối: hỏi mình đã làm gì, tổng hợp những gì đã hoàn thành từ email và lịch,
và gợi ý một điều cải thiện cho ngày mai.'_

Một kiểu 'nhật ký có trợ lý' — vừa nhìn lại, vừa chuẩn bị cho hôm sau."

---

## [07:40] VÒNG LẶP TỰ CẢI THIỆN — cách khai thác

【MÀN HÌNH: sơ đồ — Bạn phản hồi → Hermes sửa skill + Honcho ghi sở thích → lần sau tốt hơn】

〔Đọc〕
"Giờ tới phần mà mình cho là **giá trị cốt lõi** của cả khóa: vòng lặp tự cải thiện. Nguyên tắc rất
đơn giản — **phản hồi ngắn, cụ thể, lặp lại, thì agent tự sửa skill và Honcho tự ghi sở thích**.

Để mình lấy ví dụ với morning brief.

Ngày một: bản tin hơi dài. Bạn nói: _'Ngắn hơn nhé, tối đa năm dòng, và bỏ mục thời tiết đi.'_

Đằng sau, agent cập nhật cái skill tên `morning-brief`, còn Honcho ghi nhận 'người dùng thích brief
ngắn'.

Ngày hai: bản tin đã đúng ý hơn hẳn — và **bạn không phải nhắc lại**. Nó nhớ."

〔Đọc〕
"Đây chính là điểm khác biệt cốt lõi so với các framework khác. Bạn **không phải** ngồi tự viết
skill, cũng **không phải** nhắc lại yêu cầu mỗi ngày. Bạn chỉ cần **dùng và phản hồi** — nó **tự
tiến hóa**. Đơn giản vậy thôi, nhưng đó là cả sức mạnh."

【MÀN HÌNH: agent cập nhật skill sau phản hồi của bạn】

---

## [10:00] CHỌN USE CASE ĐÁNG LÀM — tư duy ROI

【MÀN HÌNH: bảng 4 câu hỏi tự vấn về ROI】

〔Đọc〕
"Nhưng khoan — đừng lao vào tự động hóa mọi thứ. Có một tư duy chọn lọc, mình gọi là tư duy **ROI**
— lợi ích trên công sức. Bốn câu hỏi tự vấn trước khi làm một use case.

Một: việc này mình có làm **lặp lại** hằng ngày, hằng tuần không? Lặp lại thì mới đáng tự động.

Hai: nó có tốn **thời gian thủ công** đáng kể không? Tốn nhiều thì ROI mới cao.

Ba: mình có **dữ liệu hoặc tài khoản** để agent chạm vào không? Không có kết nối thì cron vô dụng.

Bốn: nếu agent làm sai, rủi ro có **chấp nhận được** không? Hãy bắt đầu từ việc **ít rủi ro**."

〔Đọc〕
"Lời khuyên thẳng thắn: **đừng cố tự động hóa mọi thứ**. Chọn hai, ba việc lặp lại tốn thời gian
nhất của bạn. **Làm tốt vài cái còn hơn làm dở cả chục cái.** Chất lượng hơn số lượng."

---

## [12:00] LỖI HAY GẶP — điểm nhanh

【MÀN HÌNH: bảng lỗi thường gặp】

〔Đọc〕
"Vài lỗi hay gặp trong khâu use case.

Agent làm nhưng **kết quả nhạt** — thường vì prompt use case còn mơ hồ; nêu rõ input, output, và
định dạng.

'Cải thiện' mãi **không thấy** — vì phản hồi của bạn chung chung quá, kiểu 'tốt hơn đi'; hãy phản
hồi **cụ thể, đo được**.

**Tự động hóa nhầm việc ít giá trị** — áp lại bảng ROI ở trên.

Và **lo agent hành động sai** — thì trao quyền write từ từ; đọc trước, và bắt agent xác nhận trước
khi gửi hay xóa gì."

---

## [12:50] CHỐT & CHUYỂN CẢNH

【MÀN HÌNH: checklist Bài 17 tick xanh + nút "Bài tiếp: Vận hành, chi phí & troubleshooting"】

〔Đọc〕
"Tóm lại: giá trị thật nằm ở use case thật — kế toán, brief, lịch, học tập, wrap-up. Khai thác vòng
tự cải thiện bằng **phản hồi cụ thể**: Hermes sửa skill, Honcho ghi sở thích. Và chọn việc **lặp
lại, tốn thời gian, ít rủi ro** để bắt đầu.

Giờ hệ thống của bạn đã thật sự hữu ích. Nhưng để nó chạy **ổn định lâu dài**, bạn cần biết một
chuyện nữa: cách nhìn log, kiểm soát chi phí, và sửa nhanh khi có sự cố. Bài tiếp theo là bài **vận
hành** — cẩm nang giữ cho hệ thống khỏe mạnh. Hẹn gặp ở bài mười tám."

【[13:45] HẾT】

---

### 🎬 Ghi chú sản xuất
- Dùng use case D (học ngoại ngữ) làm điểm nhấn cảm xúc — nối lại với "wow moment" Honcho ở Bài 09.
- Đoạn [07:40] vòng lặp tự cải thiện: nếu quay được brief "ngày 1 dài" và "ngày 2 gọn" cạnh nhau thì cực thuyết phục.
- Bảng ROI ([10:00]) đọc chậm, đây là khung tư duy khán giả sẽ ghi lại.
- Che dữ liệu email/hóa đơn thật trên mọi cảnh màn hình.
