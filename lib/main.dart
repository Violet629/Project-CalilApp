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
        // appBar: AppBar(
        //   title: Text('title'),
        // ),
        body: Center(
          child: Image(image: AssetImage('assets/calil_logo.png')),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              label: '図書館',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_sharp),
              label: '本',
            ),
          ],
          // currentIndex: , // 지정 인덱스로 이동
          selectedItemColor: Colors.blue,
          // onTap: _onItemTapped, // 선언했던 onItemTapped
        ),
      ),
    );
  }
}
