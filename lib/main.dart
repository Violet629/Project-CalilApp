import 'package:flutter/material.dart';

import 'package:kariru/library.dart';
import 'package:kariru/libraryGps.dart';
import 'package:kariru/store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Store>(
          create: (context) => Store(),
        ),
      ],
      child: MaterialApp(
        // theme: ThemeData(fontFamily: 'Reggae'),
        home: HomeMenu(),
      ),
    );
  }
}

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  var libraryMenu = false;

  setLibraryMenu() {
    setState(() {
      if (libraryMenu == false) {
        libraryMenu = true;
      } else {
        libraryMenu = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              margin: EdgeInsets.fromLTRB(0, 120, 0, 130),
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
                    primary: Color(0xff00b8ee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Frame()),
                    );
                  },
                  child: SizedBox(
                    width: 110,
                    height: 130,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/magnifying-glass.png',
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        Text('地域から探す', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    primary: Color(0xff00b8ee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LibraryGps()),
                    );
                  },
                  child: SizedBox(
                    width: 110,
                    height: 130,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/gps.png',
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        Text('周りから探す', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    primary: Color(0xff00b8ee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: 110,
                    height: 130,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/bookmark.png',
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        Text('お気入り', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    primary: Color(0xff00b8ee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: 110,
                    height: 130,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/settings.png',
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                        Text('設定', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Frame extends StatefulWidget {
  const Frame({Key? key}) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int _currentIndex = 0;
  List pageList = [
    Library(),
    LibraryGps(),
  ];

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
      body: pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: ("地域"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: ("周り"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: ("お気入り"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: ("設定"),
          ),
        ],
      ),
    );
  }
}
