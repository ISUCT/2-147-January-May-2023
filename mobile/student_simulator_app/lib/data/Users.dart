import 'package:student_simulator/Model/UserModel.dart';

// int index_admin = 0;
int index_user = 1;
List<UserModel> users = [
  UserModel(
    username: 'Официальная игра \"Student\'s Life\"',
    login: 'admin',
    pass: 'pass1234',
    description: '',
    avatar_url:
        'https://user-images.githubusercontent.com/124696665/220377575-fe993ece-094f-47d4-8aae-e0aec909ece9.png',
    verifed: true,
    status: "admin",
  ),
  UserModel(
    username: 'Гость',
    login: 'guest',
    pass: '1234',
    description: '',
    avatar_url: 'https://kartinkin.net/uploads/posts/2022-12/1670438978_24-kartinkin-net-p-neizvestnost-kartinki-vkontakte-24.jpg',
    verifed: false,
    status: "guest",
  ),
];