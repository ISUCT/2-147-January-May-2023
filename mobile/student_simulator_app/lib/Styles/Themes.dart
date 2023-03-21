// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:student_simulator/Styles/Colors.dart';

class Themes {
  static final dark = ThemeData(
    brightness: Brightness.dark,
    hintColor: Colors.blue,
    indicatorColor: Colors.blue,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.blue, linearTrackColor: Colors.blue),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      labelStyle: TextStyle(color: Colors.blue, fontSize: 24.0),
    ),
    // brightness: Brightness.light,
    appBarTheme:
        AppBarTheme(backgroundColor: appBarColorDark, foregroundColor: textColorDark, elevation: 0, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)))),
    scaffoldBackgroundColor: backgroundColorDark,
    primaryColor: textColorDark,
    textTheme: TextTheme(
        bodyLarge: TextStyle(backgroundColor: textColorDark),
        bodySmall: TextStyle(backgroundColor: subColorDark)),
    backgroundColor: backgroundColorDark,
    dialogBackgroundColor: backgroundColorDark,
    // colorSchemeSeed: Colors.black,
    // colorScheme: ColorScheme(
    //   brightness: Brightness.light,
    //   background: backgroundColor,
    //   onBackground: backgroundColorDark,
    //   primary: textColor,
    //   onPrimary: textColor,
    //   secondary: textColor,
    //   onSecondary: textColor,
    //   error: Colors.red,
    //   onError: Colors.red[800]!,
    //   surface: backgroundColorDark,
    //   onSurface: backgroundColorDark,
    // ),
    // useMaterial3: true,
    // bottomAppBarTheme: BottomAppBarTheme(
    //   color: appBarColor
    // ),

    // bottomAppBarTheme: BottomAppBarTheme(),
    // bottomSheetTheme: BottomSheetThemeData(backgroundColor: appBarColor),
    dividerColor: lineColorDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appBarColorDark,
        unselectedIconTheme: IconThemeData(color: textColorDark)),
    iconTheme: IconThemeData(color: textColorDark),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: textColorDark,
      backgroundColor: backgroundColorDark,
    ),
    listTileTheme:
        ListTileThemeData(iconColor: textColorDark, textColor: textColorDark),
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
    hintColor: Colors.blue,
    indicatorColor: Colors.blue,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.blue, linearTrackColor: Colors.blue),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      labelStyle: TextStyle(color: Colors.blue, fontSize: 24.0),
    ),
    // brightness: Brightness.light,
    appBarTheme:
        AppBarTheme(backgroundColor: appBarColor, foregroundColor: textColor, elevation: 0, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)))),
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: textColor,
    textTheme: TextTheme(
        bodyLarge: TextStyle(backgroundColor: textColor),
        bodySmall: TextStyle(backgroundColor: subColor)),
    backgroundColor: backgroundColor,
    dialogBackgroundColor: backgroundColor,
    // colorSchemeSeed: Colors.black,
    // colorScheme: ColorScheme(
    //   brightness: Brightness.light,
    //   background: backgroundColor,
    //   onBackground: backgroundColorDark,
    //   primary: textColor,
    //   onPrimary: textColor,
    //   secondary: textColor,
    //   onSecondary: textColor,
    //   error: Colors.red,
    //   onError: Colors.red[800]!,
    //   surface: backgroundColorDark,
    //   onSurface: backgroundColorDark,
    // ),
    // useMaterial3: true,
    // bottomAppBarTheme: BottomAppBarTheme(
    //   color: appBarColor
    // ),

    // bottomAppBarTheme: BottomAppBarTheme(),
    // bottomSheetTheme: BottomSheetThemeData(backgroundColor: appBarColor),
    dividerColor: lineColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appBarColor,
        unselectedIconTheme: IconThemeData(color: textColor)),
    iconTheme: IconThemeData(color: textColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: textColor,
      backgroundColor: backgroundColor,
    ),
    listTileTheme:
        ListTileThemeData(iconColor: textColor, textColor: textColor),
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
  void toggleTheme(dynamic isOn) {
    themeMode = isOn == 2 ? ThemeMode.dark : isOn == 1 ? ThemeMode.light : ThemeMode.system;
    notifyListeners();
  }
  // bool isOn = false;

  // ThemeData get currentTheme => isOn ? Themes.dark : Themes.light;
  // toggleTheme() {
  //   isOn = !isOn;
  //   notifyListeners();
  // }
}
