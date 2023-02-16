import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:provider/provider.dart';
// import 'package:kariru/store.dart';

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
        body: LibraryList(libraryData: libraryData));
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
          return Container(
            child: Column(
              children: [Text(index.toString())],
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
