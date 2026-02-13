# Đề xuất cải tiến Lilinet (Performance + UI/UX + Maintainability)

Tài liệu này tổng hợp các gợi ý cải tiến thực tế cho dự án Lilinet,
ưu tiên theo tác động và công sức triển khai.

## 1) Đánh giá nhanh các đề xuất hiện tại

Nhìn chung, bộ đề xuất trước đó **đúng hướng**. Tuy nhiên nên tinh chỉnh:

- Giữ kiến trúc Clean Architecture hiện tại, tránh refactor state management toàn cục ngay.
- Ưu tiên các thay đổi có ROI cao: image caching, skeleton loading, pagination,
  giảm rebuild UI, đo hiệu năng bằng profile.
- Với mục tiêu “native state management”, nên áp dụng dần cho màn hình đơn giản
  (UI state cục bộ) trước khi đụng vào app state lớn.

## 2) Lộ trình ưu tiên (theo mức tác động)

### P0 – Triển khai ngay (1–3 ngày)

1. **Chuẩn hóa loading/error/empty state**
   - Tạo bộ widget dùng chung cho toàn app.
   - Tránh mỗi màn hình tự định nghĩa khác nhau.

2. **Image caching có cấu hình rõ ràng**
   - Áp dụng `cached_network_image` + `flutter_cache_manager`.
   - Cấu hình TTL và giới hạn object cache để tránh phình bộ nhớ.

3. **Danh sách dài chỉ dùng lazy builder**
   - Bắt buộc `ListView.builder` / `GridView.builder`.
   - Thiết lập `cacheExtent`, dùng `itemExtent/prototypeItem` nếu chiều cao ổn định.

4. **Giảm rebuild không cần thiết**
   - Tách widget nhỏ + `const` constructor tối đa.
   - Chỉ lắng nghe state tối thiểu (selector) ở cây widget lớn.

### P1 – Nâng cấp trải nghiệm (3–7 ngày)

1. **Material 3 premium hoá giao diện**
   - Chuẩn hoá `ColorScheme.fromSeed` (tránh màu mặc định).
   - Đồng nhất radius, spacing, elevation theo design tokens.

2. **Motion hợp lý**
   - Hero transition cho poster -> detail.
   - Skeleton + fade-in ảnh, nhưng giữ thời lượng animation ngắn.

3. **Video UX polish**
   - Overlay controls dễ chạm, hỗ trợ lock controls, double-tap seek.
   - Cải thiện trạng thái buffering/quality indicator để người dùng hiểu tình trạng mạng.

### P2 – Cải thiện sâu (1–2 tuần)

1. **Telemetry hiệu năng**
   - Đo startup time, frame drop (jank), time-to-first-content.
   - So sánh trước/sau mỗi tối ưu, tránh tối ưu cảm tính.

2. **Tối ưu parse dữ liệu nặng**
   - Dùng `compute()` cho JSON lớn.
   - Hạn chế xử lý đồng bộ trong build phase.

3. **Pagination + prefetch chuẩn hoá theo feature**
   - Tránh tải full list ngay từ đầu.
   - Có cơ chế retry + backoff khi mạng yếu.

## 3) Khuyến nghị về state management theo yêu cầu “native first”

Vì codebase đang dùng BLoC rộng rãi, không nên thay toàn bộ ngay.

- **Giữ BLoC cho app state phức tạp**: auth, playback session, favorites sync.
- **Dùng ValueNotifier/ChangeNotifier cho UI state cục bộ**:
  filter panel, tab tạm thời, expanded/collapsed, slider controls.
- **Hybrid strategy** giúp giảm rủi ro và vẫn đúng định hướng native-first.

## 4) Checklist chất lượng trước mỗi PR

- `flutter analyze .` không lỗi.
- `flutter test .` pass các test hiện có.
- Kiểm tra màn hình chính ở text scale 1.0 / 1.3 / 2.0.
- Kiểm tra dark/light mode và tương phản tối thiểu 4.5:1 cho text.
- Xác nhận không có giật khi cuộn danh sách dài.

## 5) 5 việc nên làm đầu tiên (đề xuất thực tế)

1. Tạo bộ `AppLoadingState`, `AppErrorState`, `AppEmptyState` dùng chung.
2. Chuẩn hoá image caching cho toàn bộ poster/backdrop.
3. Refactor các list lớn sang builder + pagination nhất quán.
4. Chuẩn hoá Material 3 tokens (màu, radius, spacing, typography).
5. Thêm benchmark cơ bản (startup + smooth scrolling) để theo dõi tiến độ.

---

Nếu bạn muốn, bước tiếp theo có thể là:
- Chọn 1 feature cụ thể (ví dụ Home hoặc Movie Detail),
- Mình sẽ đưa patch mẫu theo đúng style code hiện tại,
- Kèm checklist đo hiệu năng trước/sau để bạn áp dụng cho toàn dự án.
