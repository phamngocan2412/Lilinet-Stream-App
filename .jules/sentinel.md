## 2024-05-22 - Insecure Randomness in Sensitive Identifiers
**Vulnerability:** The application used `Random()` from `dart:math` to generate local comment IDs and guest usernames. `Random()` is a pseudo-random number generator that is cryptographically weak and predictable.
**Learning:** In a codebase, predictably generated sensitive values (like local IDs, tokens, or usernames) could allow malicious actors to infer state or collide with real identifiers. The `dart:math` package explicitly states `Random()` is not suitable for cryptographic or security purposes.
**Prevention:** Always use `Random.secure()` when generating unique identifiers, session logic, or user handles that need unpredictability to maintain cryptographic strength and integrity.
