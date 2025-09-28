import 'package:flutter/material.dart';
import '../shared_preferences/shared_preference_helper.dart';

class AppPrefProvider with ChangeNotifier {
  bool _isDark = false;
  String _languageCode = "en";

  bool get isDark => _isDark;

  String get languageCode => _languageCode;

  AppPrefProvider() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    _isDark = await AppPreferences.getTheme();
    _languageCode = await AppPreferences.getLanguage();
    notifyListeners();
  }

  void toggleTheme() {
    _isDark = !_isDark;
    AppPreferences.setTheme(_isDark);
    notifyListeners();
  }

  void changeLanguage(String langCode) {
    _languageCode = langCode;
    AppPreferences.setLanguage(langCode);
    notifyListeners();
  }
}
