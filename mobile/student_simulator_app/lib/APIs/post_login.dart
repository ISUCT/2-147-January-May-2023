import 'package:http/http.dart' as http;
import 'package:student_simulator/functions/testConnection.dart';

// регистрация по API
var postResLogin = '';
bool isLogin = false;
bool isDataLoginLoading = false;
Future postLogin(String login, String pass) async {
  isDataLoginLoading = true;
  isLogin = false;
  String url = "http://80.90.188.52/api/login";
  http.Response res = await http.post(Uri.parse(url), body: {
    "login": login.trim(),
    "password": pass.trim(),
  });
  try {
    if (res.statusCode == 200) {
      isDataLoginLoading = false;
      if (res.body.contains('Error')) {
        isLogin = false;
        postResLogin = 'Нет данных';
      } else {
        isLogin = true;
        postResLogin = 'Вы успешно вошли';
      }
      print("postLogin (${isLogin}): ${res.statusCode} - ${res.body}");
    } else if (res.statusCode == 404) {
      isLogin = false;
      postResLogin = 'Неверный логин или пароль';
      isDataLoginLoading = false;
      print("Failed postLogin");
    } else {
      isLogin = false;
      postResLogin =
          'Произошла ошибка соединения с сервером.\nПопробуйте попозже войти';
      isDataLoginLoading = false;
      print("Not postLogin");
    }
  } catch (e) {
    isLogin = false;
    postResLogin = 'Неизвестная ошибка';
    isDataLoginLoading = false;
    print("excep(postLogin) = $e");
    print("Recorted(postLogin): ${res.statusCode} - ${res.body}");
  }
}
