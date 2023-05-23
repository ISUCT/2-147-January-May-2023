import 'dart:io';
import 'dart:math';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_simulator/APIs/post_login.dart';
import 'package:student_simulator/analysisPage.dart';
import 'package:student_simulator/APIs_draft/apiGuide.dart';
import 'package:student_simulator/APIs_draft/apiNews.dart';
import 'package:student_simulator/authPage.dart';
import 'package:student_simulator/forumsPage.dart';

import 'package:student_simulator/settings.dart';
import 'package:provider/provider.dart';
import 'Styles/Themes.dart';
import 'functions/testConnection.dart';
import 'guide/guidePage.dart';
import 'news/newsPage.dart';

String? getLogin;
String? getPass;

// Future getAuth() async {
//   final SharedPreferences mode = await SharedPreferences.getInstance();
//   getLogin = await mode.getString('login') ?? '';
//   getPass = await mode.getString('pass') ?? '';
//   postLogin(getLogin!, getPass!);
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    ),
  );
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Material();
  };
  AppMetrica.activate(
      const AppMetricaConfig("b50c8a26-3e1e-4612-a030-1c79c722912c"));
  // getAuth();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  indexMode = prefs.getInt('themeMode') ?? 0;
  getLogin = prefs.getString('login') ?? '';
  getPass = prefs.getString('pass') ?? '';
  postLogin(getLogin!, getPass!);

  // runApp(isLogin ? const MyApp() : const AuthPage());
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const LoadingAuth());
}

ScrollController scrollController = ScrollController();
bool clicked = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // static final ValueNotifier<ThemeMode> themeNotifier =
  // ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    if (getLogin != '') {
      AppMetrica.reportEvent('Пользователь (${getLogin}) вошел в приложение');
    } else {
      AppMetrica.reportEvent('Пользователь (гость) вошел в приложение');
    }
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) => MaterialApp(
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        theme: Themes.light,
        darkTheme: Themes.dark,
        debugShowCheckedModeBanner: false,
        // // title: 'Student Sumilator',
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
  int _currentIndex = 0;
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
          duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
    } else {
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

class LoadingAuth extends StatefulWidget {
  const LoadingAuth({super.key});

  @override
  State<LoadingAuth> createState() => _LoadingAuthState();
}

class _LoadingAuthState extends State<LoadingAuth>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    connected();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addListener(() {
            setState(() {});
          });
    // controller.reverse();
    controller.repeat(reverse: true, period: Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = controller.value;
    Future.delayed(const Duration(seconds: 1), () {
      if (controller.value >= 0.995 && isConnected) {
        controller.stop();
        // isConnected ?
        runApp(isLogin ? const MyApp() : const AuthPage());
        // : runApp(const AuthPage());
      } else if (controller.value >= 0.995 && !isConnected) {
        controller.stop();
        setState(() {
          isDataLoginLoading = false;
        });
        runApp(const AuthPage());
      }
    });
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 28, 49, 150),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.asset("assets/play_store_512.png")
                          .animate()
                          .fadeIn(
                            duration: 1000.ms,
                            delay: 500.ms,
                            curve: Curves.ease,
                          )
                          .slideY(end: -0.5)
                          .then()
                          .slideY(end: 0.5),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 50,
                        child: LinearProgressIndicator(
                          value: controller.value,
                          valueColor: const AlwaysStoppedAnimation(
                              Color.fromARGB(255, 0, 44, 255)),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
