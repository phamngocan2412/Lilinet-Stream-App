# Lilinet

A modern, cross-platform movie streaming application built with Flutter, following Clean Architecture principles.

[![Flutter](https://img.shields.io/badge/Flutter-3.8+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-Educational-green)](LICENSE)

## Features

| Feature | Description |
|---------|-------------|
| **Multi-Source Streaming** | Stream movies and TV shows from various providers (Goku, FlixHQ, etc.) |
| **Cross-Platform** | Runs on Android, iOS, Linux, MacOS, and Windows |
| **Dark Mode** | Modern dark theme with Material 3 design |
| **Miniplayer** | Watch while browsing with a persistent, draggable miniplayer |
| **Favorites** | Save your favorite movies and TV shows |
| **Watch History** | Track your viewing progress |
| **Comments** | Community discussion for each movie |
| **Smart Search** | Real-time search with debouncing |
| **Episode Navigation** | Easy navigation between seasons and episodes |

## Architecture

This project follows **Feature-First Clean Architecture** pattern:

```
lib/
├── core/                   # Shared utilities (Network, Errors, DI, Theme)
├── features/
│   ├── auth/               # Authentication (Supabase)
│   ├── movies/             # Movie listing & details
│   ├── explore/            # Search & discovery
│   ├── favorites/          # Favorites management
│   ├── history/            # Watch history tracking
│   ├── comments/           # User comments
│   ├── video_player/       # Video playback (MediaKit)
│   └── settings/           # App settings
└── main.dart
```

Each feature follows the layered structure:

```
feature/
├── data/
│   ├── datasources/        # Remote (API) & Local (Hive)
│   ├── models/             # DTOs with JSON serialization
│   └── repositories/       # Repository implementations
├── domain/
│   ├── entities/           # Business entities
│   ├── repositories/       # Abstract interfaces
│   └── usecases/           # Business logic
└── presentation/
    ├── bloc/               # BLoC state management
    ├── pages/              # Screen widgets
    └── widgets/            # Reusable components
```

## Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.8+ |
| **State Management** | flutter_bloc + freezed |
| **Dependency Injection** | get_it + injectable |
| **Networking** | dio + retrofit |
| **Local Storage** | hive_ce |
| **Backend** | Supabase (Auth, Database) |
| **Video Player** | media_kit (mpv) |
| **Navigation** | go_router |
| **Error Handling** | dartz (Either pattern) |

## Getting Started

### Prerequisites

- Flutter SDK >= 3.8.0
- Dart SDK >= 3.0.0
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/phamngocan2412/Lilinet-novel-app.git
   cd lilinet_app
   ```

2. **Configure environment**

   Create a `.env` file in the project root:
   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   # Mobile (Android/iOS)
   flutter run

   # Desktop
   flutter run -d linux    # Linux
   flutter run -d macos    # MacOS
   flutter run -d windows  # Windows
   ```

## Build

### Android

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Linux

```bash
flutter build linux --release
```

Output: `build/linux/x64/release/bundle/`

### Windows

```bash
flutter build windows --release
```

Output: `build/windows/x64/runner/Release/`

## Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/auth/auth_bloc_test.dart

# Run with coverage
flutter test --coverage
```

## Project Structure

```
lilinet_app/
├── lib/
│   ├── core/
│   │   ├── errors/         # Failure classes
│   │   ├── network/        # Dio client configuration
│   │   ├── theme/          # App theming
│   │   └── widgets/        # Shared widgets
│   ├── features/           # Feature modules
│   └── injection_container.dart
├── test/                   # Unit & widget tests
├── assets/
│   ├── images/
│   └── icons/
├── .env                    # Environment variables
└── pubspec.yaml
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `refactor:` Code refactoring
- `test:` Adding tests
- `chore:` Maintenance tasks

## License

This project is for educational purposes only.
