// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:student_simulator/data/Users.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static final _formKey = GlobalKey<FormState>();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    if (users[index_user].status == "admin") {
      isChecked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Настройки профиля")),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: ProfilePage._formKey,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    backgroundImage: NetworkImage(users[index_user].avatar_url),
                    minRadius: 50,
                    maxRadius: 75,
                  ),
                ),
              ),
              TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Введите текстовое поле";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Введите текстовое поле";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Введите текстовое поле";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              if (users[index_user].verifed == true)
                Column(
                  children: [
                    Row(
                      children: [
                        Text("Админ"),
                        Checkbox(
                            value: isChecked,
                            onChanged: ((value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              SizedBox(
                height: 50,
                width: size.width,
                child: ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      // print("Success");
                      // }
                      setState(() {
                        if (isChecked == false) {
                          users[index_user].status = '';
                        } else {
                          users[index_user].status = 'admin';
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Сохранить"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue)),
              )
            ],
          ),
        ),
      )),
    );
  }
}
