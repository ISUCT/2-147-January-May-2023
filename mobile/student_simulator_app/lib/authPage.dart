import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:student_simulator/auth/signupPage.dart';
import 'package:student_simulator/data/Users.dart';

import 'Styles/Themes.dart';
import 'auth/loginPage.dart';
import 'main.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

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
    _load();
    super.initState();
  }

  void _load() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    _appName,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        )),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage())),
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
                              side: const BorderSide(width: 2, color: Colors.blue),
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        )),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SignupPage())),
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
            ],
          ),
        ),
      ),
    );
  }
}
