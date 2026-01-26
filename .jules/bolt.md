## 2024-05-23 - Image Memory Optimization
**Learning:** `CachedNetworkImage`'s `memCacheWidth` / `memCacheHeight` are critical for memory performance. Hardcoded multipliers (e.g., `width * 2`) are suboptimal. Using `devicePixelRatio` yields precise memory usage.
**Action:** Always calculate `memCacheWidth` as `(targetWidth * devicePixelRatio).toInt()` to minimize memory footprint without sacrificing quality.

## 2024-05-24 - LayoutBuilder for Auto-Sizing Images
**Learning:** Relying solely on explicit `width` parameters for cache sizing is insufficient when widgets are flexible. `LayoutBuilder` allows `AppCachedImage` to determine optimal cache size dynamically when explicit dimensions are missing.
**Action:** Wrap `CachedNetworkImage` in `LayoutBuilder` to use `constraints.maxWidth` as a fallback for `memCacheWidth` calculation, ensuring memory efficiency even in flexible layouts.

## 2024-05-25 - Conditional LayoutBuilder Optimization
**Learning:** `LayoutBuilder` adds an expensive layout pass. When dimensions (`memCacheWidth` or `width`) are known upfront, wrapping widgets in `LayoutBuilder` is unnecessary overhead.
**Action:** Conditionally skip `LayoutBuilder` in `AppCachedImage` by checking for explicit dimensions first, using `LayoutBuilder` only as a fallback for fluid layouts.
