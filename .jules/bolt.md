## 2024-05-23 - Image Memory Optimization
**Learning:** Hardcoded cache sizes (e.g., `700px`) in image widgets can lead to significant memory waste on smaller devices or in grid layouts.
**Action:** Always calculate `memCacheWidth` based on the target display size (Screen Width / Columns * Pixel Density) to minimize memory usage without sacrificing quality.
