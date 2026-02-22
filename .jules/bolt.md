## 2026-02-08 - List Lookups in Builders
**Learning:** Using `List.firstWhere` inside `ListView.builder` creates an O(N*M) performance bottleneck when cross-referencing another list (like watch history).
**Action:** Always pre-calculate a lookup Map in the parent widget's `build` method (O(M)) to enable O(1) lookups during scroll.

## 2026-02-08 - Refined List Lookup Memoization
**Learning:** Pre-calculating lookup maps in `build` is O(M) on every rebuild. If the data source (e.g. HistoryBloc state) is stable, this is wasteful.
**Action:** Convert to StatefulWidget and memoize the map in `didUpdateWidget`, updating only when data identity changes. Also reuse static empty objects to reduce allocations.

## 2026-02-15 - Optimized Map Iteration in Builders
**Learning:** Using `keys.elementAt(index)` inside a `ListView.builder` or `SliverChildBuilderDelegate` results in O(N^2) complexity because `elementAt` iterates from the start of the map for every item.
**Action:** Convert map entries to a `List` before the builder (O(N)) and access by index (O(1)). Also hoist repeated `MediaQuery.of(context)` calls out of loops.

## 2024-05-22 - [Optimized MediaQuery Usage]
**Learning:** Using `MediaQuery.of(context)` creates a dependency on the entire `MediaQueryData`. If only specific properties like `size` or `devicePixelRatio` are needed, using `MediaQuery.sizeOf(context)` or `MediaQuery.devicePixelRatioOf(context)` prevents unnecessary rebuilds when other properties (like `viewInsets`) change.
**Action:** Always prefer specific `MediaQuery` selectors when only a subset of data is required, especially in widely used widgets or lists.
