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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/home.png'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 140, 0, 100),
                child: Image.asset('assets/calil_logo.png'),
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                direction: Axis.horizontal,
                runSpacing: 15,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      backgroundColor: Color(0xff00b8ee),
                    ),
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/library.png',
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        Text('図書館', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      backgroundColor: Color(0xff00b8ee),
                    ),
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/book.png',
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        Text('本', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      backgroundColor: Color(0xff00b8ee),
                    ),
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/bookmark.png',
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        Text('お気入り', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      backgroundColor: Color(0xff00b8ee),
                    ),
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/settings.png',
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        Text('設定', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
