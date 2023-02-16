import 'package:flutter/material.dart';
import 'package:kariru/book.dart';
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
            Menu(libraryMenu: libraryMenu, setLibraryMenu: setLibraryMenu),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key, this.libraryMenu, this.setLibraryMenu})
      : super(key: key);
  final libraryMenu;
  final setLibraryMenu;

  @override
  Widget build(BuildContext context) {
    if (libraryMenu == false) {
      return Wrap(
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
              setLibraryMenu();
            },
            child: SizedBox(
              width: 110,
              height: 130,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/library.png',
                    width: 100,
                    height: 100,
                    color: Colors.white,
                  ),
                  Text('図書館', style: TextStyle(fontSize: 18)),
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
                MaterialPageRoute(builder: (context) => Book()),
              );
            },
            child: SizedBox(
              width: 110,
              height: 130,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/book.png',
                    width: 100,
                    height: 100,
                    color: Colors.white,
                  ),
                  Text('本', style: TextStyle(fontSize: 18)),
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
      );
    } else {
      return Wrap(
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
                MaterialPageRoute(builder: (context) => Library()),
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
            onPressed: () {
              setLibraryMenu();
            },
            child: SizedBox(
              width: 110,
              height: 130,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/back.png',
                    width: 100,
                    height: 100,
                    color: Colors.white,
                  ),
                  Text('もどる', style: TextStyle(fontSize: 18)),
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
      );
    }
  }
}
