import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  var test = "";

  reDing() async {
    var storage = await SharedPreferences.getInstance();
    setState(() {
      test = storage.getString('systemid').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    reDing();
  }

  @override
  Widget build(BuildContext context) {
    return Text(test);
  }
}
