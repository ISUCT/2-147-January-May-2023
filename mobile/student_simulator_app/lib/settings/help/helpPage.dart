import 'package:flutter/material.dart';
import 'package:student_simulator/settings/help/model/HelpModel.dart';

import 'data/HelpData.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Помощь"),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList.radio(
            children: questions.map<ExpansionPanelRadio>((HelpModel helpModel) {
          return ExpansionPanelRadio(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(helpModel.question),
              );
            },
            body: ListTile(
              title: Text(helpModel.answer),
            ),
            value: helpModel.question
          );
        }).toList(),
        ),
      ),
    );
  }
}