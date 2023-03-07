import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kariru/resultLibrary.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    // final Store store = Provider.of<Store>(context, listen: true);
    return Scaffold(
      body: LibraryStep(),
    );
  }
}

class LibraryStep extends StatefulWidget {
  const LibraryStep({Key? key}) : super(key: key);

  @override
  State<LibraryStep> createState() => _LibraryStepState();
}

class _LibraryStepState extends State<LibraryStep> {
  var step = 0;
  List prefCityList = [];
  String prefNum = "";
  String prefName = "";
  String cityName = "";
  List<Color> colorList = [
    Colors.lightBlueAccent,
    Colors.lightBlue,
    Colors.blue,
    Colors.blueAccent,
  ];

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
    if (step == 0) {
      return ListView.builder(
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
                    setState(() {
                      prefNum = '${index + 1}';
                      prefName = prefCityList[0]['${index + 1}']["name"];
                      step++;
                    });
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
      );
    } else if (step == 1) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        shrinkWrap: true,
        itemCount: prefCityList[0][prefNum]['city'].length,
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
                    setState(() {
                      cityName =
                          prefCityList[0][prefNum]["city"][index]['city'];
                      step++;
                    });
                  },
                  child: Text(
                    prefCityList[0][prefNum]["city"][index]['city'],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return ResultLibrary(prefName: prefName, cityName: cityName);
    }
  }
}
