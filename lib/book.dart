import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Book extends StatefulWidget {
  const Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  String key = "1024255125769444283";
  String inputData = "";
  String searchOption = "title";
  List<dynamic> bookData = [];

  setOption(payload) {
    if (payload == 0) {
      searchOption = "title";
    } else if (payload == 1) {
      searchOption = "author";
    } else if (payload == 2) {
      searchOption = "isbn";
    }
  }

  getBookData() async {
    var result = await http.get(Uri.parse(
        'https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?applicationId=$key&$searchOption=$inputData'));
    bookData.clear();
    if (result.statusCode == 200) {
      setState(() {
        var result2 = [jsonDecode(result.body)];
        bookData = result2[0]['Items'];
        print(bookData[0]['Item']['largeImageUrl']);
      });
    } else {
      bookData.clear();
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
            BookList(bookData: bookData),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _selectedIndex,
        // onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '地域'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '周を探す'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '本'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'お気入り'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class BookList extends StatelessWidget {
  const BookList({Key? key, this.bookData}) : super(key: key);
  final bookData;

  @override
  Widget build(BuildContext context) {
    if (bookData.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            height: 250,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0x66000000)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Image.network(
                      bookData[index]['Item']['largeImageUrl'],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          bookData[index]['Item']['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            bookData[index]['Item']['author'],
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            '発売日 | ${bookData[index]['Item']['salesDate']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            'ISBN | ${bookData[index]['Item']['isbn']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      return Text("探している本がありません。");
    }
  }
}
