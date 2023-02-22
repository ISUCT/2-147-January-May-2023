import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: InkWell(
                  customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  onTap: () {
                    showDialog(context: context, builder:(context) => AlertDialog(
                      title: Text("Работает"),
                    )
                    );
                  },
            child: CircleAvatar(
                  child: Icon(Icons.person)),
            ),
              ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Text(
              "Новости",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 200,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
