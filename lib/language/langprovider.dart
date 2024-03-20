
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const THEME_STATUS = "language";

  setDarkTheme(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_STATUS, value);
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
          THEME_STATUS,
        ) ??
        "en";
  }
}


class LanguageProvider with ChangeNotifier {
  LanguagePreferences languagePreferences = LanguagePreferences();
  String _darkTheme = "en";
  String get getDarkTheme => _darkTheme;

  set setDarkTheme(String value) {
    _darkTheme = value;
    languagePreferences.setDarkTheme(value);
    notifyListeners();
  }
}
