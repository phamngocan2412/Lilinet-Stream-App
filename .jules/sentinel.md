## 2026-01-20 - Network Logging in Production
**Vulnerability:** Detailed network logging (headers, bodies) was enabled unconditionally, exposing sensitive data (auth tokens, PII) in production logs.
**Learning:** Development tools like `PrettyDioLogger` are convenient but dangerous if not guarded.
**Prevention:** Always wrap debug-only logic (loggers, inspectors) in `if (kDebugMode)` or strip them from release builds.
## 2024-05-23 - Unconditional Network Logging in Production
**Vulnerability:** The `PrettyDioLogger` was being added to the Dio interceptors unconditionally, which means all network requests and responses (including potential sensitive data like tokens or PII) would be logged to the console in production builds.
**Learning:** Development tools that log sensitive information must always be guarded by environment checks (e.g., `kDebugMode`). Developers often forget that "Release" builds strip some debugging info but `print` or `log` statements might still function depending on the implementation, and specifically `PrettyDioLogger` uses `log` which can leak info if not disabled.
**Prevention:** Always wrap logging interceptors or verbose logging logic in `if (kDebugMode) { ... }` blocks. Review `Dio` client setup during code reviews.
