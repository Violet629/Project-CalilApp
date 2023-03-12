import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Store with ChangeNotifier {
  int bottomNavIndex = 0;
  int step = 0;

  void setBottomNavIndex(payload) {
    step = 0;
    bottomNavIndex = payload;
    notifyListeners();
  }

  void minusStep() {
    if (step == 0) {
      return;
    } else {
      step--;
    }
    print(step);
    notifyListeners();
  }

  void plusStep() {
    step++;
    print(step);
    notifyListeners();
  }

  void plus2Step() {
    step = 2;
    print(step);
    notifyListeners();
  }

  void resetStep() {
    step = 0;
    print(step);
    notifyListeners();
  }
}
