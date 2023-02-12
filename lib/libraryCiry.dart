import 'package:flutter/material.dart';

// import 'dart:convert';
// import 'package:flutter/services.dart';

class LibraryCity extends StatefulWidget {
  const LibraryCity({Key? key, this.prefNum, this.pref}) : super(key: key);
  final prefNum;
  final pref;

  @override
  State<LibraryCity> createState() => _LibraryCityState();
}

class _LibraryCityState extends State<LibraryCity> {
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
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.pref[0][widget.prefNum]['city'].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            // padding: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // primary: colorList[index % colorList.length],
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {},
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
