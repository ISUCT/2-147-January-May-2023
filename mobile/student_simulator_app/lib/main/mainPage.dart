// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../data/Users.dart';

int countSendEmail = 0;

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
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
                            insetPadding: EdgeInsets.all(5),
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
                                    width: 250,
                                    child: Text(
                                      users[index_user].username,
                                      maxLines: 2,
                                    ))
                              ],
                            ),
                          ));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(users[index_user].avatar_url),
                  foregroundImage: NetworkImage(users[index_user].avatar_url),
                  // child: Icon(Icons.person)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Text(
              "Новости",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 200,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Material(
                  elevation: 5,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
