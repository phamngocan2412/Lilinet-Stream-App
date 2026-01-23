## 2025-02-14 - Sensitive Data Logging in Production
**Vulnerability:** `PrettyDioLogger` was configured to run unconditionally, logging HTTP request headers and bodies (including potential query parameters or sensitive data) to the system log even in release builds.
**Learning:** Developers often add logging for debugging purposes but forget to disable it for production. In Flutter, `kDebugMode` is the standard way to gate these debug-only features.
**Prevention:** Always wrap logging and debugging tools (like `PrettyDioLogger`, `Alice`, etc.) in `if (kDebugMode)` blocks or use environment-specific configurations.
