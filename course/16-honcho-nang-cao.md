# Module 16 — Honcho nâng cao: tinh chỉnh & multi-agent

> **Thời lượng:** ~16 phút · **Mức độ:** Nâng cao
> **Mục tiêu:** Làm chủ các "núm vặn" của Honcho để cân bằng **chi phí ↔ độ sâu suy luận**, chọn
> chiến lược session/recall, và cấu hình đa người dùng/đa agent (peers).
> **Yêu cầu trước:** [Module 09](./09-kiem-chung-bo-nho-honcho.md)

## 🎯 Kết quả sau bài học
- Hiểu 3 núm cốt lõi: **contextCadence · dialecticCadence · dialecticDepth**.
- Chọn được **recallMode**, **sessionStrategy**, **observationMode**, và ngân sách token.
- Cấu hình **peer mapping** cho gateway nhiều người dùng (Telegram/Slack).

---

## 🧭 Bối cảnh / dẫn dắt

〔Nói〕 "Honcho mặc định đã tốt. Nhưng khi dùng nhiều, bạn sẽ muốn cân đối: suy luận sâu hơn (thông
minh hơn, tốn hơn) hay tiết kiệm hơn. Và nếu nhiều người cùng nhắn agent, bạn cần tách hồ sơ họ ra.
Bài này cho bạn các núm để làm chủ."

> 📌 Xem đầy đủ trong [tài liệu Honcho của Hermes](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/honcho.md).
> Chỉnh qua `hermes honcho ...` (shell) hoặc mục cấu hình memory tương ứng.

---

## 🪜 Nội dung bài học

### 1. Ba núm cốt lõi: cadence & depth (chi phí ↔ độ sâu)

| Núm | Chức năng | Mặc định | Tăng lên nghĩa là |
|-----|-----------|:--------:|-------------------|
| `contextCadence` | Bao nhiêu lượt chat thì gọi API lấy context 1 lần | `1` | Ít gọi hơn → rẻ hơn, ngữ cảnh "cũ" hơn |
| `dialecticCadence` | Bao nhiêu lượt thì chạy suy luận LLM 1 lần | `2` | Suy luận thưa hơn → rẻ hơn, cập nhật chậm hơn |
| `dialecticDepth` | Số vòng suy luận nhiều lượt (multi-pass) | `1` | Sâu hơn → thông minh hơn, tốn hơn |

〔Nói〕 "Muốn **tiết kiệm**: tăng `dialecticCadence`, giữ `dialecticDepth=1`. Muốn **thông minh
tối đa** cho use case quan trọng: tăng `dialecticDepth` và `dialecticReasoningLevel`."

### 2. Độ sâu lập luận & ngân sách token

| Núm | Mặc định | Ý nghĩa |
|-----|:--------:|---------|
| `dialecticReasoningLevel` | `low` | Mức lập luận nền: `minimal/low/medium/high/max` |
| `contextTokens` | `null` (không giới hạn) | Ngân sách token cho context bơm vào |
| `dialecticMaxChars` | `600` | Tối đa ký tự insight chèn vào system prompt |
| `messageMaxChars` | `25000` | Tối đa ký tự mỗi message gửi tới API |

〔Nói〕 "`dialecticMaxChars` nhỏ (600) giữ system prompt gọn — insight súc tích. Tăng nếu bạn muốn
agent 'ngấm' nhiều ngữ cảnh hơn, nhưng coi chừng phình prompt."

**Lệnh liên quan:**
```bash
hermes honcho tokens      # xem/đặt ngân sách token
hermes honcho mode        # xem/đặt recall mode
```

### 3. recallMode — cách bơm ký ức vào agent

| Giá trị | Nghĩa |
|---------|-------|
| `hybrid` (mặc định) | Vừa **bơm** context sẵn, vừa cho agent **gọi tool** khi cần |
| `context` (inject-only) | Chỉ bơm context, không dùng tool |
| `tools` (tools-only) | Không bơm sẵn; agent tự gọi tool khi cần |

〔Nói〕 "`hybrid` cân bằng nhất cho người mới. `tools-only` tiết kiệm token (chỉ tra khi cần) nhưng
agent phải chủ động hơn."

```bash
hermes honcho mode hybrid   # ví dụ đặt
```

### 4. sessionStrategy — session ánh xạ theo cái gì

