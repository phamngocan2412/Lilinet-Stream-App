## 2026-02-08 - List Lookups in Builders
**Learning:** Using `List.firstWhere` inside `ListView.builder` creates an O(N*M) performance bottleneck when cross-referencing another list (like watch history).
**Action:** Always pre-calculate a lookup Map in the parent widget's `build` method (O(M)) to enable O(1) lookups during scroll.

## 2026-02-08 - Refined List Lookup Memoization
**Learning:** Pre-calculating lookup maps in `build` is O(M) on every rebuild. If the data source (e.g. HistoryBloc state) is stable, this is wasteful.
**Action:** Convert to StatefulWidget and memoize the map in `didUpdateWidget`, updating only when data identity changes. Also reuse static empty objects to reduce allocations.

## 2026-02-15 - Optimized Map Iteration in Builders
**Learning:** Using `keys.elementAt(index)` inside a `ListView.builder` or `SliverChildBuilderDelegate` results in O(N^2) complexity because `elementAt` iterates from the start of the map for every item.
**Action:** Convert map entries to a `List` before the builder (O(N)) and access by index (O(1)). Also hoist repeated `MediaQuery.of(context)` calls out of loops.

## 2026-05-20 - Set Iteration in Builders
**Learning:** Using `Set.elementAt(index)` inside `ListView.builder` is O(N^2) because Sets (even LinkedHashSet) are not indexable in O(1).
**Action:** Always convert `Set` to `List` (using `.toList()`) before passing it to a builder that accesses items by index.

## 2026-05-20 - Preserving Legacy Logic in Fixes
**Learning:** When fixing build errors in existing files (like `download_service.dart`), verify if existing tests rely on "buggy" behavior (like partial sanitization).
**Action:** Run tests immediately after fixes. If tests fail on logic you didn't intend to change (just fix compilation), revert to the behavior expected by tests unless the test is clearly wrong.

## $(date +%Y-%m-%d) - Pre-compute O(N log N) folder extraction in Bloc State
**Learning:** Extracting and sorting a unique set of folders from a list of favorites inside a `BlocBuilder` causes an O(N log N) operation to run on every frame/re-render. This is a noticeable performance bottleneck as the list grows.
**Action:** Always pre-compute derived collections (like sets or filtered lists) inside the Bloc state when the underlying data is updated, and access the pre-computed property directly in the UI.
