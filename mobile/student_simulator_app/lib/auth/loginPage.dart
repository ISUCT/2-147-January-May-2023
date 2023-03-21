import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerLog = new TextEditingController();
    var controllerPass = new TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                  
                      cursorColor: Colors.blue,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 10,
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
                    TextField(
                      
                      cursorColor: Colors.blue,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 10,
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
                    SizedBox(
                      height: 50,
                      width: size.width,
                      child: ElevatedButton(onPressed: (){}, child: Text("Войти")))
            ],
          ),
        ),
    );
  }
}