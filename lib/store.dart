import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Store with ChangeNotifier {
  String perfName = "";
  String cityName = "";

  void setPerf(payload) {
    perfName = payload;
    notifyListeners();
  }

  void setCity(payload) {
    cityName = payload;
    notifyListeners();
  }
}
