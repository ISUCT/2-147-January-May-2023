import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Styles/Themes.dart';
import '../../authPage.dart';
import '../../settings.dart';

Future switCH(int index) async {
  final SharedPreferences mode = await SharedPreferences.getInstance();
  await mode.setInt('themeMode', index);
  getMode();
}

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    final themeChanger = Provider.of<ThemeProvider>(context);

    // _switch() async {
    //   if (brightness.name == ThemeMode.light.name) {
    //     isDarked = 2;
    //   } else {
    // isDarked = 1;
    // }
    // SharedPreferences prefs =
    //     await SharedPreferences.getInstance();
    // setState(() {
    //   prefs.setBool('isDarkTheme', isDarked);
    //   isDarked = prefs.getBool('isDarkTheme') ?? false;
    //   print("test: ${prefs.getBool('isDarkTheme').toString()}");
    // });
    // }

    // _switch();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Внешний вид"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                LabeledRadio(
                    label: "Авто (по умолчанию)",
                    groupValue: themeChanger.themeMode,
                    value: mode(0),
                    onChanged: themeChanger.toggleTheme),
                // ListTile(
                //   onTap: (){
                //    mode(0);
                //    themeChanger.themeMode;
                //    themeChanger.toggleTheme;
                //   },
                //     title: const Text("Авто (по умолчанию)"),
                //     trailing: Radio(
                //         // overlayColor: MaterialStateColor.resolveWith(
                //         //     (states) => Colors.blue),
                //         // hoverColor: MaterialStateColor.resolveWith(
                //         //     (states) => Colors.blue),
                //         fillColor: MaterialStateColor.resolveWith(
                //             (states) => Colors.blue),
                //         focusColor: MaterialStateColor.resolveWith(
                //             (states) => Colors.blue),
                //         value: mode(0),
                //         groupValue: themeChanger.themeMode,
                //         onChanged: themeChanger.toggleTheme)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    thickness: 2.5,
                    height: 0,
                    // color: Colors.grey[400],
                  ),
                ),
                LabeledRadio(
                    label: "Светлый режим",
                    groupValue: themeChanger.themeMode,
                    value: mode(1),
                    onChanged: themeChanger.toggleTheme),
                // ListTile(
                //     title: const Text("Светлый режим"),
                //     trailing: Radio(
                //         fillColor: MaterialStateColor.resolveWith(
                //             (states) => Colors.blue),
                //         focusColor: MaterialStateColor.resolveWith(
                //             (states) => Colors.blue),
                //         value: mode(1),
                //         groupValue: themeChanger.themeMode,
                //         onChanged: themeChanger.toggleTheme)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    thickness: 2.5,
                    height: 0,
                    // color: Colors.grey[400],
                  ),
                ),
                LabeledRadio(
                    label: "Темный режим",
                    groupValue: themeChanger.themeMode,
                    value: mode(2),
                    onChanged: themeChanger.toggleTheme),
                // ListTile(
                //     title: const Text("Темный режим"),
                //     trailing: Radio(
                //         fillColor: MaterialStateColor.resolveWith(
                //             (states) => Colors.blue),
                //         focusColor: MaterialStateColor.resolveWith(
                //             (states) => Colors.blue),
                //         value: mode(2),
                //         groupValue: themeChanger.themeMode,
                //         onChanged: themeChanger.toggleTheme)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio(
      {required this.label,
      required this.groupValue,
      required this.value,
      required this.onChanged,
      super.key});
  final String label;
  final ThemeMode groupValue;
  final ThemeMode value;
  final dynamic onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      title: Text(label),
      trailing: Radio(
          // overlayColor: MaterialStateColor.resolveWith(
          //     (states) => Colors.blue),
          // hoverColor: MaterialStateColor.resolveWith(
          //     (states) => Colors.blue),
          fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
          focusColor: MaterialStateColor.resolveWith((states) => Colors.blue),
          value: value,
          groupValue: groupValue,
          onChanged: onChanged),
    );
  }
}
