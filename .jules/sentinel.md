## 2024-03-21 - Restrict Network Logging to Debug Mode
**Vulnerability:** Unrestricted network logging (`PrettyDioLogger`) exposed sensitive request headers and bodies in production builds, potentially leaking auth tokens and PII.
**Learning:** Development tools like loggers must be explicitly disabled in production builds using conditional checks like `kDebugMode`.
**Prevention:** Always wrap debug-only interceptors or logging mechanisms in `if (kDebugMode)` or similar build-type checks.
