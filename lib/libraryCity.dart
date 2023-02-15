import 'package:flutter/material.dart';
import 'package:kariru/resultLibrary.dart';
import 'package:provider/provider.dart';
import 'package:kariru/store.dart';

class LibraryCity extends StatefulWidget {
  const LibraryCity({Key? key, this.prefNum, this.prefCityList})
      : super(key: key);
  final prefNum;
  final prefCityList;

  @override
  State<LibraryCity> createState() => _LibraryCityState();
}

class _LibraryCityState extends State<LibraryCity> {
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
        itemCount: widget.prefCityList[0][widget.prefNum]['city'].length,
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
                    store.setCity(widget.prefCityList[0][widget.prefNum]["city"]
                        [index]['city']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultLibrary(perfName:store.perfName,cityName:store.cityName),
                      ),
                    );
                  },
                  child: Text(
                    widget.prefCityList[0][widget.prefNum]["city"][index]
                        ['city'],
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