| Giá trị | Ý nghĩa |
|---------|---------|
| `per-directory` (mặc định) | Mỗi thư mục làm việc = 1 session |
| `per-repo` | Mỗi repo = 1 session |
| `per-session` | Mỗi phiên tách riêng |
| `global` | Một session xuyên suốt |

```bash
hermes honcho strategy       # xem/đặt
hermes honcho sessions       # liệt kê ánh xạ session hiện có
```
〔Nói〕 "Với trợ lý đời sống (chat qua Telegram), `global` hoặc `per-session` thường hợp hơn
`per-directory` (vốn hợp cho coding assistant)."

### 5. observationMode — quan sát peer

| Giá trị | Ý nghĩa |
|---------|---------|
| `directional` (mặc định) | Quan sát **có hướng**: A quan sát B tách biệt với B quan sát A |
| `unified` | Gộp quan sát |

〔Nói〕 "Directional giúp tách 'Honcho hiểu gì về bạn' và 'hiểu gì về agent' — quan trọng khi
multi-agent."

### 6. Multi-agent / nhiều người dùng: peer mapping

Khi triển khai gateway (Telegram/Slack) có **nhiều người** nhắn cùng một agent, cần ánh xạ danh tính:

| Cấu hình | Chức năng |
|----------|-----------|
| `pinUserPeer` | `true` → gộp mọi người dùng (không phải agent) về **một** peer |
| `userPeerAliases` | Ánh xạ runtime ID → tên peer, vd. `{"7654321": "alice"}` |
| `runtimePeerPrefix` | Đặt namespace cho ID lạ, vd. `telegram_7654321` |

〔Nói〕 "Ví dụ: cả gia đình dùng chung một bot. Bạn KHÔNG muốn Honcho trộn hồ sơ của bố và của em.
Dùng `userPeerAliases` để mỗi Telegram ID map thành một peer riêng → mỗi người có mô hình riêng,
không lẫn ngữ cảnh."

**Lệnh liên quan:**
```bash
hermes honcho peer           # xem/cập nhật tên peer
hermes honcho identity       # gieo danh tính cho AI peer
hermes honcho status         # kiểm tra toàn bộ cấu hình sau khi chỉnh
```

`【SCREENSHOT: 'hermes honcho status' hiển thị cadence/mode/strategy/peers sau khi tinh chỉnh】`

### 7. Self-hosted Honcho: base URL & JWT

Vì repo này **tự host** Honcho, khi setup wizard hỏi:
- **Base URL** → `HONCHO_BASE_URL` (nội bộ Docker/Railway).
- **JWT bearer token** (tùy chọn) → chỉ cần khi bật `AUTH_USE_AUTH=true` (ký bằng `AUTH_JWT_SECRET`
  của server). Token local lưu ở `hosts.<host>.apiKey` trong `honcho.json`, tách khỏi credential cloud.

> 💡 Học/local: để `AUTH_USE_AUTH=false` cho gọn. Production/expose: bật auth + JWT.

---

## ⚠️ Lỗi thường gặp
| Triệu chứng | Nguyên nhân | Cách sửa |
|-------------|-------------|----------|
| Chi phí LLM tăng vọt | `dialecticDepth`/`ReasoningLevel` quá cao | Hạ về `1`/`low`; tăng `dialecticCadence` |
| Hồ sơ nhiều người bị trộn | Chưa cấu hình peer mapping | Dùng `userPeerAliases`/`runtimePeerPrefix` |
| Insight bơm vào quá dài/tràn prompt | `dialecticMaxChars` lớn | Giảm về ~600 |
| Đổi cấu hình không ăn | Chưa reload/redeploy | Chạy lại `hermes honcho status`; redeploy nếu qua env |

## ✅ Checklist học viên
- [ ] Giải thích được cadence vs depth và ảnh hưởng chi phí.
- [ ] Chọn recallMode + sessionStrategy phù hợp use case của mình.
- [ ] (Nếu đa người dùng) cấu hình peer mapping tách hồ sơ.
- [ ] Xác minh bằng `hermes honcho status`.

## 🧠 Tổng kết
Cadence/Depth = cần gạt chi phí↔thông minh. recallMode/sessionStrategy/observationMode = cách nhớ
và ánh xạ. Peer mapping = tách hồ sơ đa người dùng/đa agent. Đây là lớp làm chủ Honcho thực thụ.

## ➡️ Tiếp theo
[Module 17 — Use case thực tế & vòng lặp tự cải thiện](./17-use-cases-va-self-improvement.md)
