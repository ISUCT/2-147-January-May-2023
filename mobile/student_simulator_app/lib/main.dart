import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_simulator/analysisPage.dart';
import 'package:student_simulator/APIs_draft/apiGuide.dart';
import 'package:student_simulator/APIs_draft/apiNews.dart';
import 'package:student_simulator/authPage.dart';
import 'package:student_simulator/forumsPage.dart';

import 'package:student_simulator/settings.dart';
import 'package:provider/provider.dart';
import 'Styles/Themes.dart';
import 'guide/guidePage.dart';
import 'news/newsPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
  // runApp(AuthPage());
}

int _currentIndex = 0;
ScrollController scrollController = ScrollController();
bool clicked = false;

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
        // title: 'Student Sumilator',
        home: const ButtomBar(),
      ),
    );
  }
}

List<Widget> _pages = [
  const NewsPage(),
  const GuidePage(),
  const AnalysisPage(),
  const ForumsPage(),
  const SettingsPage(),
];

class ButtomBar extends StatefulWidget {
  const ButtomBar({super.key});

  @override
  State<ButtomBar> createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar> {
  PageController _pageController = PageController();
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    clicked = false;
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
    if (clicked) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }else{
      clicked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: appBarColor,
        selectedItemColor: Colors.blue,
        showSelectedLabels: true,
        showUnselectedLabels: false,

        // unselectedItemColor: Theme.of(context).appBarTheme.foregroundColor,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home_rounded),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Главная"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.quiz_rounded),
              icon: Icon(
                Icons.quiz_outlined,
              ),
              label: "Гайды"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.analytics_rounded),
              icon: Icon(
                Icons.analytics_outlined,
              ),
              label: "Статистика"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.message_rounded),
              icon: Icon(
                Icons.message_outlined,
              ),
              label: "Форумы"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings),
              icon: Icon(
                Icons.settings,
              ),
              label: "Настройки"),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,

        // onTap: (int index) {
        //   setState(() {
        //     _currentIndex = index;
        //     switch (index) {
        //       case 0:
        //         setState(() {
        //           // const NewsPage();
        //           // getNews();
        //           // getNewsImage();
        //         });
        //         // Future<void>.delayed(const Duration(seconds: 1), () {});
        //         break;
        //       case 1:
        //         setState(() {
        //           const GuidePage();
        //           getGuide();
        //         });
        //         Future<void>.delayed(const Duration(seconds: 1), () {});
        //         break;
        //     }
        // }
        // );
        // },
      ),
    );
  }
}
