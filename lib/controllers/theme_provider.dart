import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String themeKey = 'isDarkMode';
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, _isDarkMode);
    notifyListeners();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(themeKey) ?? false;
    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkMode
        ? ThemeData.dark().copyWith(
            primaryColor: const Color.fromARGB(255, 103, 58, 183),
            colorScheme: const ColorScheme.dark(
              primary: Color.fromRGBO(124, 77, 255, 1),
              secondary: Color.fromRGBO(100, 255, 218, 1),
            ),
            scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
            cardTheme: const CardThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              elevation: 4,
              shadowColor: Color.fromRGBO(0, 0, 0, 1),
            ),
          )
        : ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 103, 58, 183),
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 103, 58, 183),
              secondary: Color.fromRGBO(0, 150, 136, 1),
            ),
            scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 252, 1),
            cardTheme: const CardThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              elevation: 4,
              shadowColor: Color.fromRGBO(0, 0, 0, 0.122),
            ),
          );
  }
}
