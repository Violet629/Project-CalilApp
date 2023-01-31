import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('title'),
        ),
        body: Center(
          child: Text('body'),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}
