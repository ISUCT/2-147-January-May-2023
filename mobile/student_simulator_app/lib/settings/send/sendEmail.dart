import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../news/newsPage.dart';

class SendEmail extends StatefulWidget {
  const SendEmail({super.key});

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  bool? connect;
  @override
  void initState() {
    print("Количество запросов: $countSendEmail");
    connectCheck();
  }

  Future connectCheck() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect = true;
      }
    } catch (_) {
      connect = false;
      print("Ошибка! Нет интернета: ${_}");
    }
  }

  String email = "";
  String name = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String message = "";
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Обратиться в техподдержку"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Здесь вы можете обратиться о проблеме приложения или задать любой вопрос",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'От кого?',
                  hintText: 'Введите ваше имя',
                  labelStyle: const TextStyle(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: const TextStyle(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                controller: messageController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Письмо',
                  hintText: 'Что вы хотели написать?',
                  labelStyle: const TextStyle(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue)),
                      onPressed: () async {
                        if (emailController.text != '' &&
                            nameController.text != '' &&
                            messageController.text != '') {
                          String subject =
                              "Обращение пользователя ${nameController.text} к разработчикам";
                          if (connect == true) {
                            if (countSendEmail != 1) {
                              sendEmailAPI(
                                  name: nameController.text,
                                  email: emailController.text,
                                  subject: subject,
                                  message: messageController.text);
                              countSendEmail = 1;
                              return showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Информация"),
                                        content: const Text(
                                            "Письмо отправлено. В течение трёх дней ваш письмо будет принято. Ждите ответа в электронной почте."),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'ОК',
                                                style: TextStyle(),
                                              ))
                                        ],
                                      ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Более одного письма за сегодняшний день сделать нельзя!")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Письмо не отправлено.\nНет подключения к интернету")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Письмо не отправлено.\nВы не написали письмо!")));
                        }
                      },
                      child: const Text(
                        "Отправить письмо",
                        style: TextStyle(fontSize: 18),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Future sendEmailAPI({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    String serviceId = 'service_7znnb18';
    String templateId = 'template_xl62wvp';
    String userId = 'b90ukqwzUfEoXIQ8l';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_subject': subject,
            'user_name': name,
            'user_email': email,
            'message': message,
          }
        }));
    print(response.body);
  }
}
