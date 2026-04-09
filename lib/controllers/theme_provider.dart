import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String themeKey = 'isDarkMode';
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadFromPrefs();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, _isDarkMode);
  }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(themeKey) ?? false;
    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkMode
        ? ThemeData.dark().copyWith(
            primaryColor: Colors.deepPurple,
            colorScheme: const ColorScheme.dark(
              primary: Colors.deepPurpleAccent,
              secondary: Colors.tealAccent,
            ),
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardTheme: const CardThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              elevation: 4,
              shadowColor: Colors.black45,
            ),
          )
        : ThemeData.light().copyWith(
            primaryColor: Colors.deepPurple,
            colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple,
              secondary: Colors.teal,
            ),
            scaffoldBackgroundColor: const Color(0xFFF5F5FC),
            cardTheme: const CardThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              elevation: 4,
              shadowColor: Colors.black12,
            ),
          );
  }
}
