import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_simulator/Styles/Colors.dart';
import 'package:student_simulator/auth/registerPage.dart';
import 'package:student_simulator/data/Users.dart';
import 'package:student_simulator/functions/testConnection.dart';

import 'APIs/post_login.dart';
import 'Styles/Themes.dart';
import 'auth/loginPage.dart';
import 'main.dart';

int? indexMode;
Future getMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  indexMode = prefs.getInt('themeMode') ?? 0;
  print("Mode = ${indexMode!}");
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var controllerLog = new TextEditingController();
    // var controllerPass = new TextEditingController();
    // Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) => MaterialApp(
              themeMode: Provider.of<ThemeProvider>(context).themeMode,
              theme: Themes.light,
              darkTheme: Themes.dark,
              debugShowCheckedModeBanner: false,
              // title: 'Student Sumilator',
              home: const Auth(),
            ));
  }
}

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String _appName = '';
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setState(() {
      connected();
    });
    _load();
    FocusManager.instance.primaryFocus?.unfocus();

    // if (!isConnected) {
    //   Future.delayed(const Duration(seconds: 1), () {
    //   });
    // Future.delayed(const Duration(seconds: 5), () {
    //   ScaffoldMessenger.of(context).clearMaterialBanners();
    // });
    // }

    super.initState();
  }

  void _load() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
    setState(() {});
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        connected();
      });
    });
    var brightness = Theme.of(context).brightness;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              !isConnected
                  ? Container(
                      width: size.width,
                      height: 20,
                      color: Colors.red,
                      child: const Center(
                          child: Text(
                        "Нет соединения с интернетом!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Flexible(
                    // child:
                    Center(
                      child: SizedBox(
                        height: size.height - 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              brightness == Brightness.light
                                  ? 'assets/ChEL_minimal_vektor.png'
                                  : 'assets/ChEL_minimal_vektor_bel.png',
                              height: 100,
                            ),
                            Text(
                              _appName,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium!
                                      .color),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ),
                    SizedBox(
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const Text(
                          //   "Внимание! Сейчас недоступна авторизация. Вы пока можете войти как гость. Извините за доставленные неудобства и желаю вам приятного просмотра! 😉",
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          SizedBox(
                            width: size.width,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                )),
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage())),
                                child: const Text("Вход")),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: size.width / 2 - 50,
                                child: const Divider(
                                  height: 2,
                                  thickness: 2,
                                ),
                              ),
                              const Text("или"),
                              SizedBox(
                                width: size.width / 2 - 50,
                                child: const Divider(
                                  height: 2,
                                  thickness: 2,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: size.width,
                            height: 50,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        width: 2, color: Colors.blue),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // <-- Radius
                                    )),
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage())),
                                child: const Text("Регистрация")),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  index_user = 1;
                                  return runApp(const MyApp());
                                });
                              },
                              child: const Text("Войти как гость")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
