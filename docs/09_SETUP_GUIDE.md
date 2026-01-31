# Environment Setup Guide

Hướng dẫn cài đặt môi trường phát triển cho Lilinet App.

## 1. Prerequisites

### 1.1 Required Software
- **Flutter SDK** >= 3.8.0
- **Dart SDK** >= 3.8.0
- **Android Studio** (cho Android development)
- **Xcode** (cho iOS development, macOS only)
- **VS Code** (recommended IDE)
- **Git**
- **Docker** (cho Consumet API)

### 1.2 VS Code Extensions
```
- Flutter
- Dart
- Bloc
- Error Lens
- GitLens
```

## 2. Project Setup

### 2.1 Clone Repository
```bash
git clone <repository-url>
cd lilinet_app
```

### 2.2 Install Dependencies
```bash
flutter pub get
```

### 2.3 Generate Code
```bash
dart run build_runner build --delete-conflicting-outputs
```

## 3. Environment Configuration

### 3.1 Create .env File
```bash
cp .env.example .env
```

### 3.2 Configure .env
```env
# Consumet API (self-hosted)
API_BASE_URL=http://localhost:7030

# Supabase
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key

# Optional: TMDB API (for images)
TMDB_API_KEY=your-tmdb-key
```

## 4. Supabase Setup

### 4.1 Create Project
1. Go to [supabase.com](https://supabase.com)
2. Create new project
3. Copy URL and anon key to `.env`

### 4.2 Run Database Migrations
1. Open Supabase Dashboard > SQL Editor
2. Run scripts from `docs/08_SUPABASE_SCHEMA.md` in order:
   - Create tables
   - Enable RLS
   - Create policies
   - Create triggers

### 4.3 Configure Authentication
1. Go to Authentication > Settings
2. Enable Email provider
3. Configure email templates (optional)

## 5. Consumet API Setup

### 5.1 Option A: Docker (Recommended)
```bash
docker pull riimuru/consumet-api
docker run -d -p 7030:3000 --name consumet-api riimuru/consumet-api
```

### 5.2 Option B: From Source
```bash
cd ../api.consumet.org
npm install
npm start
```

### 5.3 Verify API
```bash
curl http://localhost:7030/meta/tmdb/trending
```

## 6. Run the App

### 6.1 Android Emulator
```bash
# Start emulator
flutter emulators --launch <emulator_id>

# Run app
flutter run
```

**Note:** Android emulator uses `10.0.2.2` instead of `localhost`.
The app handles this automatically in `api_constants.dart`.

### 6.2 iOS Simulator (macOS only)
```bash
open -a Simulator
flutter run
```

### 6.3 Physical Device
```bash
flutter run -d <device_id>

# List devices
flutter devices
```

### 6.4 Web (for testing)
```bash
flutter run -d chrome
```

## 7. Development Workflow

### 7.1 Code Generation
After modifying `@freezed` or `@injectable` classes:
```bash
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild)
dart run build_runner watch --delete-conflicting-outputs
```

### 7.2 Run Tests
```bash
# All tests
flutter test

# Specific test file
flutter test test/path/to/test.dart

# With coverage
flutter test --coverage
```

### 7.3 Analyze Code
```bash
flutter analyze
```

### 7.4 Format Code
```bash
dart format lib/
```

## 8. Project Structure

```
lilinet_app/
├── lib/
│   ├── main.dart              # Entry point
│   ├── app.dart               # App widget
│   ├── injection_container.dart # DI setup
│   ├── core/                  # Shared code
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── extensions/
│   │   ├── network/
│   │   ├── theme/
│   │   └── widgets/
│   ├── features/              # Feature modules
│   │   ├── auth/
│   │   ├── movies/
│   │   ├── video_player/
│   │   ├── comments/
│   │   ├── favorites/
│   │   ├── history/
│   │   ├── explore/
│   │   └── settings/
│   └── routes/                # Navigation
├── test/                      # Test files
├── assets/                    # Images, icons
├── docs/                      # Documentation
├── android/                   # Android config
├── ios/                       # iOS config
└── pubspec.yaml               # Dependencies
```

## 9. Common Issues

### 9.1 Consumet API Connection Failed
```
Solution:
- Ensure Docker is running
- Check port 7030 is not in use
- Android emulator: Uses 10.0.2.2 (handled automatically)
```

### 9.2 Supabase Auth Not Working
```
Solution:
- Check SUPABASE_URL and SUPABASE_ANON_KEY in .env
- Ensure email provider is enabled in Supabase dashboard
- Check RLS policies
```

### 9.3 Build Runner Fails
```
Solution:
- Delete .dart_tool/build folder
- Run: flutter clean && flutter pub get
- Run: dart run build_runner build --delete-conflicting-outputs
```

### 9.4 Video Player Issues
```
Solution:
- Android: Ensure media_kit_libs_android_video is in pubspec.yaml
- iOS: Add media_kit_libs_ios_video
- Linux: Install required system libraries
```

## 10. IDE Configuration

### 10.1 VS Code launch.json
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "lilinet_app",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart"
    },
    {
      "name": "lilinet_app (profile)",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "flutterMode": "profile"
    }
  ]
}
```

### 10.2 VS Code settings.json
```json
{
  "dart.flutterSdkPath": "/path/to/flutter",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  }
}
```

## 11. Useful Commands

```bash
# Flutter doctor
flutter doctor -v

# Upgrade Flutter
flutter upgrade

# Clean build
flutter clean && flutter pub get

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Analyze
flutter analyze

# Run with verbose
flutter run -v
```

---

*Document Version: 1.0*
*Last Updated: January 2026*
