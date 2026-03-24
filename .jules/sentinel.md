## 2026-03-24 - [Insecure Randomness for Security Critical Information]
**Vulnerability:** Guest IDs and random User IDs were being generated with `Random()`, which acts as a PRNG and creates cryptographically predictable outputs.
**Learning:** For user identities and other security critical operations or secrets, use cryptographically secure generation mechanisms like `Random.secure()`.
**Prevention:** Avoid `Random()` for generating identifiers where collisions or reverse-engineering may cause authorization vulnerabilities.
