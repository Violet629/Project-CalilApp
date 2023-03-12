import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:kariru/resultLibrary.dart';
import 'dart:convert';

class LibraryGps extends StatefulWidget {
  const LibraryGps({Key? key}) : super(key: key);

  @override
  State<LibraryGps> createState() => LibraryGpsState();
}

class LibraryGpsState extends State<LibraryGps> {
  String _latitude = "NoData";
  String _longitude = "NoData";
  String key = "419e52784761e9f60fa6683a2f28e41e";
  List<dynamic> libraryData = [];

  Future<void> getLocation() async {
    // 権限を取得
    LocationPermission permission = await Geolocator.requestPermission();
    // 権限がない場合は戻る
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }
    // 位置情報を取得
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(
      () {
        // 北緯がプラス、南緯がマイナス
        _latitude = position.latitude.toStringAsFixed(2);
        // 東経がプラス、西経がマイナス
        _longitude = position.longitude.toStringAsFixed(2);
        getLibraryData();
      },
    );
  }

  getLibraryData() async {
    var result = await http.get(Uri.parse(
        'https://api.calil.jp/library?appkey=$key&geocode=$_longitude,$_latitude&format=json&callback='));
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
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LibraryList(libraryData: libraryData),
    );
  }
}
