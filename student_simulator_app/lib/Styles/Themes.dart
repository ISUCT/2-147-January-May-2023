// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Themes {
  static final dark = ThemeData(
    brightness: Brightness.dark,
// colorScheme: ColorScheme(
//       brightness: Brightness.dark,
//       surface: Colors.black,
//       onSurface: Colors.white,
//       // Colors that are not relevant to AppBar in DARK mode:
//       primary: Colors.grey,
//       onPrimary: Colors.grey,
//       primaryVariant: Colors.grey,
//       secondary: Colors.grey,
//       secondaryVariant: Colors.grey,
//       onSecondary: Colors.grey,
//       background: Colors.grey,
//       onBackground: Colors.grey,
//       error: Colors.grey,
//       onError: Colors.grey,
// ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900,),
    scaffoldBackgroundColor: Colors.grey.shade900,  
    primaryColor: Colors.white,
    
    // colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white),
    switchTheme: SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
    ),
  );
  static final light = ThemeData(
    brightness: Brightness.light,
    // brightness: Brightness.light,
    appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.grey[800]),
    switchTheme: SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  // bool isOn = false;

  // ThemeData get currentTheme => isOn ? Themes.dark : Themes.light;
  // toggleTheme() {
  //   isOn = !isOn;
  //   notifyListeners();
  // }
}
