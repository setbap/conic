import 'dart:convert';
import 'package:conic/models/models.dart';
import 'package:conic/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<SimpleCoin> parseCoins(String string) {
  final parsed = jsonDecode(string).cast<Map<String, dynamic>>();
  return parsed.map<SimpleCoin>((json) => SimpleCoin.fromMap(json)).toList();
}

class CoinSearch extends StatefulWidget {
  final bool hasArrow;

  const CoinSearch({
    Key? key,
    this.hasArrow = false,
  }) : super(key: key);

  @override
  _CoinSearchState createState() => _CoinSearchState();
}

class _CoinSearchState extends State<CoinSearch> {
  String searchText = '';
  final _textController = TextEditingController();
  Future<List<SimpleCoin>> fetchCoins() async {
    final String response = await rootBundle.loadString('assets/coins.json');
    return compute(parseCoins, response);
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        searchText = _textController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<List<SimpleCoin>>(
          future: fetchCoins(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              final data = snapshot.data!
                  .where(
                    (element) =>
                        element.name
                            .toLowerCase()
                            .startsWith(searchText.toLowerCase()) ||
                        element.id
                            .toLowerCase()
                            .startsWith(searchText.toLowerCase()) ||
                        element.symbol.toLowerCase().startsWith(
                              searchText.toLowerCase(),
                            ),
                  )
                  .toList();
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: DarkForeground,
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        hintText: "coin name or id or symbol",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                          gapPadding: 0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              data[index].largeThumb,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            radius: 16,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              data[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          trailing:widget.hasArrow? Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: Colors.white,
                          ):SizedBox(),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: DarkForeground,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  data[index].symbol,
                                  style: TextStyle(fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
