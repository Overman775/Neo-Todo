import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  final SharedPreferences prefs;
  Settings(this.prefs);

  ThemeMode get themeMode {
    if (prefs.getBool('darkMode') == true) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  set themeMode(ThemeMode mode) => prefs
      .setBool('darkMode', mode != ThemeMode.light)
      .then((_) => notifyListeners());

  bool get isDarkMode => prefs.getBool('darkMode') == true;
}
