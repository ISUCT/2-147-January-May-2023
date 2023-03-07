import 'package:flutter/material.dart';

class detalGuidePage extends StatelessWidget {
  const detalGuidePage({required this.name, required this.description, required this.datetime, this.url, required this.user, super.key});
  final name;
  final description;
  final url;
  final datetime;
  final user;

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: Text("Подробности"),
      ),
      body: Column(
        children: [
          Text(name, style: TextStyle(fontSize: 40),),
          Text(description, style: TextStyle(fontSize: 40),),
        ],
      ),
    );
  }
}