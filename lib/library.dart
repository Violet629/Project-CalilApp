import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:kariru/store.dart';
import 'package:kariru/resultLibrary.dart';
import 'package:kariru/book.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/link.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  // List prefCityList = [];
  // String prefNum = "";
  // List<Color> colorList = [
  //   Colors.lightBlueAccent,
  //   Colors.lightBlue,
  //   Colors.blue,
  //   Colors.blueAccent,
  // ];
  //
  // setPrefNum(payload) {
  //   setState(() {
  //     prefNum = payload;
  //     print(prefNum);
  //   });
  // }
  //
  // Future<void> readJson() async {
  //   final String response =
  //       await rootBundle.loadString('assets/pref_city.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     prefCityList = [data[0]];
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   readJson();
  // }

  @override
  Widget build(BuildContext context) {
    final Store store = Provider.of<Store>(context, listen: true);
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset(
      //     'assets/calil_logo_black.png',
      //     width: 170,
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.lightBlueAccent,
      // ),
      // body: ListView.builder(
      //   padding: const EdgeInsets.symmetric(horizontal: 2.5),
      //   shrinkWrap: true,
      //   itemCount: prefCityList[0].length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //       margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
      //       padding: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
      //       child: Column(
      //         children: [
      //           ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               primary: colorList[index % colorList.length],
      //               minimumSize: const Size.fromHeight(50), // NEW
      //             ),
      //             onPressed: () {
      //               setPrefNum('${index + 1}');
      //               store.setPerf(prefCityList[0]['${index + 1}']["name"]);
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => LibraryCity(
      //                       prefNum: prefNum, prefCityList: prefCityList),
      //                 ),
      //               );
      //             },
      //             child: Text(
      //               prefCityList[0]['${index + 1}']["name"],
      //               style: TextStyle(fontSize: 20),
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
      body: LibraryStep(),
    );
  }
}

// class LibraryCity extends StatefulWidget {
//   const LibraryCity({Key? key, this.prefNum, this.prefCityList})
//       : super(key: key);
//   final prefNum;
//   final prefCityList;
//
//   @override
//   State<LibraryCity> createState() => _LibraryCityState();
// }
//
// class _LibraryCityState extends State<LibraryCity> {
//   @override
//   Widget build(BuildContext context) {
//     final Store store = Provider.of<Store>(context, listen: true);
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Image.asset(
//       //     'assets/calil_logo_black.png',
//       //     width: 170,
//       //   ),
//       //   centerTitle: true,
//       //   automaticallyImplyLeading: false,
//       //   backgroundColor: Colors.lightBlueAccent,
//       // ),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 2.5),
//         shrinkWrap: true,
//         itemCount: widget.prefCityList[0][widget.prefNum]['city'].length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
//             padding: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
//             child: Column(
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     // primary: colorList[index % colorList.length],
//                     minimumSize: const Size.fromHeight(50), // NEW
//                   ),
//                   onPressed: () {
//                     store.setCity(widget.prefCityList[0][widget.prefNum]["city"]
//                         [index]['city']);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ResultLibrary(
//                             perfName: store.perfName, cityName: store.cityName),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     widget.prefCityList[0][widget.prefNum]["city"][index]
//                         ['city'],
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class LibraryStep extends StatefulWidget {
  const LibraryStep({Key? key}) : super(key: key);

  @override
  State<LibraryStep> createState() => _LibraryStepState();
}

class _LibraryStepState extends State<LibraryStep> {
  var step = 0;
  List prefCityList = [];
  String prefNum = "";
  List<Color> colorList = [
    Colors.lightBlueAccent,
    Colors.lightBlue,
    Colors.blue,
    Colors.blueAccent,
  ];

  // setPrefNum(payload) {
  //   setState(() {
  //     prefNum = payload;
  //     print(prefNum);
  //   });
  // }

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
                    // setPrefNum('${index + 1}');
                    // store.setPerf(prefCityList[0]['${index + 1}']["name"]);
                    setState(() {
                      prefNum = '${index + 1}';
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
                    // setCity(prefCityList[0][prefNum]["city"][index]['city']);
                    setState(() {
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
      return Text("test");
    }
  }
}
