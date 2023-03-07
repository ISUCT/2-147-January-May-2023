import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_simulator/settings/help/helpPage.dart';
import 'package:student_simulator/settings/send/sendEmail.dart';

import 'Styles/Themes.dart';
import 'settings/info/infoPage.dart';

bool isDarked = false;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var brightness = Theme.of(context).brightness;

    return Scaffold(
        body: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.blue[800]!,
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    const SliverAppBar(
                      backgroundColor: Colors.blue,
                      floating: false,
                      pinned: true,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                          titlePadding: EdgeInsets.only(top: 20),
                          // centerTitle: true,
                          title: Padding(
                            padding:
                                EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                            child: Text("Настройки"),
                          )),
                    ),
                    // SliverToBoxAdapter()
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        _switch() async {
                          if (brightness.name == ThemeMode.light.name) {
                            isDarked = false;
                          } else {
                            isDarked = true;
                          }
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // setState(() {
                          //   prefs.setBool('isDarkTheme', isDarked);
                          //   isDarked = prefs.getBool('isDarkTheme') ?? false;
                          //   print("test: ${prefs.getBool('isDarkTheme').toString()}");
                          // });
                        }

                        _switch();
                        return Column(
                          children: [
                            SwitchListTile(
                                value: isDarked,
                                secondary: Icon(
                                    brightness.name == ThemeMode.dark.name
                                        ? Icons.nightlight
                                        : Icons.light_mode),
                                title: Text(
                                  brightness.name == ThemeMode.dark.name
                                      ? "Темный режим"
                                      : "Светлый режим",
                                ),
                                onChanged: (value) {
                                  final provider = Provider.of<ThemeProvider>(
                                      context,
                                      listen: false);

                                  provider.toggleTheme(value);

                                  brightness.name == ThemeMode.dark.name
                                      ? ThemeMode.dark
                                      : ThemeMode.light;
                                }),
                            ListTile(
                              onTap: () {},
                              leading: const Icon(Icons.settings_applications),
                              title: const Text('Настройки пользователя'),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SendEmail()));
                              },
                              leading: const Icon(BoxIcons.bx_support),
                              title: const Text('Обратиться в техподдержку'),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const InfoPage()));
                              },
                              leading: const Icon(Icons.info),
                              title: const Text('Информация о приложении'),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const HelpPage()));
                              },
                              leading: const Icon(Icons.help),
                              title: const Text('Помощь'),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: const Icon(
                                Icons.exit_to_app,
                                color: Colors.red,
                              ),
                              title: const Text(
                                'Выход',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      }, childCount: 1),
                    )
                  ],
                ))));
  }
}
