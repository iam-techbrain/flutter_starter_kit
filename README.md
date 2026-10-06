# DummyHub Flutter Learning Application

A clean, modular cross-platform learning application built with Flutter and Dart consuming public APIs from DummyJSON.

## Description

DummyHub is a cross-platform mobile and desktop application built with Flutter to demonstrate core architectural patterns in mobile software development. It illustrates clean separation of concerns using strongly-typed Dart models, a centralized service layer (`api_service.dart`, `auth_service.dart`), asynchronous networking via `FutureBuilder` and `async/await`, and modular UI components. The application features a 3-screen workflow: an asynchronous Login Screen with authentication token persistence, a Dashboard Products Catalog Screen rendering reusable `ProductCard` child widgets, and an authenticated User Profile Screen, all wrapped within a shared `PageWrapper` layout widget.

## Getting Started

### Dependencies

* Operating System: Windows 10/11, macOS, or Linux
* Flutter SDK: Flutter 3.x (with Dart SDK ^3.0.0 or higher)
* Development Environment: Android Studio, VS Code, or IntelliJ with Flutter & Dart extensions
* Emulators / Devices:
  * Android Emulator / Physical Device (API level 21+)
  * iOS Simulator / Device (macOS required)
  * Chrome or Edge (for Flutter Web)
  * Windows Desktop build tools (Visual Studio 2022 C++ workload for native desktop)
* Core Packages (`pubspec.yaml`):
  * `flutter` (Flutter SDK)
  * `http` (^1.6.0) - Composable HTTP client for making async API calls

### Installing

* Clone or navigate to the project directory:
  ```bash
  cd "e:\Starter Kit\flutter_starter_kit"
  ```
* Fetch and install all package dependencies:
  ```bash
  flutter pub get
  ```
* Verify your Flutter development environment:
  ```bash
  flutter doctor
  ```

### Executing program

* Running on a connected device, emulator, or Chrome (Web):
  ```bash
  flutter run
  ```
* Running specifically on Chrome (Web):
  ```bash
  flutter run -d chrome
  ```
* Running on Windows Desktop:
  ```bash
  flutter run -d windows
  ```
* Building Release APK for Android:
  ```bash
  flutter build apk --release
  ```
* Building Release Web bundle:
  ```bash
  flutter build web --release
  ```
* Application Navigation & Screens:
  * `LoginScreen` (`lib/screens/login_screen.dart`) — Authenticates via `POST https://dummyjson.com/auth/login`
  * `DashboardScreen` (`lib/screens/dashboard_screen.dart`) — Fetches catalog via `GET https://dummyjson.com/products`
  * `ProfileScreen` (`lib/screens/profile_screen.dart`) — Displays user details via `GET https://dummyjson.com/users`
* Testing Authentication with Demo Credentials:
  * Use the predefined DummyJSON accounts on the login screen:
    * Username: `emilys`
    * Password: `emilyspass`
    * Alternative: `michaelw` / `michaelwpass`

## Help

* Flutter SDK not recognized in terminal:
  * Add the path to your Flutter SDK `bin` directory (e.g., `C:\flutter\bin`) to your system's `PATH` environment variable and restart your terminal.
* Gradle or Android build errors:
  * Ensure Android SDK command-line tools and JDK 17 are properly configured in Android Studio. Run:
    ```bash
    flutter clean
    flutter pub get
    ```
* Network or Handshake Exceptions during API calls:
  * Check your internet connection. On Android, verify that `android.permission.INTERNET` is declared inside `android/app/src/main/AndroidManifest.xml`.
* Hot Reload & Restart shortcuts:
  * Press `r` in terminal for Hot Reload.
  * Press `R` in terminal for Hot Restart.

## Authors

* Development Team
* Project Contributor: [@Developer](https://github.com/)

## Version History

* 0.2
  * Implemented `PageWrapper` widget pattern for shared screen layout
  * Integrated `ApiService` and `AuthService` with DummyJSON public REST endpoints
  * Added responsive `ProductCard` and `HeroSection` child widgets
  * Implemented strongly-typed Dart data models (`Product`, `AuthUser`, `UserProfile`)
* 0.1
  * Initial Release with baseline Flutter project configuration and routing

## License

This project is licensed under the ISC License - see the LICENSE file for details.

## Acknowledgments

* [DummyJSON](https://dummyjson.com) - Public REST API for realistic mock data and authentication services
* [Flutter Documentation](https://docs.flutter.dev) - Official Flutter and Dart developer documentation
* [PurpleBooth / README-Template](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2) - Standard project documentation structure inspiration
* [awesome-readme](https://github.com/matiassingers/awesome-readme) - Documentation best practices
