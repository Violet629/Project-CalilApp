import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/link.dart';

class ResultLibrary extends StatefulWidget {
  const ResultLibrary({Key? key, this.perfName, this.cityName})
      : super(key: key);
  final perfName;
  final cityName;

  @override
  State<ResultLibrary> createState() => _ResultLibraryState();
}

class _ResultLibraryState extends State<ResultLibrary> {
  String key = "419e52784761e9f60fa6683a2f28e41e";
  List<dynamic> libraryData = [];

  getLibraryData() async {
    var result = await http.get(Uri.parse(
        'https://api.calil.jp/library?appkey=$key&pref=${widget.perfName}&city=${widget.cityName}&format=json&callback='));
    if (result.statusCode == 200) {
      setState(() {
        var result2 = [jsonDecode(result.body)];
        libraryData = result2[0];
        print(libraryData);
      });
    } else {
      libraryData.clear();
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
      appBar: AppBar(
        title: Image.asset(
          'assets/calil_logo_black.png',
          width: 170,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: LibraryList(
        libraryData: libraryData,
      ),
    );
  }
}

class LibraryList extends StatelessWidget {
  const LibraryList({Key? key, this.libraryData}) : super(key: key);
  final libraryData;

  @override
  Widget build(BuildContext context) {
    if (libraryData.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        shrinkWrap: true,
        itemCount: libraryData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LibraryDetail(libraryData: libraryData, index: index),
                ),
              );
            },
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: Image.asset(
                        'assets/${libraryData[index]['category']}.png',
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
                            libraryData[index]['formal'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            libraryData[index]['pref'] +
                                libraryData[index]['city'],
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
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

class LibraryDetail extends StatelessWidget {
  const LibraryDetail({Key? key, this.libraryData, this.index})
      : super(key: key);
  final libraryData;
  final index;

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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.asset(
              'assets/libraryImg/library${index % 10 + 1}.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            libraryData[index]['formal'],
            style: TextStyle(fontSize: 18),
          ),
          Text(
            libraryData[index]['address'],
            style: TextStyle(fontSize: 18),
          ),
          Text(
            libraryData[index]['tel'],
            style: TextStyle(fontSize: 18),
          ),
          Link(
            // 開きたいWebページのURLを指定
            uri: Uri.parse('${libraryData[index]['url_pc']}'),
            // targetについては後述
            target: LinkTarget.blank,
            builder: (BuildContext ctx, FollowLink? openLink) {
              return TextButton(
                onPressed: openLink,
                child: const Text(
                  'Webサイト',
                  style: TextStyle(fontSize: 18),
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  // minimumSize:
                  //     MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
