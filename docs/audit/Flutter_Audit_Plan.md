# 🔍 LILINET App - Complete Code Audit Plan

## 📋 Executive Summary

**Project:** LILINET Movie Streaming App
**Total Files:** 264 Dart files
**Audit Focus:** Anti-patterns, Performance, Architecture, Build Size
**Estimated Time:** 3-5 days (phased approach)
**Priority:** High → Medium → Low

---

## 🎯 AUDIT OBJECTIVES

### 1️⃣ Code Anti-Patterns Detection
- [ ] Widget tree complexity violations
- [ ] Missing `const` constructors
- [ ] Inefficient rebuilds
- [ ] Memory leaks
- [ ] Poor error handling

### 2️⃣ Performance Optimization
- [ ] Rebuild analysis
- [ ] FPS optimization for lists
- [ ] Memory profiling
- [ ] Image loading optimization
- [ ] State management efficiency

### 3️⃣ Architecture Review
- [ ] Clean Architecture compliance
- [ ] Layer separation
- [ ] Testability assessment
- [ ] Dependency injection review

### 4️⃣ Build Size Optimization
- [ ] Bundle analysis
- [ ] Asset optimization
- [ ] Code splitting opportunities
- [ ] Tree-shaking effectiveness

---

## 📅 PHASED AUDIT PLAN

### 🔴 PHASE 1: Critical Issues (Day 1-2)
**Priority:** HIGH
**Goal:** Identify and fix performance killers

#### Tasks:
1. **Widget Tree Audit**
   - Scan all presentation/pages files
   - Identify deeply nested widgets (>5 levels)
   - Find functions returning widgets instead of widgets
   - Check for missing `const` constructors

2. **Performance Hotspots**
   - Analyze list rendering (movie lists, episode lists)
   - Check image loading patterns
   - Review state management rebuilds
   - Profile memory usage

3. **Critical Code Smells**
   - Find synchronous operations in build()
   - Locate missing error boundaries
   - Identify potential memory leaks

---

### 🟡 PHASE 2: Architecture & Quality (Day 3-4)
**Priority:** MEDIUM
**Goal:** Ensure maintainability and testability

#### Tasks:
1. **Clean Architecture Validation**
   - Verify layer separation
   - Check dependency rules
   - Review use case implementations
   - Assess repository patterns

2. **Code Quality Metrics**
   - Complexity analysis
   - Duplication detection
   - Naming conventions
   - Documentation coverage

3. **Testing Strategy**
   - Identify untestable code
   - Create test templates
   - Setup testing infrastructure

---

### 🟢 PHASE 3: Optimization & Polish (Day 5)
**Priority:** LOW
**Goal:** Fine-tune and optimize

#### Tasks:
1. **Build Size Reduction**
   - Analyze APK/IPA contents
   - Optimize assets
   - Remove unused dependencies
   - Configure ProGuard/R8

2. **Advanced Performance**
   - Implement lazy loading
   - Add performance monitoring
   - Optimize animations
   - Configure caching strategies

---

## 📂 FILE-BY-FILE AUDIT CHECKLIST

### 🎬 CRITICAL FILES TO AUDIT

#### 1. **Presentation Layer - Pages** (Highest Priority)

| File | Line Count | Issues to Check | Priority |
|------|------------|-----------------|----------|
| `home_page.dart` | 311 | Widget tree depth, const usage, list optimization | 🔴 HIGH |
| `movie_details_page.dart` | 406 | Rebuild triggers, image loading, state management | 🔴 HIGH |
| `search_page.dart` | ? | Debouncing, list performance | 🔴 HIGH |
| `favorites_page.dart` | ? | List rendering, empty states | 🟡 MED |
| `settings_page.dart` | ? | Form optimization | 🟢 LOW |

**Audit Checklist for Each Page:**
```
[ ] Widget tree depth < 5 levels
[ ] All static widgets use const
[ ] ListView.builder used (not ListView)
[ ] Images have cacheWidth/cacheHeight
[ ] buildWhen used in BlocBuilder
[ ] RepaintBoundary on list items
[ ] No sync operations in build()
[ ] Proper key usage
[ ] AutomaticKeepAliveClientMixin where needed
```

---

#### 2. **Widgets - Reusable Components**

| Widget | Issues to Check | Priority |
|--------|-----------------|----------|
| `movie_card.dart` | const usage, computation in build() | 🔴 HIGH |
| `trending_carousel.dart` | PageView optimization | 🔴 HIGH |
| `cached_image.dart` | Memory limits, error handling | 🔴 HIGH |
| `episode_item.dart` | List tile optimization | 🟡 MED |
| `loading_indicator.dart` | const usage | 🟢 LOW |

