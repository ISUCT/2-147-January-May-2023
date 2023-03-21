import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_simulator/Styles/Colors.dart';
import 'package:student_simulator/analysisPage.dart';
import 'package:student_simulator/authPage.dart';
import 'package:student_simulator/forumsPage.dart';

import 'package:student_simulator/settings.dart';
import 'package:provider/provider.dart';
import 'Styles/Themes.dart';
import 'api/apiGuide.dart';
import 'guide/guidePage.dart';
import 'news/newsPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
  // runApp(AuthPage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) => MaterialApp(
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        theme: Themes.light,
        darkTheme: Themes.dark,
        debugShowCheckedModeBanner: false,
        title: 'Student Sumilator',
        home: const ButtomBar(),
      ),
    );
  }
}

List _pages = [
  const NewsPage(),
  const GuidePage(),
  const AnalysisPage(),
  const ForumsPage(),
  const SettingsPage(),
];
int _currentIndex = 0;

class ButtomBar extends StatefulWidget {
  const ButtomBar({super.key});

  @override
  State<ButtomBar> createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height, child: _pages.elementAt(_currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: appBarColor,
        selectedItemColor: Colors.blue,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        
        // unselectedItemColor: Theme.of(context).appBarTheme.foregroundColor,
        type: BottomNavigationBarType.fixed,
        
        items: [
          BottomNavigationBarItem(
              activeIcon: const Icon(Icons.home),
              icon: Icon(Icons.home, ),
              label: "Главная"),
          BottomNavigationBarItem(
              activeIcon: const Icon(Icons.quiz),
              icon: Icon(
                Icons.quiz,
                
              ),
              label: "Гайды"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.analytics),
              icon: Icon(Icons.analytics,
                  ),
              label: "Статистика"),
          BottomNavigationBarItem(
              activeIcon: const Icon(Icons.message),
              icon:
                  Icon(Icons.message, ),
              label: "Форумы"),
          BottomNavigationBarItem(
              activeIcon: const Icon(Icons.settings),
              icon: Icon(Icons.settings,
                  ),
              label: "Настройки"),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
