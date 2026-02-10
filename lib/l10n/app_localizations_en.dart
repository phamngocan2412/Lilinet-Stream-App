// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get createAccount => 'Create Account';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get username => 'Username';

  @override
  String get enterUsername => 'Please enter your username';

  @override
  String get usernameMinLength => 'Username must be at least 3 characters';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Please enter your password';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get cancel => 'Cancel';

  @override
  String welcomeUser(String name) {
    return 'Welcome $name!';
  }

  @override
  String get loginRequiredAction => 'Please login to perform this action';

  @override
  String get dislikeFeaturePending => 'Dislike feature is under development';

  @override
  String get replyingTo => 'Replying to';

  @override
  String get retry => 'Retry';

  @override
  String get noComments => 'No comments yet';

  @override
  String get beFirstToComment => 'Be the first to comment!';

  @override
  String get writeReply => 'Write a reply...';

  @override
  String get collapse => 'Collapse';

  @override
  String get seeMore => 'See more';

  @override
  String get reply => 'Reply';

  @override
  String hideReplies(int count) {
    return 'Hide $count replies';
  }

  @override
  String viewReplies(int count) {
    return '$count replies';
  }

  @override
  String viewMoreReplies(int count) {
    return 'View $count more replies';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get downloadSection => 'Download';

  @override
  String get wifiOnly => 'WiFi Only';

  @override
  String get wifiOnlySubtitle => 'Download only on WiFi connection';

  @override
  String get myDownloads => 'My Downloads';

  @override
  String get myDownloadsSubtitle => 'View and manage downloaded videos';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get pushNotificationsSubtitle => 'Receive app notifications';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get clearCacheMessage =>
      'This will remove all cached images to free up space. Your settings and login will not be affected. Are you sure?';

  @override
  String get clearSuccess => 'Cache cleared successfully';

  @override
  String get resetSettings => 'Reset Settings';

  @override
  String get resetSettingsMessage =>
      'This will reset your preferences (Theme, Quality, etc) to default. Your account will remain logged in. Are you sure?';

  @override
  String get resetSuccess => 'Settings reset successfully';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountMessage =>
      'Are you sure you want to delete your account? This action cannot be undone and you will lose all your favorites and history.';

  @override
  String get delete => 'Delete';

  @override
  String get reset => 'Reset';

  @override
  String get clear => 'Clear';

  @override
  String get resetAllSettings => 'Reset All Settings';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get rewind => 'Rewind';

  @override
  String get forward => 'Forward';

  @override
  String get settings => 'Settings';

  @override
  String get fullscreen => 'Fullscreen';

  @override
  String get exitFullscreen => 'Exit Fullscreen';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get share => 'Share';

  @override
  String get addToFavorites => 'Add to Favorites';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

  @override
  String get filter => 'Filter';

  @override
  String get minimize => 'Minimize';

  @override
  String get cast => 'Cast';

  @override
  String get pip => 'Picture in Picture';

  @override
  String get speed => 'Playback Speed';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get download => 'Download';

  @override
  String get refresh => 'Refresh';

  @override
  String get search => 'Search';

  @override
  String get edit => 'Edit';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get send => 'Send';

  @override
  String commentLoadError(String message) {
    return 'Unable to load comments: $message';
  }

  @override
  String commentsCount(int count) {
    return 'Comments ($count)';
  }

  @override
  String get noCommentsYet => 'No comments yet. Be the first to comment!';

  @override
  String get featuredCommentsTitle => 'FEATURED COMMENTS';

  @override
  String get cannotOpenMockVideo => 'Cannot open this video (mock data)';

  @override
  String get syncing => 'Syncing...';

  @override
  String get notSynced => 'Not synced';

  @override
  String passwordResetEmailSent(String email) {
    return 'Password reset email has been sent to $email';
  }

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get passwordResetInstructions =>
      'Enter your email to receive a password reset link';

  @override
  String get email => 'Email';

  @override
  String get enterEmail => 'Please enter your email';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get sendResetEmail => 'Send reset email';

  @override
  String get tapToViewComments => 'Tap to view comments...';

  @override
  String get loginToComment => 'Please login to comment';

  @override
  String get justCommentedOn => ' just commented on ';

  @override
  String episodeNumber(String number) {
    return 'Episode $number';
  }

  @override
  String get noNetworkError =>
      'No network connection. Please check and try again.';

  @override
  String get timeoutError => 'Connection timeout. Please try again.';

  @override
  String get sessionExpiredError => 'Session expired. Please login again.';

  @override
  String get forbiddenError =>
      'You do not have permission to perform this action.';

  @override
  String get notFoundError => 'Requested content not found.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get unknownError => 'An error occurred. Please try again.';

  @override
  String addCommentError(String message) {
    return 'Unable to send comment: $message';
  }

  @override
  String get addCommentHint => 'Add a comment...';

  @override
  String get authRequired => 'Authentication required. Please login.';

  @override
  String get invalidResponse => 'Invalid response format';

  @override
  String get sourceUnavailable =>
      'Source unavailable. Please try another server or movie.';

  @override
  String get rateLimited =>
      'System busy (Rate Limit). Please try again in a few seconds.';

  @override
  String get providerError => 'Provider error. Please try again later.';

  @override
  String get serviceUnavailable => 'Service temporarily unavailable';

  @override
  String get qualitySwitchFailed =>
      'Quality switch failed. Continuing with current quality.';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String weeksAgo(int count) {
    return '$count weeks ago';
  }

  @override
  String get edited => 'edited';

  @override
  String get someone => 'Someone';

  @override
  String get unknownMovie => 'Unknown Movie';

  @override
  String get emailHint => 'example@email.com';

  @override
  String get pinMustBe4Digits => 'PIN must be 4 digits';

  @override
  String get incorrectPin => 'Incorrect PIN';

  @override
  String get enterPin => 'Enter PIN';

  @override
  String get confirmPin => 'Confirm PIN';

  @override
  String get setupPin => 'Setup PIN';

  @override
  String get changePin => 'Change PIN';

  @override
  String get setPinTitle => 'Set PIN';

  @override
  String get enterPinTitle => 'Enter PIN';

  @override
  String get setPinInstruction =>
      'Enter a 4-digit PIN to secure adult content.';

  @override
  String get enterPinInstruction => 'Enter your PIN to access this feature.';

  @override
  String get anonymous => 'Anonymous';

  @override
  String get sortTop => 'Top';

  @override
  String get sortNewest => 'Newest';

  @override
  String get more => 'More';

  @override
  String get server => 'Server';

  @override
  String get quality => 'Quality';

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get searchHint => 'Search anime...';

  @override
  String get searchForAnime => 'Search for anime';

  @override
  String noResultsFound(String filter, String query) {
    return 'No $filter results found for \"$query\"';
  }

  @override
  String get filterAll => 'All';

  @override
  String get filterTVSeries => 'TV Series';

  @override
  String get filterMovie => 'Movie';

  @override
  String get changePassword => 'Change Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordChangeSuccess => 'Password changed successfully';

  @override
  String get update => 'Update';

  @override
  String get updateProfile => 'Update Profile';

  @override
  String get displayName => 'Display Name';

  @override
  String get avatarUrl => 'Avatar URL';

  @override
  String get profileUpdateSuccess => 'Profile updated successfully';

  @override
  String get save => 'Save';
}