**Specific Checks:**
```dart
// ❌ ANTI-PATTERN EXAMPLES TO FIND:

// 1. Function returning Widget instead of Widget
Widget _buildSomething() { ... }  // ❌ BAD

// Instead should be:
class _SomethingWidget extends StatelessWidget { ... }  // ✅ GOOD

// 2. Missing const
return Container(
  color: Colors.red,  // ❌ Should be const Color(0xFFFF0000)
)

// 3. Expensive operations in build()
@override
Widget build(BuildContext context) {
  final list = movies.where((m) => m.rating > 7).toList();  // ❌ BAD
  // Should be in state or computed once
}

// 4. No ListView.builder
return ListView(
  children: movies.map((m) => MovieCard(m)).toList(),  // ❌ BAD
)

// Instead:
return ListView.builder(
  itemCount: movies.length,
  itemBuilder: (ctx, i) => MovieCard(movies[i]),  // ✅ GOOD
)
```

---

#### 3. **BLoC/State Management**

| BLoC | Issues to Check | Priority |
|------|-----------------|----------|
| `trending_movies_bloc.dart` | Event handling, state emissions | 🔴 HIGH |
| `movie_details_bloc.dart` | Loading states, error handling | 🔴 HIGH |
| `video_player_bloc.dart` | Stream subscriptions, dispose | 🔴 HIGH |
| `favorites_bloc.dart` | Optimistic updates | 🟡 MED |

**BLoC Audit Checklist:**
```
[ ] No business logic in presentation layer
[ ] Proper error handling in all events
[ ] Stream controllers properly disposed
[ ] No sync* generators (use async*)
[ ] Event debouncing where needed
[ ] buildWhen used to prevent rebuilds
[ ] Freezed/Equatable for state comparison
[ ] No state mutations (immutability)
```

---

#### 4. **Repository & Data Layer**

| Component | Issues to Check | Priority |
|-----------|-----------------|----------|
| `movie_repository_impl.dart` | Caching strategy, error handling | 🟡 MED |
| `movie_remote_datasource.dart` | Network timeouts, retry logic | 🟡 MED |
| `movie_local_datasource.dart` | Database performance | 🟡 MED |

---

## 🎯 SPECIFIC ANTI-PATTERNS TO FIND

### ❌ PATTERN 1: Computation in build()

**Files to check:**
- `lib/features/movies/presentation/widgets/movie_card.dart`
- `lib/features/movies/presentation/pages/home_page.dart`

**Look for:**
```dart
@override
Widget build(BuildContext context) {
  // ❌ String manipulation in build
  final badgeText = movie.type.toLowerCase().contains('tv')
    ? '${movie.totalEpisodes} Eps'
    : 'Full HD';

  // ❌ Filtering/mapping in build
  final filteredMovies = movies.where((m) => m.rating > 7).toList();

  // ❌ Theme/MediaQuery called multiple times
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final textTheme = theme.textTheme;

  return ...
}
```

**Solution:**
```dart
// ✅ Move to getter or compute once in initState
class _MovieCardState extends State<MovieCard> {
  late final String badgeText;

  @override
  void initState() {
    super.initState();
    badgeText = _computeBadgeText();
  }

  String _computeBadgeText() {
    // Compute once
  }
}

// Or add to entity
class Movie {
  String get badgeText => // computed property
}
```

---

### ❌ PATTERN 2: Missing RepaintBoundary

**Files to check:**
- `lib/features/movies/presentation/widgets/movie_list.dart`
- `lib/features/movies/presentation/widgets/episode_list.dart`

**Look for:**
```dart
// ❌ Missing RepaintBoundary
ListView.builder(
  itemBuilder: (context, index) {
    return MovieCard(movies[index]);  // ❌
  },
)
```

**Solution:**
```dart
// ✅ Add RepaintBoundary
ListView.builder(
  itemBuilder: (context, index) {
    return RepaintBoundary(
      child: MovieCard(movies[index]),
    );
  },
)
```

---

### ❌ PATTERN 3: LayoutBuilder Overuse

**Files to check:**
- `lib/core/widgets/cached_image.dart`
- Various responsive widgets

**Check:**
```dart
// ⚠️ Is LayoutBuilder necessary here?
return LayoutBuilder(
  builder: (context, constraints) {
    return Image(...);  // Could use MediaQuery.sizeOf instead?
  },
)
```

**Better:**
```dart
// ✅ Use MediaQuery.sizeOf (Flutter 3.10+)
final size = MediaQuery.sizeOf(context);
return SizedBox(
  width: size.width * 0.8,
  child: Image(...),
);
```

---

### ❌ PATTERN 4: setState in Loops

