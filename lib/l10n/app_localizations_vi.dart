// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get helloWorld => 'Chào Thế Giới';

  @override
  String get welcomeBack => 'Chào mừng trở lại';

  @override
  String get createAccount => 'Tạo tài khoản';

  @override
  String get login => 'Đăng nhập';

  @override
  String get signUp => 'Đăng ký';

  @override
  String get username => 'Tên đăng nhập';

  @override
  String get enterUsername => 'Vui lòng nhập tên đăng nhập';

  @override
  String get usernameMinLength => 'Tên đăng nhập phải có ít nhất 3 ký tự';

  @override
  String get password => 'Mật khẩu';

  @override
  String get enterPassword => 'Vui lòng nhập mật khẩu';

  @override
  String get passwordMinLength => 'Mật khẩu phải có ít nhất 8 ký tự';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get cancel => 'Hủy';

  @override
  String welcomeUser(String name) {
    return 'Chào mừng $name!';
  }

  @override
  String get loginRequiredAction =>
      'Vui lòng đăng nhập để thực hiện thao tác này';

  @override
  String get dislikeFeaturePending => 'Chức năng dislike đang phát triển';

  @override
  String get replyingTo => 'Đang trả lời';

  @override
  String get retry => 'Thử lại';

  @override
  String get noComments => 'Chưa có bình luận nào';

  @override
  String get beFirstToComment => 'Hãy là người đầu tiên bình luận!';

  @override
  String get writeReply => 'Viết trả lời...';

  @override
  String get collapse => 'Thu gọn';

  @override
  String get seeMore => 'Xem thêm';

  @override
  String get reply => 'Phản hồi';

  @override
  String hideReplies(int count) {
    return 'Ẩn $count phản hồi';
  }

  @override
  String viewReplies(int count) {
    return '$count phản hồi';
  }

  @override
  String viewMoreReplies(int count) {
    return 'Xem thêm $count phản hồi';
  }

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get downloadSection => 'Tải xuống';

  @override
  String get wifiOnly => 'Chỉ tải qua WiFi';

  @override
  String get wifiOnlySubtitle => 'Chỉ tải video khi có kết nối WiFi';

  @override
  String get myDownloads => 'Video đã tải';

  @override
  String get myDownloadsSubtitle => 'Xem và quản lý video đã tải';

  @override
  String get notificationsSection => 'Thông báo';

  @override
  String get pushNotifications => 'Thông báo đẩy';

  @override
  String get pushNotificationsSubtitle => 'Nhận thông báo từ ứng dụng';

  @override
  String get clearCache => 'Xóa bộ nhớ đệm';

  @override
  String get clearCacheMessage =>
      'Hành động này sẽ xóa tất cả hình ảnh đã lưu trong bộ nhớ đệm để giải phóng dung lượng. Cài đặt và đăng nhập của bạn sẽ không bị ảnh hưởng. Bạn có chắc chắn không?';

  @override
  String get clearSuccess => 'Đã xóa bộ nhớ đệm thành công';

  @override
  String get resetSettings => 'Đặt lại cài đặt';

  @override
  String get resetSettingsMessage =>
      'Hành động này sẽ đặt lại các tùy chọn của bạn (Giao diện, Chất lượng, v.v.) về mặc định. Tài khoản của bạn vẫn sẽ được đăng nhập. Bạn có chắc chắn không?';

  @override
  String get resetSuccess => 'Đã đặt lại cài đặt thành công';

  @override
  String get deleteAccount => 'Xóa tài khoản';

  @override
  String get deleteAccountMessage =>
      'Bạn có chắc chắn muốn xóa tài khoản của mình không? Hành động này không thể hoàn tác và bạn sẽ mất tất cả danh sách yêu thích và lịch sử xem.';

  @override
  String get delete => 'Xóa';

  @override
  String get reset => 'Đặt lại';

  @override
  String get clear => 'Xóa';

  @override
  String get resetAllSettings => 'Đặt lại tất cả cài đặt';

  @override
  String get play => 'Phát';

  @override
  String get pause => 'Tạm dừng';

  @override
  String get rewind => 'Tua lại';

  @override
  String get forward => 'Tua đi';

  @override
  String get settings => 'Cài đặt';

  @override
  String get fullscreen => 'Toàn màn hình';

  @override
  String get exitFullscreen => 'Thoát toàn màn hình';

  @override
  String get close => 'Đóng';

  @override
  String get back => 'Quay lại';

  @override
  String get share => 'Chia sẻ';

  @override
  String get addToFavorites => 'Thêm vào yêu thích';

  @override
  String get removeFromFavorites => 'Xóa khỏi yêu thích';

  @override
  String get filter => 'Bộ lọc';

  @override
  String get minimize => 'Thu nhỏ';

  @override
  String get cast => 'Truyền';

  @override
  String get pip => 'Hình trong hình';

  @override
  String get speed => 'Tốc độ phát';

  @override
  String get previous => 'Trước';

  @override
  String get next => 'Tiếp';

  @override
  String get download => 'Tải xuống';

  @override
  String get refresh => 'Làm mới';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get showPassword => 'Hiện mật khẩu';

  @override
  String get hidePassword => 'Ẩn mật khẩu';

  @override
  String get send => 'Gửi';

  @override
  String commentLoadError(String message) {
    return 'Không thể tải bình luận: $message';
  }

  @override
  String commentsCount(int count) {
    return 'Bình luận ($count)';
  }

  @override
  String get noCommentsYet => 'Chưa có bình luận nào. Hãy là người đầu tiên!';

  @override
  String get featuredCommentsTitle => 'BÌNH LUẬN NỔI BẬT';

  @override
  String get cannotOpenMockVideo => 'Không thể mở phim này (dữ liệu mẫu)';

  @override
  String get syncing => 'Đang đồng bộ...';

  @override
  String get notSynced => 'Chưa đồng bộ';

  @override
  String passwordResetEmailSent(String email) {
    return 'Email đặt lại mật khẩu đã được gửi đến $email';
  }

  @override
  String get forgotPasswordTitle => 'Quên mật khẩu?';

  @override
  String get passwordResetInstructions =>
      'Nhập email của bạn để nhận link đặt lại mật khẩu';

  @override
  String get email => 'Email';

  @override
  String get enterEmail => 'Vui lòng nhập email';

  @override
  String get invalidEmail => 'Email không hợp lệ';

  @override
  String get sendResetEmail => 'Gửi email đặt lại';

  @override
  String get tapToViewComments => 'Chạm để xem bình luận...';

  @override
  String get loginToComment => 'Vui lòng đăng nhập để bình luận';

  @override
  String get justCommentedOn => ' vừa bình luận tại ';

  @override
  String episodeNumber(String number) {
    return 'Tập $number';
  }

  @override
  String get noNetworkError =>
      'Không có kết nối mạng. Vui lòng kiểm tra và thử lại.';

  @override
  String get timeoutError => 'Kết nối quá thời gian. Vui lòng thử lại.';

  @override
  String get sessionExpiredError =>
      'Phiên đăng nhập hết hạn. Vui lòng đăng nhập lại.';

  @override
  String get forbiddenError => 'Bạn không có quyền thực hiện thao tác này.';

  @override
  String get notFoundError => 'Không tìm thấy nội dung yêu cầu.';

  @override
  String get serverError => 'Lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  String get unknownError => 'Đã xảy ra lỗi. Vui lòng thử lại.';

  @override
  String addCommentError(String message) {
    return 'Không thể gửi bình luận: $message';
  }

  @override
  String get addCommentHint => 'Thêm bình luận...';

  @override
  String get authRequired => 'Không thể truy cập. Vui lòng đăng nhập.';

  @override
  String get invalidResponse => 'Định dạng phản hồi không hợp lệ';

  @override
  String get sourceUnavailable =>
      'Nguồn phát không khả dụng. Vui lòng thử server hoặc phim khác.';

  @override
  String get rateLimited =>
      'Hệ thống đang bận (Rate Limit). Vui lòng thử lại sau vài giây.';

  @override
  String get providerError =>
      'Lỗi từ nguồn dữ liệu (Provider). Vui lòng thử lại sau.';

  @override
  String get serviceUnavailable => 'Dịch vụ tạm thời gián đoạn';

  @override
  String get qualitySwitchFailed =>
      'Lỗi chuyển đổi chất lượng. Đang tiếp tục với chất lượng hiện tại.';

  @override
  String get justNow => 'Vừa xong';

  @override
  String minutesAgo(int count) {
    return '$count phút trước';
  }

  @override
  String hoursAgo(int count) {
    return '$count giờ trước';
  }

  @override
  String daysAgo(int count) {
    return '$count ngày trước';
  }

  @override
  String weeksAgo(int count) {
    return '$count tuần trước';
  }

  @override
  String get edited => 'đã chỉnh sửa';

  @override
  String get someone => 'Ai đó';

  @override
  String get unknownMovie => 'Phim không xác định';

  @override
  String get emailHint => 'example@email.com';

  @override
  String get pinMustBe4Digits => 'Mã PIN phải có 4 chữ số';

  @override
  String get incorrectPin => 'Mã PIN không chính xác';

  @override
  String get enterPin => 'Nhập mã PIN';

  @override
  String get confirmPin => 'Xác nhận mã PIN';

  @override
  String get setupPin => 'Thiết lập mã PIN';

  @override
  String get changePin => 'Thay đổi mã PIN';

  @override
  String get setPinTitle => 'Thiết lập PIN';

  @override
  String get enterPinTitle => 'Nhập mã PIN';

  @override
  String get setPinInstruction =>
      'Nhập mã PIN 4 chữ số để bảo mật nội dung người lớn.';

  @override
  String get enterPinInstruction =>
      'Nhập mã PIN của bạn để truy cập tính năng này.';

  @override
  String get anonymous => 'Ẩn danh';

  @override
  String get sortTop => 'Hàng đầu';

  @override
  String get sortNewest => 'Mới nhất';

  @override
  String get more => 'Thêm';

  @override
  String get server => 'Máy chủ';

  @override
  String get quality => 'Chất lượng';
}
