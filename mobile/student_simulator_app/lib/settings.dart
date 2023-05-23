import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_simulator/authPage.dart';
import 'package:student_simulator/components/slide.dart';
import 'package:student_simulator/main.dart';
import 'package:student_simulator/settings/help/helpPage.dart';
import 'package:student_simulator/settings/profile/profilePage.dart';
import 'package:student_simulator/settings/send/sendEmail.dart';

import 'APIs/post_login.dart';
import 'Styles/Themes.dart';
import 'data/Users.dart';
import 'settings/info/infoPage.dart';
import 'settings/theme/themePage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              insetPadding: const EdgeInsets.all(5),
                              title: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blue,
                                    backgroundImage: NetworkImage(
                                        users[index_user].avatar_url),
                                    foregroundImage: NetworkImage(
                                        users[index_user].avatar_url),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(
                                      width: size.width - 150,
                                      child: Text(
                                        users[index_user].username,
                                        maxLines: 2,
                                      ))
                                ],
                              ),
                            ));
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    backgroundImage: NetworkImage(users[index_user].avatar_url),
                    // child: Icon(Icons.person)),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Настройки",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .backgroundColor),
                            textAlign: TextAlign.left,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          // Padding(
                          // padding: const EdgeInsets.all(8.0),
                          // child:
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Material(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              child: Column(
                                // itemCount: 1,
                                // itemBuilder: (context, index) {

                                // return Column(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(EnterExitRoute(
                                          // exitPage: this.context.widget,
                                          enterPage: const ThemePage()));
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const ThemePage()));
                                    },
                                    // leading: const Icon(Icons.settings_applications),
                                    title: const Text(
                                      'Внешний вид',
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                  // SwitchListTile(
                                  //     value: isDarked,
                                  //     secondary: Icon(
                                  //         brightness.name == ThemeMode.dark.name
                                  //             ? Icons.nightlight
                                  //             : Icons.light_mode),
                                  //     title: Text(
                                  //       brightness.name == ThemeMode.dark.name
                                  //           ? "Темный режим"
                                  //           : "Светлый режим",
                                  //     ),
                                  //     onChanged: (value) {
                                  //       final provider = Provider.of<ThemeProvider>(
                                  //           context,
                                  //           listen: false);

                                  //       provider.toggleTheme(value);

                                  //       brightness.name == ThemeMode.dark.name
                                  //           ? ThemeMode.dark
                                  //           : ThemeMode.light;
                                  //     }),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Divider(
                                      thickness: 2.5,
                                      height: 0,
                                      // color: Colors.grey[400],
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          // MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         const ProfilePage()));
                                          EnterExitRoute(
                                              // exitPage: this.context.widget,
                                              enterPage: const ProfilePage()));
                                    },
                                    // leading: const Icon(Icons.settings_applications),
                                    title: const Text(
                                      'Настройки пользователя',
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),

                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Divider(
                                      thickness: 2.5,
                                      height: 0,
                                      // color: Colors.grey[400],
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          EnterExitRoute(
                                              // exitPage: this.context.widget,
                                              enterPage: const SendEmail())
                                          // MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         const SendEmail())
                                          );
                                    },
                                    // leading: const Icon(BoxIcons.bx_support),
                                    title: const Text(
                                      'Обратиться в техподдержку',
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Divider(
                                      thickness: 2.5,
                                      height: 0,
                                      // color: Colors.grey[400],
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(EnterExitRoute(
                                              // exitPage: this.context.widget,
                                              enterPage: const InfoPage())
                                          // MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         const InfoPage())
                                          );
                                    },
                                    // leading: const Icon(Icons.info),
                                    title: const Text(
                                      'Информация о приложении',
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Divider(
                                      thickness: 2.5,
                                      height: 0,
                                      // color: Colors.grey[400],
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(EnterExitRoute(
                                              // exitPage: this.context.widget,
                                              enterPage: const HelpPage())
                                          // MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         const HelpPage())
                                          );
                                    },
                                    // leading: const Icon(Icons.help),
                                    title: const Text(
                                      'Помощь',
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                                // ),
                                // }
                              ),
                            ),
                          ),
                        ],
                      ),
                      // )
                      if (orientation == Orientation.landscape)
                        const SizedBox(
                          height: 100,
                        ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          child: ListTile(
                            onTap: () {
                              deleteAuth();
                              setState(() {
                                isLogin = false;
                              });
                              if (getLogin != '') {
                                AppMetrica.reportEvent(
                                    'Пользователь (${getLogin}) вышел из логина');
                              } else {
                                AppMetrica.reportEvent(
                                    'Пользователь (гость) вышел из логина');
                              }

                              return runApp(const AuthPage());
                            },
                            // leading: const Icon(
                            //   Icons.exit_to_app,
                            //   color: Colors.red,
                            // ),
                            title: Text(
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .backgroundColor),
                              'Выход из приложения',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // ),
                  // ),
                  // )
                ),
              ),
            ),
          );
        }));
  }
}

Future deleteAuth() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('login');
  await prefs.remove('pass');
}
