# Connective - Flutter API App

A clean, modern Flutter mobile application that fetches and displays data from a public API. Features smooth animations, beautiful dark/light themes, offline caching, and a robust clean architecture/MVVM setup.

![App Demo Placeholder](https://picsum.photos/seed/flutter/800/200)

## Features Included
- **MVVM / Clean Architecture:** Strong separation of logic spanning Models, Providers, Services, and UI layers.
- **Provider State Management:** Highly reactive and responsive state management out of the box. 
- **Offline Caching:** Posts are locally cached utilizing `shared_preferences`. App maintains UI state even when navigating offline.
- **Micro-Interactions & Animations:** Uses `Hero` transition to transfer cover images, and bounded size/scale animation for searching and Item Add/Remove functionalities. 
- **Shimmer Loadings:** Elegant dynamic gradients act as placeholders before the network response loads.
- **Light & Dark Mode:** Dynamic, fully detailed theme swap based on context choices persisting locally.
- **Spoofed Custom Networking:** Bypasses basic Cloudflare blocks using native Http headers targeting the typicode JSON API.
- **Unit Testing:** Basic integrated API Mock test.

## API Used
The app strictly fetches content utilizing JSONPlaceholder's Mock Rest API.
- **Endpoint:** `GET https://jsonplaceholder.typicode.com/posts`
- **Fields displayed:** Item ID, Placeholder Image, Title, and Description (Body).

## Architecture Explanation

This application loosely follows the **MVVM (Model-View-ViewModel)** architectural pattern adjusted heavily for Flutter's `Provider`:

1. **Models (`lib/models`)**: Contains simple data transfer objects converting raw JSON to structured typed Dart objects (e.g. `Post` model).
2. **Services (`lib/services`)**: Completely isolated infrastructure layers responsible strictly for raw data operations.
   - `ApiService`: Dispatches network commands (GET) parsing raw bytes/strings.
   - `CacheService`: Directly interacts with `SharedPreferences` to manage device disk payloads. 
3. **Controllers / ViewModels (`lib/controllers`)**: Defines `ChangeNotifier` state files spanning both the `ThemeProvider` and the heavier `PostProvider`. These interact with Services, hold local data structures (like maps, filtered lists), and invoke `notifyListeners()` when data transitions happen to paint the View correctly. 
4. **Views (`lib/screens` & `lib/widgets`)**: Passive UI trees listening purely to the `Controllers`. Renders reactive styling (Card themes) and triggers controller methods (e.g., `themeProvider.toggleTheme()` and `provider.search(query)`). 

## Setup Instructions

1. **Prerequisites**
   - Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) successfully installed and active on your system.
   - Verify dart variables are set through `flutter doctor`.

2. **Clone / Enter the Project**
   If cloned via Git, swap to your repository path. 

3. **Install Dependencies**
   Install the necessary yaml packages through the flutter CLI:
   ```bash
   flutter pub get
   ```

4. **Run Unit Tests (Optional)**
   You may want to verify that the Mock API Tests natively pass first:
   ```bash
   flutter test test/api_service_test.dart
   ```

5. **Run the Application**
   Launch your Android Emulator, iOS Simulator, or Desktop instance and mount the build:
   ```bash
   flutter run
   ```
