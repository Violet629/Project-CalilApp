import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class ResultLibrary extends StatefulWidget {
  const ResultLibrary({Key? key, this.cityName}) : super(key: key);
  final cityName;

  @override
  State<ResultLibrary> createState() => _ResultLibraryState();
}

class _ResultLibraryState extends State<ResultLibrary> {
  String key = "419e52784761e9f60fa6683a2f28e41e";
  List<dynamic> librayData = [];

  getBookData() async {
    var result = await http.get(Uri.parse(
        'https://api.calil.jp/library?appkey=$key&format=json&callback=&city=${widget.cityName}'));
    librayData.clear();
    if (result.statusCode == 200) {
      setState(() {
        var result2 = [jsonDecode(result.body)];
        // librayData = result2[0]['Items'];
        print(result2);
      });
    } else {
      librayData.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    getBookData();
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
      body: Text("context.watch<Store1>().name"),
    );
  }
}
