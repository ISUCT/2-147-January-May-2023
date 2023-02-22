import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:student_simulator/main.dart';

import 'Styles/Themes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var isValue;
    return Scaffold(
        body: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.blue[800]!,
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.blue,
                      floating: false,
                      pinned: true,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                          titlePadding: const EdgeInsets.only(top: 20),
                          // centerTitle: true,
                          title: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8, right: 8),
                            child: Text("Настройки"),
                          )),
                    ),
                    // SliverToBoxAdapter()
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(MyApp.themeNotifier.value ==
                                      ThemeMode.light
                                  // MediaQuery.of(context).platformBrightness == Brightness.dark
                                  ? Icons.nightlight
                                  : Icons.light_mode),
                              title: Text(
                                MyApp.themeNotifier.value == ThemeMode.light
                                    // MediaQuery.of(context).platformBrightness == Brightness.dark
                                    ? "Темный режим"
                                    : "Светлый режим",
                              ),
                              trailing: Switch.adaptive(
                                  value: themeProvider.isDarkMode,
                                  onChanged: (value) {
                                    final provider = Provider.of<ThemeProvider>(
                                        context,
                                        listen: false);
                                    provider.toggleTheme(value);
                                    MyApp.themeNotifier.value =
                                        MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? ThemeMode.dark
                                            : ThemeMode.light;
                                  }),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: Icon(Icons.settings_applications),
                              title: Text('Настройки пользователя'),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: Icon(BoxIcons.bx_support),
                              title: Text('Обратиться в техподдержку'),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: Icon(Icons.info),
                              title: Text('Информация о приложении'),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: Icon(Icons.help),
                              title: Text('Помощь'),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: Icon(
                                Icons.exit_to_app,
                                color: Colors.red,
                              ),
                              title: Text(
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
