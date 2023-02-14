import 'package:flutter/material.dart';
import 'package:kariru/resultLibrary.dart';
import 'package:provider/provider.dart';

class LibraryCity extends StatefulWidget {
  const LibraryCity({Key? key, this.prefNum, this.pref}) : super(key: key);
  final prefNum;
  final pref;

  @override
  State<LibraryCity> createState() => _LibraryCityState();
}

class _LibraryCityState extends State<LibraryCity> {
  String cityName = "";

  setCityName(payload) {
    setState(() {
      cityName = payload;
      print(cityName);
    });
  }

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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        shrinkWrap: true,
        itemCount: widget.pref[0][widget.prefNum]['city'].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // primary: colorList[index % colorList.length],
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    setCityName(
                        widget.pref[0][widget.prefNum]["city"][index]['city']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultLibrary(
                              cityName: cityName)),
                    );
                  },
                  child: Text(
                    widget.pref[0][widget.prefNum]["city"][index]['city'],
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
