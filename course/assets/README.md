# Thư mục ảnh/media của khóa học

Đặt ảnh chụp màn hình, sơ đồ, GIF minh họa vào đây rồi nhúng vào các module.

## Quy ước đặt tên
`m<NN>-<mo-ta-ngan>.png` — ví dụ:
- `m06-docker-compose-ps.png`
- `m09-wow-moment-cross-session.png`
- `m11-telegram-botfather-token.png`

## Cách nhúng vào module
```markdown
![Mô tả ảnh](./assets/m06-docker-compose-ps.png)
```

## Danh sách ảnh cần chụp
Mỗi chỗ đánh dấu `【SCREENSHOT: ...】` trong các module là một ảnh nên chụp khi quay/biên soạn.
Tìm nhanh tất cả các điểm cần chụp:
```bash
grep -rn "【SCREENSHOT" ..
```
