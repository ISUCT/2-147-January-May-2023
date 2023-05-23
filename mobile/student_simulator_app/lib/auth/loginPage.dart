import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_simulator/functions/testConnection.dart';

import '../APIs/post_login.dart';
import '../data/Users.dart';
import '../main.dart';

Future setAuth(String login, String pass) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('login', login);
  await prefs.setString('pass', pass);
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isErrorLog = false;
  bool isErrorPass = false;
  var _isObscure = true;
  var controllerLog = new TextEditingController();
  var controllerPass = new TextEditingController();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: size.height - 450,
                child: Center(
                  child: const Text(
                    "Вход",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // if (androidInfo!.)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          cursorColor: Colors.blue,
                          style: const TextStyle(fontSize: 16),
                          // maxLines: 10,
                          controller: controllerLog,
                          decoration: InputDecoration(
                            label: const Text(
                              "Email",
                              style: TextStyle(fontSize: 16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: isErrorLog
                                ? OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                : null,
                            errorText: isErrorLog ? "Неверный email" : null,
                            errorStyle: const TextStyle(
                                color: Colors.red,
                                backgroundColor: Colors.transparent),
                            errorBorder: isErrorLog
                                ? OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controllerPass,
                          obscureText: _isObscure,
                          cursorColor: Colors.blue,
                          style: const TextStyle(fontSize: 16),
                          // maxLines: 10,
                          decoration: InputDecoration(
                            label: const Text(
                              "Пароль",
                              style: TextStyle(fontSize: 16),
                            ),
                            suffixIcon: IconButton(
                                splashRadius: 20,
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: isErrorPass
                                ? OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                : null,
                            errorText: isErrorPass ? "Нет пароля" : null,
                            errorStyle: const TextStyle(
                                color: Colors.red,
                                backgroundColor: Colors.transparent),
                            errorBorder: isErrorPass
                                ? OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            height: 50,
                            // width: size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed:
                                    // null,
                                    // style: ElevatedButton.styleFrom(
                                    //   backgroundColor: Theme.of(context)
                                    //       .appBarTheme
                                    //       .backgroundColor,
                                    // ),
                                    isDataLoginLoading
                                        ? null
                                        : () async {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            controllerLog.text =
                                                controllerLog.text.trim();
                                            controllerPass.text =
                                                controllerPass.text.trim();
                                            if (controllerLog.text != '' &&
                                                controllerLog.text
                                                    .contains('@') &&
                                                controllerLog.text
                                                    .contains('.')) {
                                              setState(() {
                                                isErrorLog = false;
                                              });
                                              if (controllerPass.text != '') {
                                                setState(() {
                                                  isErrorPass = false;
                                                });
                                                if (isConnected){
                                                print(
                                                    "true: ${controllerLog.text} = ${controllerPass.text}");
                                                postLogin(controllerLog.text,
                                                    controllerPass.text);
                                                setAuth(controllerLog.text,
                                                    controllerPass.text);
                                                setState(() {
                                                  isDataLoginLoading = true;
                                                  // postLogin('test@mail.ru',
                                                  //     'testPass');
                                                });
                                                await Future.delayed(
                                                    const Duration(seconds: 3),
                                                    () {});
                                                print(postResLogin);
                                                setState(() {
                                                  isDataLoginLoading = false;
                                                });
                                                if (isLogin) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(postResLogin),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin:
                                                        EdgeInsets.all(30.0),
                                                  ));
                                                  AppMetrica.reportEvent('Пользователь (${controllerLog.text}) выполнил вход');
                                                  Navigator.of(context).pop;
                                                  runApp(const MyApp());
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(postResLogin),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin:
                                                        EdgeInsets.all(30.0),
                                                  ));
                                                }}else{
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text("Нет соединения с интернетом"),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin:
                                                        EdgeInsets.all(30.0),
                                                  ));
                                                }
                                              } else {
                                                setState(() {
                                                  isErrorPass = true;
                                                });
                                                print("pass false");
                                              }
                                            } else {
                                              setState(() {
                                                isErrorLog = true;
                                              });
                                              print("false");
                                            }
                                          },
                                // onPressed: () async{
                                //     await showDialog(context: context, builder: (context) => AlertDialog(
                                //       title: Text("Ошибка"),
                                //       content: Text("Вы не можете войти."),
                                //       actions: [
                                //         TextButton(onPressed: () {Navigator.of(context).pop(); Navigator.of(context).pop();}, child: Text("Ок"))
                                //       ],
                                //     ));
                                //   // setState(() {
                                //   //   index_user = 0;
                                //   //   return runApp(const MyApp());
                                //   // });
                                // },
                                child: isDataLoginLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Войти",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .backgroundColor),
                                      )))
                      ],
                    ),
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         index_user = 1;
                  //         return runApp(const MyApp());
                  //       });
                  //     },
                  //     child: const Text("Войти как гость"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
