import 'package:flutter/material.dart';
import 'package:kariru/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/link.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ResultLibrary extends StatefulWidget {
  const ResultLibrary({Key? key, this.prefName, this.cityName})
      : super(key: key);
  final prefName;
  final cityName;

  @override
  State<ResultLibrary> createState() => _ResultLibraryState();
}

class _ResultLibraryState extends State<ResultLibrary> {
  String key = "419e52784761e9f60fa6683a2f28e41e";
  List<dynamic> libraryData = [];

  getLibraryData() async {
    var result = await http.get(Uri.parse(
        'https://api.calil.jp/library?appkey=$key&pref=${widget.prefName}&city=${widget.cityName}&format=json&callback='));
    if (result.statusCode == 200) {
      setState(() {
        var result2 = [jsonDecode(result.body)];
        libraryData = result2[0];
        print(libraryData);
      });
    } else {
      libraryData.add("no");
    }
  }

  @override
  void initState() {
    super.initState();
    getLibraryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LibraryList(
        libraryData: libraryData,
      ),
    );
  }
}

class LibraryList extends StatefulWidget {
  const LibraryList({Key? key, this.libraryData}) : super(key: key);
  final libraryData;

  @override
  State<LibraryList> createState() => _LibraryListState();
}

class _LibraryListState extends State<LibraryList> {
  int step = 0;
  int libraryIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.libraryData.isNotEmpty && step == 0) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        shrinkWrap: true,
        itemCount: widget.libraryData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                libraryIndex = index;
                step++;
              });
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0x66000000),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: Image.asset(
                        'assets/${widget.libraryData[index]['category']}.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            widget.libraryData[index]['formal'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            widget.libraryData[index]['pref'] +
                                widget.libraryData[index]['city'],
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (widget.libraryData.isNotEmpty && step == 1) {
      return LibraryDetail(
        libraryData: widget.libraryData,
        libraryIndex: libraryIndex,
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.lightBlueAccent,
        ),
      );
    }
  }
}

class LibraryDetail extends StatefulWidget {
  const LibraryDetail({Key? key, this.libraryData, this.libraryIndex})
      : super(key: key);
  final libraryData;
  final libraryIndex;

  @override
  State<LibraryDetail> createState() => _LibraryDetailState();
}

class _LibraryDetailState extends State<LibraryDetail> {
  String geocode = "";
  List geocodeSplit = [];
  String latitude = "";
  String longitude = "";

  getGecode() {
    setState(() {
      geocode = widget.libraryData[widget.libraryIndex]['geocode'];
      geocodeSplit = geocode.split(',');
      latitude = geocodeSplit[1];
      longitude = geocodeSplit[0];
      print(latitude + "," + longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    getGecode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(latitude), double.parse(longitude)),
                zoom: 19,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("marker1"),
                  position:
                      LatLng(double.parse(latitude), double.parse(longitude)),
                ),
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 1, 15, 5),
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.libraryData[widget.libraryIndex]['formal'],
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  widget.libraryData[widget.libraryIndex]['address'],
                  style: TextStyle(fontSize: 18),
                ),
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    "〒" +
                        widget.libraryData[widget.libraryIndex]['post'] +
                        " / " +
                        widget.libraryData[widget.libraryIndex]['tel'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Link(
                  uri: Uri.parse(
                      '${widget.libraryData[widget.libraryIndex]['url_pc']}'),
                  target: LinkTarget.blank,
                  builder: (BuildContext ctx, FollowLink? openLink) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        minimumSize: const Size(330, 50),
                      ),
                      onPressed: openLink,
                      child: const Text(
                        '公式ホームページ',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    minimumSize: const Size(330, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Book()),
                    );
                  },
                  child: const Text(
                    "蔵書検索",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    minimumSize: const Size(330, 50),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "お気に入り登録",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
