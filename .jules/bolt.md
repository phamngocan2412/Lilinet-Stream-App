## 2026-02-08 - List Lookups in Builders
**Learning:** Using `List.firstWhere` inside `ListView.builder` creates an O(N*M) performance bottleneck when cross-referencing another list (like watch history).
**Action:** Always pre-calculate a lookup Map in the parent widget's `build` method (O(M)) to enable O(1) lookups during scroll.
