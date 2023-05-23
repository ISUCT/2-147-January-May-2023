import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late String _appName;
  late String _packageName;
  late String _version;
  late String _buildNumber;
  bool _isloading = true;
  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _buildNumber = packageInfo.buildNumber;
    _version = '${packageInfo.version}+${packageInfo.buildNumber}';

    _isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Информация о приложении"),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Image.asset(
                          brightness == Brightness.light
                              ? 'assets/ChEL_minimal_vektor.png'
                              : 'assets/ChEL_minimal_vektor_bel.png',
                          height: 150,
                        ),
                      ),
                      Center(
                          child: Text(
                        _appName,
                        style:  TextStyle(
                            fontWeight: FontWeight.w700,
                            // color: Color.fromARGB(255, 28,49,150),
                            fontSize: 25),
                      )),
                      Center(
                          child: Text(
                        "Версия ${_version}",
                        style: const TextStyle(fontSize: 15),
                      )),
                      const Divider(
                        color: Colors.grey,
                      ),
                      ListTile(
                        title: const Text("История последних версий",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onTap: () {},
                      )
                    ]),
              ),
            ),
    );
  }
}
