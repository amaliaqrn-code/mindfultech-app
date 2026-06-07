# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MindfulTech is a Flutter productivity and daily energy management app that helps users organize tasks based on their energy levels (low/medium/high - represented as green/blue/purple themes).

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run a specific test
flutter test test/widget_test.dart

# Run all tests
flutter test

# Run with code generation (after modifying .dart files with freezed/json_serializable)
dart run build_runner build --delete-conflicting-outputs

# Analyze code
flutter analyze

# Build for Android
flutter build apk --debug

# Build for iOS
flutter build ios --simulator --no-codesign
```

## Architecture

### State Management
The app uses both **BLoC pattern** (flutter_bloc) and **Cubit pattern**:
- `lib/presentation/*/bloc/` - Full BLoC pattern with Events and States
- `lib/presentation/*/cubit/` - Simplified Cubit pattern (no events, just methods)
- Some blocs use **freezed** for immutable state classes (see `.freezed.dart` files)

### Directory Structure
```
lib/
├── main.dart                    # App entry point, dependency injection
├── core/
│   ├── constants/               # Colors, strings, styles
│   ├── database/                # SQLite helper (DatabaseHelper singleton)
│   ├── network/                 # Dio client, API constants
│   ├── routes/                  # AppRouter (Navigator 1.0), AppRoutes constants
│   └── utils/                   # Helpers, responsive utilities
├── data/
│   ├── datasources/             # Local (GetStorage) and Remote (Dio) data sources
│   ├── models/                  # API request/response models
│   └── repositories/            # AuthRepository (coordinates local/remote)
├── models/                      # Shared models (TaskModel)
├── presentation/
│   ├── auth/                    # Login, register, forgot password (BLoC pattern)
│   ├── choose_energy/           # Energy level selection screen
│   ├── homepage/                # Main dashboard (Cubit pattern)
│   ├── journey/                 # Progress/journey map feature (Cubit)
│   ├── mindy_bantu_aku/         # Task recommendation flow (blue/green/purple themes)
│   ├── onboarding/              # First-time user onboarding
│   ├── splash/                  # Splash screen
│   ├── streak/                  # Daily streak tracking
│   ├── timer/                   # Focus timer with Pomodoro-style countdown (Cubit)
│   ├── tutorial/                # In-app tutorials
│   └── widgets/                 # Shared UI components (CustomButton, CustomTextField)
└── blocs/
    └── task/                    # Task management BLoC (CRUD operations)
```

### Key Patterns

**Routing**: Uses Navigator 1.0 with centralized `AppRouter.generateRoute()`. Routes are defined as constants in `AppRoutes`. Navigation via `Navigator.pushNamed(context, AppRoutes.routeName)`.

**Data Flow**: 
1. Repository pattern abstracts data sources
2. BLoC/Cubit consumes repository and exposes state
3. UI rebuilds via `BlocBuilder`/`CubitBuilder`

**Theme System**: The `mindy_bantu_aku/` feature has separate theme files for each energy level (blue_theme.dart, green_theme.dart, purple_theme.dart).

### Database
- SQLite via `sqflite` package
- Single `DatabaseHelper` singleton manages all local persistence
- Currently stores tasks only (`tasks` table with columns: id, namaTugas, kategori, energi, estimasiWaktu, prioritas, createdAt)

### API Client
- `DioClient` singleton with interceptors for auth token injection
- Token stored in GetStorage and added to `Authorization: Bearer <token>` header

### Models
- `TaskModel` - main task model with EnergyLevel and TaskCategory enums
- Enums have extensions for display names and icon names

## Code Generation

The project uses freezed for immutable state classes. Generated files:
- `lib/presentation/auth/bloc/*/*.freezed.dart`
- `lib/presentation/auth/bloc/*/*.g.dart` (for json_serializable)

After modifying source models, run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Asset Management

Assets are declared in `pubspec.yaml` under `flutter.assets`. Key directories:
- `assets/images/` - PNG images
- `assets/icon/` - Icons including SVG files for energy levels