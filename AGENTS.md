# AGENTS.md

This document provides essential information for AI coding agents working with this Flutter/Dart codebase.

## Project Overview

This is a movie streaming application called "Lilinet" built with Flutter, following Clean Architecture principles. It supports mobile (Android, iOS) and desktop platforms (Linux, macOS, Windows).

### Key Technologies Used

- **Framework**: Flutter 3.8+
- **Language**: Dart 3.0+
- **State Management**: flutter_bloc + freezed
- **Dependency Injection**: get_it + injectable
- **Networking**: dio + retrofit
- **Local Storage**: hive_ce
- **Backend**: Supabase (Auth, Database)
- **Video Player**: media_kit (mpv)
- **Navigation**: go_router
- **Error Handling**: dartz (Either pattern)
- **Testing**: flutter_test, bloc_test, mocktail

### Project Structure

```
lib/
├── core/                   # Shared logic (Network, Errors, Constants, DI, Theme)
├── features/               # Feature modules
│   └── [feature_name]/     # e.g., movies, favorites, settings
│       ├── domain/         # [INNER LAYER] - Pure Dart
│       │   ├── entities/   # POJO classes
│       │   ├── repositories/# Abstract Interfaces (IRepository)
│       │   └── usecases/   # Single responsibility classes (callable)
│       ├── data/           # [OUTER LAYER]
│       │   ├── models/     # DTOs (fromJson/toJson) -> Extends/Mappers to Entity
│       │   ├── datasources/# Remote (Retrofit/Dio) & Local (Hive/Prefs)
│       │   └── repositories/# Implementation (RepositoryImpl)
│       └── presentation/   # [UI LAYER]
│           ├── bloc/       # BLoC/Cubit implementation
│           ├── pages/      # Scaffolds
│           └── widgets/    # Components
└── main.dart, app.dart, injection_container.dart
```

## Build Commands

### Basic Development Commands

```bash
# Install dependencies
flutter pub get

# Generate code (Freezed, JSON serialization, Retrofit, Injectable, Hive adapters)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for code generation changes (recommended during development)
flutter pub run build_runner watch --delete-conflicting-outputs

# Run app
flutter run

# Run app on specific device/platform
flutter run -d linux
flutter run -d chrome
flutter run -d emulator-5554
```

### Production Build Commands

```bash
# Build for Android
flutter build apk --release

# Build for iOS (only on macOS)
flutter build ios --release

# Build for Linux
flutter build linux --release

# Build for macOS
flutter build macos --release

# Build for Windows
flutter build windows --release

# Build for Web
flutter build web --release
```

## Testing Commands

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/auth/data/repositories/auth_repository_impl_test.dart

# Run tests matching a pattern
flutter test --plain-name "should load movies"

# Run with coverage
flutter test --coverage

# Run with verbose output
flutter test -v
```

### Writing Tests

Tests follow standard Dart testing patterns:

1. **Unit Tests**: For pure dart logic (usecases, repositories, etc.)
2. **Widget Tests**: For UI components
3. **Bloc Tests**: For state management components

Use `mocktail` for mocking dependencies and `bloc_test` for testing BLoCs/Cubits.

## Linting/Formatting Commands

```bash
# Format code
dart format .

# Analyze code (linting)
flutter analyze

# Fix formatting issues automatically
dart format --fix .

