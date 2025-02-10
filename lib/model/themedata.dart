import 'package:flutter/material.dart';
import 'package:project_dictionary/theme/darkMode.dart';
import 'package:project_dictionary/theme/lightmode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataBase extends ChangeNotifier {
  ThemeData _theme = lightMode;
  bool _isDarkMode = false;

  late SharedPreferences prefs;

  ThemeData get getTheme => _theme;

  Future<void> initTheme() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDarkMode') == null) {
      await prefs.setBool('isDarkMode', false);
    } else {
      _isDarkMode = prefs.getBool('isDarkMode')!;
    }
  }

  void switchTheme() async {
    prefs = await SharedPreferences.getInstance();
    if (_theme == lightMode) {
      _theme = darkMode;
      _isDarkMode = true;
    } else {
      _theme = lightMode;
      _isDarkMode = false;
    }
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
