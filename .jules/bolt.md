## 2024-05-23 - Image Memory Optimization
**Learning:** `CachedNetworkImage`'s `memCacheWidth` / `memCacheHeight` are critical for memory performance. Hardcoded multipliers (e.g., `width * 2`) are suboptimal. Using `devicePixelRatio` yields precise memory usage.
**Action:** Always calculate `memCacheWidth` as `(targetWidth * devicePixelRatio).toInt()` to minimize memory footprint without sacrificing quality.
