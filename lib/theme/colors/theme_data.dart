import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily: 'Lora',
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      primarySwatch: Colors.purple,
      primaryColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: isDarkTheme
          ? Colors.grey.shade300
          : const Color.fromARGB(255, 66, 66, 66),
      highlightColor: isDarkTheme
          ? const Color(0xff372901)
          : const Color.fromARGB(209, 169, 252, 146),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor: isDarkTheme
          ? const Color(0xff0B2512)
          : const Color.fromARGB(133, 168, 218, 194),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
}
