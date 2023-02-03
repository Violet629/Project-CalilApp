import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class book extends StatefulWidget {
  const book({Key? key}) : super(key: key);

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  @override
  Widget build(BuildContext context) {
    // var key = "AIzaSyBanuYuNspsCt4DMFPIr4YeFBGtY_8usc8";
    var inputData = "";
    var searchOption = "";
    var bookData = [];

    setOption(payload) {
      if (payload == 0) {
        searchOption = "intitle";
      } else if (payload == 1) {
        searchOption = "inauthor";
      } else if (payload == 2) {
        searchOption = "isbn";
      }
    }

    getBookData() async {
      var result = await http.get(Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=$searchOption:$inputData'));
      setState(() {
        bookData = [jsonDecode(result.body)];
        // print(bookData[0]['items'][0]['volumeInfo']['industryIdentifiers']);
        print(bookData[0]['items'][0]['volumeInfo']['imageLinks']);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("本を探す"),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        backgroundColor: Color(0xff00b8ee),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextField(
                style: TextStyle(fontSize: 20),
                onChanged: (value) {
                  inputData = value;
                },
                onSubmitted: (context) {
                  getBookData();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue.shade100,
                  prefixIcon: Icon(Icons.search),
                  hintText: '検索',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: ToggleSwitch(
                activeBgColor: const [Color(0xff00b8ee)],
                minWidth: 130,
                fontSize: 22,
                initialLabelIndex: 0,
                totalSwitches: 3,
                labels: const ['タイトル', '著者名', 'ISBN'],
                onToggle: (index) {
                  setOption(index);
                },
              ),
            ),
            Container(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Image.network(
                          'http://books.google.com/books/content?id=VZKCzwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: const [
                            Text("title"),
                            Text("著者名"),
                            Text("ISBN"),
                            Text("link"),
                            Text("お気に入り"),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
