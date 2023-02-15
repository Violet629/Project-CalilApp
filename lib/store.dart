import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Store with ChangeNotifier {
  String perfName = "";
  String cityName = "";
  String key = "419e52784761e9f60fa6683a2f28e41e";

  void setPerf(payload) {
    perfName = payload;
    notifyListeners();
  }

  void setCity(payload) {
    cityName = payload;
    notifyListeners();
  }
}
