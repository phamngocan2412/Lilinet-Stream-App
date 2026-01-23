## 2024-05-22 - [Data Leakage via Logging]
**Vulnerability:** Network request headers and bodies were being logged unconditionally using `PrettyDioLogger`.
**Learning:** Development tools often default to verbose output which is dangerous in production.
**Prevention:** Always wrap debug loggers in `kDebugMode` or environment checks.
