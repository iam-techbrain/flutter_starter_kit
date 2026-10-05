# Flutter Starter Kit - Modular DummyJSON Application

A modular, clean-architecture Flutter learning application built with real public APIs from DummyJSON. This application demonstrates component reusability, parent-child props passing, clean asynchronous data fetching, and state management using Flutter best practices.

---

## Direct Public API Endpoints Used

- Authentication: `POST https://dummyjson.com/auth/login` (Body: username, password)
- Products Catalog: `GET https://dummyjson.com/products`
- Users Directory: `GET https://dummyjson.com/users`

---

## Default Demo Credentials

For testing the authentication flow, you can use the built-in Autofill button or the following DummyJSON credentials:

- Username: `emilys`
- Password: `emilyspass`

---

## Architecture and Project Structure

```
flutter_starter_kit/
├── lib/
│   ├── models/
│   │   ├── auth_user.dart       # Model for authenticated user and JWT token handling
│   │   ├── product.dart         # Strongly typed model for product items
│   │   └── user_profile.dart    # Strongly typed model for users directory
│   ├── services/
│   │   ├── api_service.dart     # Asynchronous HTTP network client
│   │   └── auth_service.dart    # Singleton authentication state manager (ValueNotifier)
│   ├── widgets/
│   │   ├── page_wrapper.dart    # Generic layout wrapper using child and children props
│   │   ├── app_header.dart      # Reusable header with dynamic props and avatar integration
│   │   ├── app_footer.dart      # Reusable navigation footer component
│   │   ├── hero_section.dart    # Modular promotional banner component
│   │   └── product_card.dart    # Modular product card passing props and callbacks
│   ├── screens/
│   │   ├── login_screen.dart     # Page 1: Login with validation and async POST request
│   │   ├── dashboard_screen.dart # Page 2: Products listing with search and modal preview
│   │   └── profile_screen.dart   # Page 3: Active user profile and community directory
│   └── main.dart                # Material 3 setup, theme configuration, and routing
└── test/
    └── widget_test.dart         # Automated widget smoke test
```

---

## Core Learning Objectives Implemented

### 1. Modular Components
- `PageWrapper`: Reusable container supporting single `child` or multiple `children` parameters. It provides uniform screen padding, safe-area wrapping, background colors, and pull-to-refresh integration.
- `AppHeader`: Modular top app bar accepting props such as `title`, `subtitle`, back button control, and reactive user avatar integration.
- `HeroSection`: Reusable promotional banner accepting `title`, `subtitle`, `badgeText`, and button action callbacks.
- `ProductCard`: Reusable card component rendering thumbnail, category, discount percentage, rating, stock status, price, and event handlers.
- `AppFooter`: Navigation bar supporting screen switching and status display.

### 2. Parent-Child Communication and Props
- Data flows strictly from parent pages down to child widgets through constructor arguments (props pattern).
- Child components do not perform arbitrary network mutations; instead, they trigger callback events (`onTap`, `onAddToCart`, `onButtonPressed`) handled by the parent screen.

### 3. Asynchronous Operations and UI Resilience
- Network operations in `ApiService` utilize modern `async/await` syntax.
- Four distinct UI states are managed cleanly without freezing the user interface:
  - Loading State: Progress indicators while network requests are in flight.
  - Error State: Contextual error messages with retry buttons.
  - Empty State: Informative fallback views when search queries yield zero results.
  - Success State: Rendered responsive grids and lists with pull-to-refresh.
- All asynchronous methods contain `mounted` safety guards to avoid memory leaks on disposed widgets.

### 4. Application Pages

1. Page 1: Login Page (`LoginScreen`)
   - Validates input fields and executes asynchronous POST request to DummyJSON.
   - Saves authenticated user data and access token into `AuthService`.
   - Navigates seamlessly to the dashboard upon successful verification.

2. Page 2: Dashboard and Products List (`DashboardScreen`)
   - Fetches product data asynchronously from DummyJSON.
   - Includes real-time search filtering across title, brand, and category.
   - Renders a responsive grid of `ProductCard` components.
   - Opens a detailed product bottom sheet on card tap.

3. Page 3: User Profile and Community Directory (`ProfileScreen`)
   - Displays authenticated session data, role, and identifiers.
   - Asynchronously queries the DummyJSON users endpoint to display community members.
   - Provides individual user detail inspection dialogs and a clean sign-out workflow.

---

## Getting Started

### Prerequisites

- Flutter SDK (3.35.0 or newer recommended)
- Dart SDK (3.9.0 or newer)
- Target platform setup: Google Chrome, Windows Desktop, or an Android/iOS emulator

### Installation and Dependencies

Run the following command from the root directory to fetch project dependencies:

```bash
flutter pub get
```

### Running the Application

Execute any of the following commands based on your preferred target device:

```bash
# Launch on Google Chrome
flutter run -d chrome

# Launch on Windows Desktop
flutter run -d windows

# Launch on default connected emulator or device
flutter run
```

---

## Testing and Code Verification

Static analysis and automated tests can be verified using:

```bash
# Run static code analysis
flutter analyze

# Run automated widget smoke tests
flutter test
```
