## 2024-05-23 - Image Memory Optimization
**Learning:** `CachedNetworkImage`'s `memCacheWidth` / `memCacheHeight` are critical for memory performance. Hardcoded multipliers (e.g., `width * 2`) are suboptimal. Using `devicePixelRatio` yields precise memory usage.
**Action:** Always calculate `memCacheWidth` as `(targetWidth * devicePixelRatio).toInt()` to minimize memory footprint without sacrificing quality.

## 2024-05-24 - LayoutBuilder for Auto-Sizing Images
**Learning:** Relying solely on explicit `width` parameters for cache sizing is insufficient when widgets are flexible. `LayoutBuilder` allows `AppCachedImage` to determine optimal cache size dynamically when explicit dimensions are missing.
**Action:** Wrap `CachedNetworkImage` in `LayoutBuilder` to use `constraints.maxWidth` as a fallback for `memCacheWidth` calculation, ensuring memory efficiency even in flexible layouts.

## 2024-05-25 - Conditional LayoutBuilder Optimization
**Learning:** `LayoutBuilder` adds unnecessary overhead (layout pass) when dimensions are already known via explicit parameters (e.g. `memCacheWidth` or finite `width`).
**Action:** Skip `LayoutBuilder` wrapper in `AppCachedImage` when `memCacheWidth` is provided or `width` is finite, reducing widget depth and layout callbacks for list/grid items.
