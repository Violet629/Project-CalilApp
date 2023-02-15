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
  List<dynamic> librayData = [];

  getLibraryData() async {
    var result = await http.get(Uri.parse(
        'https://api.calil.jp/library?appkey=$key&pref=${widget.perfName}&city=${widget.cityName}&format=json&callback=&limit=1'));
    librayData.clear();
    if (result.statusCode == 200) {
      setState(() {
        var result2 = [jsonDecode(result.body)];
        librayData = result2[0];
        print(librayData);
      });
    } else {
      librayData.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    getLibraryData();
  }

  @override
  Widget build(BuildContext context) {
    // final Store store = Provider.of<Store>(context, listen: true);
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
      body: Wrap(
        children: [
          Text(librayData[0]['formal']),
          Text(librayData[0]['tel']),
          Text(librayData[0]['address'])
        ],
      ),
    );
  }
}