**Look for:**
```dart
// ❌ BAD: Multiple setState calls
for (var item in items) {
  setState(() {
    processedItems.add(process(item));
  });
}

// ✅ GOOD: Single setState
setState(() {
  processedItems.addAll(items.map(process));
});
```

---

### ❌ PATTERN 5: Keys Not Used Properly

**Look for:**
```dart
// ❌ No key in stateful lists
ListView.builder(
  itemBuilder: (context, index) {
    return MovieCard(movies[index]);  // No key!
  },
)

// ✅ Add ValueKey
ListView.builder(
  itemBuilder: (context, index) {
    return MovieCard(
      key: ValueKey(movies[index].id),  // ✅
      movie: movies[index],
    );
  },
)
```

---

## 🧪 PERFORMANCE TESTING PLAN

### Test 1: Frame Rate Monitoring

**Setup:**
```dart
// Add to main.dart
import 'package:flutter/scheduler.dart';

void main() {
  SchedulerBinding.instance.addTimingsCallback((timings) {
    for (final timing in timings) {
      final frameTime = timing.totalSpan.inMilliseconds;
      if (frameTime > 16) {  // 60 FPS = 16.67ms per frame
        debugPrint('⚠️ DROPPED FRAME: ${frameTime}ms');
        debugPrint('   Build: ${timing.buildDuration.inMilliseconds}ms');
        debugPrint('   Raster: ${timing.rasterDuration.inMilliseconds}ms');
      }
    }
  });

  runApp(MyApp());
}
```

**Test Scenarios:**
1. Scroll home page movie list rapidly
2. Open/close video player repeatedly
3. Switch between tabs quickly
4. Load movie details with many episodes
5. Search with rapid typing

**Success Criteria:**
- < 5% dropped frames during normal scrolling
- < 100ms for page transitions
- Smooth 60 FPS video playback

---

### Test 2: Memory Profiling

**Tools:**
- Flutter DevTools Memory tab
- `flutter run --profile`

**Test Scenarios:**
```
1. Open app → Record baseline memory
2. Navigate to 10 different movie details
3. Return to home → Check for leaks
4. Play video → Monitor memory growth
5. Stop video → Memory should return to baseline
```

**Red Flags:**
- Memory growing linearly (leak!)
- Not releasing after navigation
- Heap size > 200MB on mid-range device

---

### Test 3: Rebuild Counter

**Add to widgets you suspect:**
```dart
class _MovieCardState extends State<MovieCard> {
  int _buildCount = 0;

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    if (kDebugMode) {
      print('🔄 MovieCard rebuilt: $_buildCount times');
    }
    return ...
  }
}
```

**Expected Results:**
- MovieCard in list: 1-2 rebuilds (initial + 1 update)
- > 5 rebuilds = Problem!

---

## 🏗️ ARCHITECTURE AUDIT

### Clean Architecture Layer Check

#### ✅ CORRECT Structure:
```
lib/
  features/
    movies/
      domain/           ← ✅ Pure Dart, no Flutter
        entities/       ← ✅ Business objects
        repositories/   ← ✅ Contracts only
        usecases/       ← ✅ Business logic
      data/             ← ✅ Implementation details
        datasources/
        models/         ← ✅ toJson/fromJson
        repositories/   ← ✅ Repository impl
      presentation/     ← ✅ Flutter widgets
        bloc/
        pages/
        widgets/
```

#### ❌ VIOLATIONS to Find:

**1. Domain importing Flutter:**
```dart
// ❌ domain/entities/movie.dart
import 'package:flutter/material.dart';  // VIOLATION!

// ✅ Should be pure Dart
class Movie {
  final String title;
  // No Flutter dependencies!
}
```

**2. Presentation importing Data:**
```dart
// ❌ presentation/pages/home_page.dart
import '../../../data/models/movie_model.dart';  // VIOLATION!

// ✅ Should only import domain
import '../../../domain/entities/movie.dart';
```

**3. Use Case with UI Logic:**
```dart
// ❌ domain/usecases/get_movies.dart
class GetMovies {
  Future<List<Movie>> call() async {
    showDialog(...);  // VIOLATION! UI in use case
  }
}
```

---

## 📦 BUILD SIZE OPTIMIZATION PLAN

### Current State Analysis

**Run these commands:**
```bash
# 1. Build release APK
flutter build apk --release --analyze-size

# 2. Build App Bundle
flutter build appbundle --release --analyze-size

# 3. Generate size report
flutter build apk --release --target-platform android-arm64 --analyze-size > size_report.txt
```

---

### Target Sizes

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| APK Size (arm64) | ? MB | < 25 MB | ⏳ |
| APK Size (armv7) | ? MB | < 20 MB | ⏳ |
| App Bundle | ? MB | < 30 MB | ⏳ |
| Download Size | ? MB | < 15 MB | ⏳ |

