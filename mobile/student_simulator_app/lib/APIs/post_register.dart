import 'package:http/http.dart' as http;
// регистрация по API
var postResRegister = '';
bool isRegister = false;
bool isDataRegisterLoading = false;
Future postRegister(String login, String pass) async {
  isDataRegisterLoading = true;
  String url = "http://80.90.188.52/api/register";
  http.Response res = await http.post(Uri.parse(url), body: {
    "login": login.trim(),
    "password": pass.trim(),
  });
  try {
    if (res.statusCode == 200) {
      isDataRegisterLoading = false;
      isRegister = true;
      postResRegister = 'Вы успешно зарегистрировались и вы теперь можете выполнить вход';
      print("postRegister: ${res.statusCode} - ${res.body}");
    } else if (res.statusCode == 409) {
      isRegister = false;
      postResRegister = 'Email уже есть.\nПопробуйте выполнить вход';
      isDataRegisterLoading = false;
      print("Already postRegister");
    }
    else {
      isRegister = false;
      postResRegister = 'Произошла ошибка соединения с сервером.\nПопробуйте попозже зарегистрироваться';
      isDataRegisterLoading = false;
      print("Not postRegister");
    }
  } catch (e) {
    isRegister = false;
    postResRegister = 'Неизвестная ошибка';
    isDataRegisterLoading = false;
    print("excep(postRegister) = $e");
    print("Recorted(postRegister): ${res.statusCode} - ${res.body}");
  }
}