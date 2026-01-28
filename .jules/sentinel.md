## 2026-01-20 - Network Logging in Production
**Vulnerability:** Detailed network logging (headers, bodies) was enabled unconditionally, exposing sensitive data (auth tokens, PII) in production logs.
**Learning:** Development tools like `PrettyDioLogger` are convenient but dangerous if not guarded.
**Prevention:** Always wrap debug-only logic (loggers, inspectors) in `if (kDebugMode)` or strip them from release builds.
## 2024-05-23 - Unconditional Network Logging in Production
**Vulnerability:** The `PrettyDioLogger` was being added to the Dio interceptors unconditionally, which means all network requests and responses (including potential sensitive data like tokens or PII) would be logged to the console in production builds.
**Learning:** Development tools that log sensitive information must always be guarded by environment checks (e.g., `kDebugMode`). Developers often forget that "Release" builds strip some debugging info but `print` or `log` statements might still function depending on the implementation, and specifically `PrettyDioLogger` uses `log` which can leak info if not disabled.
**Prevention:** Always wrap logging interceptors or verbose logging logic in `if (kDebugMode) { ... }` blocks. Review `Dio` client setup during code reviews.

## 2026-01-23 - Client-Side Validation Hardening Risks
**Vulnerability:** Weak password requirements (< 8 chars) allowed weak passwords.
**Learning:** Simply increasing client-side validation length (e.g., 6 -> 8) on a shared `AuthDialog` (used for both Login and Register) can lock out existing users with legacy passwords.
**Prevention:** Decouple Login and Registration validation logic. Enforce strict policies on Registration/Password Change, but allow legacy passwords on Login (potentially with a warning/prompt to upgrade).

## 2026-10-24 - Secure Network Logging
**Vulnerability:** `PrettyDioLogger` was configured to log request bodies in `kDebugMode`, which exposed plaintext passwords and tokens in the debug console.
**Learning:** Even in debug mode, sensitive data should not be logged to avoid accidental exposure or persistence in log files.
**Prevention:** Use a custom `SecureInterceptor` that redacts sensitive keys (`password`, `token`) before logging, and disable raw body logging in `PrettyDioLogger`.

## 2026-10-25 - Insecure Header Logging
**Vulnerability:** `PrettyDioLogger` with `requestHeader: true` logs sensitive headers like `Authorization` in plaintext.
**Learning:** Disabling `requestHeader` is not enough if you need to debug; you must implement custom redaction. Standard loggers often lack granular control.
**Prevention:** Implement custom interceptors for logging that specifically target and redact sensitive keys in both Body and Headers.
