// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:student_simulator/main/mainPage.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {this.leading,
      required this.subtitle,
      required this.title,
      this.route,
      this.trailing,
      super.key});
  final Widget? leading;
  final Widget title;
  final Widget subtitle;
  final Widget? trailing;
  final Widget? route;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        route != null
            ? Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => route!))
            : null;
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 100,
          // maxHeight:
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      const SizedBox(
                        height: 5,
                      ),
                      subtitle,
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(8),
                  child: trailing),
            ],
          ),
        ),
      ),
    );
  }
}
