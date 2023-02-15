import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kariru/libraryCity.dart';
import 'package:provider/provider.dart';
import 'package:kariru/store.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List prefCityList = [];
  String prefNum = "";
  List<Color> colorList = [
    Colors.lightBlueAccent,
    Colors.lightBlue,
    Colors.blue,
    Colors.blueAccent,
  ];

  setPrefNum(payload) {
    setState(() {
      prefNum = payload;
      print(prefNum);
    });
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/pref_city.json');
    final data = await json.decode(response);
    setState(() {
      prefCityList = [data[0]];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    final Store store = Provider.of<Store>(context, listen: true);
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
        itemCount: prefCityList[0].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colorList[index % colorList.length],
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    setPrefNum('${index + 1}');
                    store.setPerf(prefCityList[0]['${index + 1}']["name"]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LibraryCity(
                              prefNum: prefNum, prefCityList: prefCityList)),
                    );
                  },
                  child: Text(
                    prefCityList[0]['${index + 1}']["name"],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
