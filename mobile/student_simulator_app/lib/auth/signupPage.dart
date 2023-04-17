import 'package:flutter/material.dart';

import '../data/Users.dart';
import '../main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var controllerLog = new TextEditingController();
  var controllerPass = new TextEditingController();
  var _isObscure = true;
  var _isObscure1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Регистрация",
                style: TextStyle(fontSize: 40),
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
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          cursorColor: Colors.blue,
                          style: const TextStyle(fontSize: 16),
                          // maxLines: 10,
                          decoration: InputDecoration(
                            label: const Text(
                              "Username",
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
                          obscureText: _isObscure,
                          cursorColor: Colors.blue,
                          style: const TextStyle(fontSize: 16),
                          // maxLines: 10,

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
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          obscureText: _isObscure1,
                          cursorColor: Colors.blue,
                          style: const TextStyle(fontSize: 16),
                          // maxLines: 10,

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
                              "Повторите пароль еще раз",
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
                        SizedBox(
                            height: 50,
                            // width: size.width,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    index_user = 0;
                                    return runApp(const MyApp());
                                  });
                                },
                                child: const Text("Зарегистрироваться")))
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
