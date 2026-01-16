# Lilinet

A modern, cross-platform movie streaming application built with Flutter, powered by the Consumet API.

## 🚀 Features

- **Multi-Source Streaming**: Stream movies and TV shows from various providers (Goku, FlixHQ, etc.).
- **Cross-Platform**: Runs on Android, iOS, Linux, MacOS, Windows, and Web.
- **Modern UI/UX**: 
  - Dark mode support.
  - Smooth animations and transitions.
  - Responsive layout for mobile and desktop.
- **Miniplayer**: Watch while you browse with a persistent, draggable miniplayer (similar to YouTube).
- **Favorites & History**: Local storage support to save your favorite content and track watch history.
- **Smart Search**: Real-time search functionality.
- **Episode Management**: Easy navigation between seasons and episodes.

## 🛠 Tech Stack

### Core
- **Framework**: [Flutter](https://flutter.dev/) (SDK >=3.8.0)
- **Language**: Dart

### Architecture & State Management
- **Architecture**: Clean Architecture (Data, Domain, Presentation layers)
- **State Management**: [Flutter Bloc](https://pub.dev/packages/flutter_bloc) (Cubit/Bloc)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it) & [Injectable](https://pub.dev/packages/injectable)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)

### Networking & Data
- **HTTP Client**: [Dio](https://pub.dev/packages/dio) with [Retrofit](https://pub.dev/packages/retrofit)
- **Local Storage**: [Hive CE](https://pub.dev/packages/hive_ce) (Community Edition)
- **Backend/Auth**: [Supabase](https://supabase.com/)

### Media & Playback
- **Video Player**: [MediaKit](https://pub.dev/packages/media_kit) (powered by mpv)
- **Wakelock**: [Wakelock Plus](https://pub.dev/packages/wakelock_plus)

## 📦 Installation & Setup

### Prerequisites
- Flutter SDK installed and configured.
- Git installed.

### 1. Clone the Repository
```bash
git clone https://github.com/phamngocan2412/Lilinet-novel-app.git
cd lilinet_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Code
Run the build runner to generate code for JSON serialization, dependency injection, and Retrofit clients:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the App
**Android/iOS:**
```bash
flutter run
```

**Linux/MacOS/Windows:**
```bash
flutter run -d linux  # or macos/windows
```

## 🏗 Build release apps

### Android (APK)
```bash
flutter build apk --release
```

### Linux
```bash
flutter build linux --release
```

## 🤝 Contribution
Contributions are welcome! Please fork the repository and submit a pull request.

## 📄 License
This project is for educational purposes.
