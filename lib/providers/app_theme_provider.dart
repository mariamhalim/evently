import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  AppThemeProvider() {
    _loadTheme();
  }

  bool get isDark => appTheme == ThemeMode.dark;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('appTheme') ?? 'light';

    if (savedTheme == 'dark') {
      appTheme = ThemeMode.dark;
    } else {
      appTheme = ThemeMode.light;
    }

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    appTheme = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appTheme', isDark ? 'dark' : 'light');
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) return;

    appTheme = newTheme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'appTheme',
      newTheme == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
