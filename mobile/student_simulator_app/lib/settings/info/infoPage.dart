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
    _version = packageInfo.version;

    _isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                        child: const Icon(
                          Icons.logo_dev,
                          size: 150,
                        ),
                      ),
                      Center(
                          child: Text(
                        _appName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
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
