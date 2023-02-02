import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class book extends StatelessWidget {
  const book({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inputData = "";

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
                  // print(inputData);
                },
                onSubmitted: (context) {
                  print(inputData);
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
                  print('switched to: $index');
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                direction: Axis.horizontal,
                runSpacing: 20,
                children: [
                  Row(
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
                  ),
                  Row(
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
                  ),
                  Row(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
