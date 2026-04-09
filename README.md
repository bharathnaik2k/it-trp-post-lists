# IT TRP - Post Lists

A clean, modern Flutter mobile application that fetches and displays data from a public API. Features smooth animations, beautiful dark/light themes, offline caching, and clean architecture

## Features Included
- **Clean Architecture:** Strong separation of logic spanning Models, Providers, Services, and UI layers.
- **Provider State Management:** Highly reactive and responsive state management out of the box. 
- **Offline Caching:** Posts are locally cached utilizing `shared_preferences`. App maintains UI state even when navigating offline.
- **Micro-Interactions & Animations:** Uses `Hero` transition to transfer cover images, and bounded size/scale animation for searching and Item Add/Remove functionalities. 
- **Shimmer Loadings:** Elegant dynamic gradients act as placeholders before the network response loads.
- **Light & Dark Mode:** Dynamic, fully detailed theme swap based on context choices persisting locally.
- **Spoofed Custom Networking:** Bypasses basic Cloudflare blocks using native Http headers targeting the typicode JSON API.

## API Used
The app strictly fetches content utilizing JSONPlaceholder's Mock Rest API.
- **Endpoint:** `GET https://jsonplaceholder.typicode.com/posts`
- **Fields displayed:** Item ID, Placeholder Image, Title, and Description (Body).
- **Images url:** `GET https://picsum.photos/id/<Use Index ID>/200/300`

## Packages Used
- `http`: Handles all networking operations.
- `shared_preferences`: Handles local caching.
- `provider`: Manages state and communication between UI and Controllers.  
- `device_preview`: device previews for iOS and Android(Only For Development Use - remove in production).
- `flutter_dotenv`: Loads environment variables from `.env` file.

## Architecture Explanation
This application loosely follows the **MVVM (Model-View-ViewModel)** architectural pattern adjusted heavily for Flutter's `Provider`:

1. **Models (`lib/models`)**: Contains simple data transfer objects converting raw JSON to structured typed Dart objects (e.g. `Post` model).
2. **Services (`lib/services`)**: Completely isolated infrastructure layers responsible strictly for raw data operations.
   - `ApiService`: Dispatches network commands (GET) parsing raw bytes/strings.
   - `CacheService`: Directly interacts with `SharedPreferences` to manage device disk payloads. 
3. **Controllers / ViewModels (`lib/controllers`)**: Defines `ChangeNotifier` state files spanning both the `ThemeProvider` and the heavier `PostProvider`. These interact with Services, hold local data structures (like maps, filtered lists), and invoke `notifyListeners()` when data transitions happen to paint the View correctly. 
4. **Views (`lib/screens` & `lib/widgets`)**: Passive UI trees listening purely to the `Controllers`. Renders reactive styling (Card themes) and triggers controller methods (e.g., `themeProvider.toggleTheme()` and `provider.search(query)`).

## Screenshots
### Check All Screenshots [Here](https://github.com/bharathnaik2k/it-trp-post-lists/tree/main/screenshots) 


## Video Preview


https://github.com/user-attachments/assets/7ca1f71f-e828-4ff1-b266-6a3148ce4e15



