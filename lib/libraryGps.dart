import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LibraryGps extends StatefulWidget {
  const LibraryGps({Key? key}) : super(key: key);

  @override
  State<LibraryGps> createState() => LibraryGpsState();
}

class LibraryGpsState extends State<LibraryGps> {
  final Completer<GoogleMapController> _controller = Completer();
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: getLocation,
            child: const Text(
              "周りを検索",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
// body: GoogleMap(
//   mapType: MapType.hybrid,
//   initialCameraPosition: _kGooglePlex,
//   onMapCreated: (GoogleMapController controller) {
//     _controller.complete(controller);
//   },
// ),
// static const CameraPosition _kGooglePlex = CameraPosition(
//   target: LatLng(35.71574708017275, 139.6086487826241),
//   zoom: 35,
// );
