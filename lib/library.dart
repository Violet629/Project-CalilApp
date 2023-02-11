import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List pref = [];
  List<Color> colorList = [
    Colors.lightBlueAccent,
    Colors.lightBlue,
    Colors.blue,
    Colors.blueAccent,
  ];
  bool step = false;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/pref_city.json');
    final data = await json.decode(response);
    setState(() {
      pref = [data[0]];
    });
  }

  swStep() {
    setState(() {
      step = true;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: pref[0].length,
        itemBuilder: (BuildContext context, int index) {
          if (step == false) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
              // padding: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: colorList[index % colorList.length],
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      swStep();
                    },
                    child: Text(
                      pref[0]['${index + 1}']["name"],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
              // padding: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: colorList[index % colorList.length],
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {},
                    child: Text(
                      pref[0]['${index + 1}']["name"],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