# Custom analysis (based on analysis_options.yaml)
flutter analyze --fatal-infos
```

## Code Style Guidelines

### Language-Specific Conventions

#### Dart Specifics

1. **Imports**:
   - Use relative imports for files in the same package: `import 'widgets/movie_card.dart';`
   - Use package imports for files from other packages: `import 'package:lilinet_app/core/utils/logger.dart';`
   - Group imports in order:
     1. Dart SDK imports
     2. Flutter imports
     3. Package imports
     4. Relative imports
   - Within each group, order alphabetically

2. **Naming Conventions**:
   - Classes: PascalCase (`MovieRepository`)
   - Variables/functions: camelCase (`getTrendingMovies`)
   - Constants: SCREAMING_SNAKE_CASE (`const MAX_RETRY_ATTEMPTS = 3;`)
   - Files: snake_case (`movie_repository_impl.dart`)
   - Test files: append `_test` (`movie_repository_impl_test.dart`)

3. **Formatting**:
   - Line length: 80 characters maximum (soft limit)
   - Indentation: 2 spaces (no tabs)
   - Trailing commas encouraged for cleaner diffs
   - Prefer trailing commas in parameter lists and collection literals

#### Error Handling

1. Use Either pattern (via `dartz` library) for functional error handling
2. Exceptions should be wrapped in custom Failure classes
3. Network errors should return either ServerFailure or NetworkFailure
4. Handle all exceptions appropriately in use cases and repositories

#### Testing Patterns

1. **Structure**: Arrange-Act-Assert pattern
2. **Mocks**: Use `mocktail` for creating mocks
3. **Verifications**: Use `verify()` and `verifyNever()` to ensure correct interactions
4. **Bloc Tests**: Use `blocTest` for testing BLoC state transitions
5. **Widget Tests**: Test user interactions and expected UI outcomes

### Architecture-Specific Guidelines

#### Clean Architecture Enforcement

1. **Layer Separation**:
   - Presentation layer can only depend on Domain layer
   - Domain layer should contain no framework-specific code
   - Data layer depends on Domain layer abstractions

2. **Dependencies Flow**:
   - Presentation → Domain ← Data
   - Never: Presentation → Data directly

3. **Entity vs Model**:
   - Entities live in domain/entities (pure Dart classes)
   - Models live in data/models (with JSON serialization)

#### Feature-First Organization

Each feature module follows the exact structure:
```
feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

#### State Management with BLoC

1. Name blocs as `FeatureBloc` (e.g., `MovieBloc`)
2. Events as `FeatureEvent` (e.g., `MovieLoadEvent`)
3. States as `FeatureState` (e.g., `MovieState`)
4. Use sealed/unsealed state patterns:
   - Initial
   - Loading
   - Loaded(data)
   - Error(message)
5. Never call repositories directly from UI - always use BLoC

#### Dependency Injection

1. Use `get_it` for service locator
2. Use `injectable` annotations:
   - `@lazySingleton` for shared instances
   - `@singleton` for eager initialization
   - `@injectable` for regular injectable classes

#### Network Layer

1. Use `dio` with `retrofit` for API calls
2. Models should be annotated with `@freezed` and `@JsonSerializable`
3. All API responses must be wrapped in Either pattern
4. Always handle network errors appropriately using interceptors

### UI/UX Guidelines

1. **Material Design 3**: Always follow M3 guidelines
2. **Responsive Design**: Support multiple screen sizes
3. **Accessibility**: Maintain 4.5:1 contrast ratio, support screen readers
4. **Theming**: Use centralized theme definitions
5. **Performance**: Use const constructors, ListView.builder for long lists

## Code Generation Requirements

This project heavily relies on code generation. After making changes to annotated files, always run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Files that require code generation:
- `@freezed` annotations
- `@JsonSerializable` annotations
- `@injectable` annotations
- `@RestApi` annotations (Retrofit)
- Hive adapters

## Git Workflow

1. Branch naming: `feature/description`, `fix/issue-description`, `chore/task-description`
2. Commit messages: Follow conventional commits format
3. Pull requests: Required for merging to main branch
4. Code reviews: All code must be reviewed before merging

## Debugging Tips

1. Enable detailed logging: Set environment variables for verbose output
2. Use DevTools: `dart devtools` for profiling and debugging
3. Widget inspector: Use Flutter Inspector in IDE for visual debugging
4. Network logging: PrettyDioLogger is already configured for request/response logging