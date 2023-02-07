import 'package:flutter/material.dart';

class Library_gps extends StatelessWidget {
  const Library_gps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/calil_logo_black.png',
          width: 170,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: Text("gps"),
      ),
    );
  }
}
