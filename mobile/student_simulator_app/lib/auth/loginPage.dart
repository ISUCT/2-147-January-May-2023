import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/Users.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _isObscure = true;
    var controllerLog = new TextEditingController();
    var controllerPass = new TextEditingController();
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
                                child: Text(
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
