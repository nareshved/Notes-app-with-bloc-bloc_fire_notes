import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  final String _isDarkKey = "isDark";

  bool get themeValue {
    getThemeInPrefs();
    return _isDark;
  }

  set themeValue(bool value) {
    _isDark = value;

    setThemeInPrefs(value);
    notifyListeners();
  }

  setThemeInPrefs(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isDarkKey, value);

    notifyListeners();
  }

  getThemeInPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    bool? checkKey = prefs.getBool(_isDarkKey);

    if (checkKey != null) {
      _isDark = checkKey;
    } else {
      checkKey = false;
    }

    notifyListeners();
  }
}
