import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_simulator/data/Users.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'auth/loginPage.dart';
import 'main.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var controllerLog = new TextEditingController();
    var controllerPass = new TextEditingController();
    // Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  const Text("Вход", style: TextStyle(fontSize: 40),),
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
                                "Имя пользователя",
                                style: TextStyle(fontSize: 16),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue, width: 2),
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
                                "Пароль",
                                style: TextStyle(fontSize: 16),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue, width: 2),
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
                                    
                                  }, child: Text("Войти")))
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            index_user = 1;
                            return runApp(const MyApp());
                          });
                        },
                        child: const Text("Войти как гость"))
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
