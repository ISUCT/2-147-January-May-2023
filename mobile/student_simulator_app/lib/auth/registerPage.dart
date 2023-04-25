import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_simulator/APIs/post_register.dart';
import 'package:student_simulator/Styles/Colors.dart';

import '../data/Users.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isErrorLog = false;
  bool isErrorPass = false;
  bool isErrorPass2 = false;
  var controllerLog = new TextEditingController();
  var controllerPass = new TextEditingController();
  var controllerPass2 = new TextEditingController();
  var _isObscure = true;
  var _isObscure1 = true;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 250,
                  child: Center(
                    child: Text(
                      "Регистрация",
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
                            controller: controllerLog,
                            cursorColor: Colors.blue,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
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
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: controllerPass,
                            obscureText: _isObscure,
                            cursorColor: Colors.blue,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
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
                              label: const Text(
                                "Введите пароль",
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
                          TextField(
                            controller: controllerPass2,
                            obscureText: _isObscure1,
                            cursorColor: Colors.blue,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  splashRadius: 20,
                                  icon: Icon(_isObscure1
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure1 = !_isObscure1;
                                    });
                                  }),
                              label: const Text(
                                "Подтвердите пароль",
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
                              focusedErrorBorder: isErrorPass2
                                  ? OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.circular(15),
                                    )
                                  : null,
                              errorText:
                                  isErrorPass2 ? "Пароль не совпадает" : null,
                              errorStyle: const TextStyle(
                                  color: Colors.red,
                                  backgroundColor: Colors.transparent),
                              errorBorder: isErrorPass2
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
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                  ),
                                  // isDataRegisterLoading
                                  //     ? null
                                  //     : () async {
                                  //         FocusManager.instance.primaryFocus
                                  //             ?.unfocus();
                                  //         controllerLog.text =
                                  //             controllerLog.text.trim();
                                  //         controllerPass.text =
                                  //             controllerPass.text.trim();
                                  //         controllerPass2.text =
                                  //             controllerPass2.text.trim();
                                  //         if (controllerLog.text != '' &&
                                  //             controllerLog.text
                                  //                 .contains('@') &&
                                  //             controllerLog.text
                                  //                 .contains('.')) {
                                  //           setState(() {
                                  //             isErrorLog = false;
                                  //           });
                                  //           if (controllerPass.text != '') {
                                  //             setState(() {
                                  //                 isErrorPass = false;
                                  //               });
                                  //             if (controllerPass.text ==
                                  //                 controllerPass2.text) {
                                  //               setState(() {
                                  //                 isErrorPass2 = false;
                                  //               });
                                  //               print(
                                  //                   "true: ${controllerLog.text} = ${controllerPass.text}");
                                  //               // postRegister(controllerLog.text, controllerPass.text);
                                  //               setState(() {
                                  //                 isDataRegisterLoading =
                                  //                     true;
                                  //                 postRegister('test@mail.ru',
                                  //                     'testPass');
                                  //               });
                                  //               await Future.delayed(
                                  //                   const Duration(
                                  //                       seconds: 3),
                                  //                   () {});
                                  //               print(postResRegister);
                                  //               setState(() {
                                  //                 isDataRegisterLoading =
                                  //                     false;
                                  //               });
                                  //               if (isRegister) {
                                  //                 ScaffoldMessenger.of(
                                  //                         context)
                                  //                     .showSnackBar(SnackBar(
                                  //                         content: Text(
                                  //                             postResRegister)));
                                  //                 Navigator.of(context).pop;
                                  //               } else {
                                  //                 ScaffoldMessenger.of(
                                  //                         context)
                                  //                     .showSnackBar(SnackBar(
                                  //                         content: Text(
                                  //                             postResRegister)));
                                  //               }
                                  //             } else {
                                  //               setState(() {
                                  //                 isErrorPass2 = true;
                                  //               });
                                  //             }
                                  //           } else {
                                  //             setState(() {
                                  //               isErrorPass = true;
                                  //             });
                                  //             print("pass false");
                                  //           }
                                  //         } else {
                                  //           setState(() {
                                  //             isErrorLog = true;
                                  //           });
                                  //           print("false");
                                  //         }
                                  //       },

                                  child: isDataRegisterLoading
                                      ? CircularProgressIndicator()
                                      : Text(
                                          "Зарегистрироваться",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .backgroundColor),
                                        )))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