---

## 📝 AUDIT REPORT TEMPLATE

After completing audit, fill this out:

```markdown
# LILINET Code Audit Report

## Executive Summary
- **Audit Date:** [Date]
- **Auditor:** [Name]
- **Total Issues Found:** [Number]
- **Critical:** [Number]
- **High:** [Number]
- **Medium:** [Number]
- **Low:** [Number]

## Critical Issues

### Issue #1: [Title]
- **File:** [Path]
- **Line:** [Number]
- **Severity:** Critical
- **Description:** [What's wrong]
- **Impact:** [Performance/Memory/UX impact]
- **Fix:** [How to fix]
- **Effort:** [Time estimate]

## Performance Metrics

### Before Optimization
- Home page load: [X]ms
- Movie details load: [X]ms
- List scroll FPS: [X]
- Memory usage: [X]MB
- APK size: [X]MB

### After Optimization
- Home page load: [X]ms ⬇️ [%] improvement
- Movie details load: [X]ms ⬇️ [%] improvement
- List scroll FPS: [X] ⬆️ [%] improvement
- Memory usage: [X]MB ⬇️ [%] improvement
- APK size: [X]MB ⬇️ [%] improvement
```

---

## 🛠️ TOOLS & COMMANDS REFERENCE

### Essential Commands

```bash
# 1. Performance profiling
flutter run --profile
# Then use DevTools Performance tab

# 2. Memory profiling
flutter run --profile
# Then use DevTools Memory tab

# 3. Build size analysis
flutter build apk --analyze-size --target-platform android-arm64

# 4. Check for unused files
dart run dart_code_metrics:metrics analyze lib

# 5. Static analysis
flutter analyze

# 6. Dependency audit
dart pub outdated
dart pub deps

# 7. Find TODOs and FIXMEs
grep -r "TODO\|FIXME" lib/ --include="*.dart" -n
```

---

## ✅ DAILY AUDIT WORKFLOW

### Day 1: Performance Hotspots
```
Morning:
[ ] Run performance profiler on home page
[ ] Identify frame drops during scrolling
[ ] Profile memory during video playback

Afternoon:
[ ] Audit top 5 most used widgets
[ ] Check for missing const
[ ] Find widget-returning functions

End of Day:
[ ] Document top 10 critical issues
[ ] Create fix priority list
```

### Day 2: List Performance
```
Morning:
[ ] Audit all ListView usage
[ ] Add RepaintBoundary where missing
[ ] Check image cache configuration

Afternoon:
[ ] Profile episode list scrolling
[ ] Optimize movie card rendering
[ ] Test on low-end device

End of Day:
[ ] Measure FPS improvements
[ ] Document changes
```

### Day 3: Architecture Review
```
Morning:
[ ] Run dependency rule checker
[ ] Verify Clean Architecture layers
[ ] Check for circular dependencies

Afternoon:
[ ] Review BLoC implementations
[ ] Check use case patterns
[ ] Audit repository implementations

End of Day:
[ ] Create architecture compliance report
[ ] List violations and fixes
```

### Day 4: Build Size
```
Morning:
[ ] Analyze APK contents
[ ] Identify large assets
[ ] Check for unused dependencies

Afternoon:
[ ] Optimize images
[ ] Configure ProGuard/R8
[ ] Enable code splitting

End of Day:
[ ] Measure size reduction
[ ] Document optimizations
```

### Day 5: Polish & Report
```
Morning:
[ ] Re-run all performance tests
[ ] Verify all fixes
[ ] Final profiling

Afternoon:
[ ] Complete audit report
[ ] Create fix roadmap
[ ] Present findings

End of Day:
[ ] Submit audit report
[ ] Create GitHub issues for fixes
```

---

## 🎯 SUCCESS METRICS

### Performance Targets

| Metric | Before | Target | Success |
|--------|--------|--------|---------|
| Cold Start | ? ms | < 2000ms | ⏳ |
| Hot Reload | ? ms | < 500ms | ⏳ |
| Home Load | ? ms | < 1000ms | ⏳ |
| List Scroll FPS | ? | 60 FPS | ⏳ |
| Memory (Idle) | ? MB | < 100MB | ⏳ |
| Memory (Active) | ? MB | < 200MB | ⏳ |
| APK Size | ? MB | < 25MB | ⏳ |

### Code Quality Targets

| Metric | Target |
|--------|--------|
| Test Coverage | > 70% |
| Cyclomatic Complexity | < 10 per method |
| Lines per File | < 400 |
| Widget Tree Depth | < 5 levels |
| Const Usage | > 80% of static widgets |

---

**Last Updated:** February 7, 2026
**Next Review:** After implementing fixes
**Owner:** Development Team
