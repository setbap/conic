import 'dart:convert';
import 'package:conic/models/models.dart';
import 'package:conic/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<SimpleExchange> parseExchanges(String string) {
  final parsed = jsonDecode(string).cast<Map<String, dynamic>>();
  return parsed.map<SimpleExchange>((json) => SimpleExchange.fromMap(json)).toList();
}

class ExchangeSearch extends StatefulWidget {
  @override
  _ExchangeSearchState createState() => _ExchangeSearchState();
}

class _ExchangeSearchState extends State<ExchangeSearch> {
  String searchText = '';
  final _textController = TextEditingController();
  Future<List<SimpleExchange>> fetchExchanges() async {
    final String response = await rootBundle.loadString('assets/exchanges.json');
    return compute(parseExchanges, response);
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
        body: FutureBuilder<List<SimpleExchange>>(
          future: fetchExchanges(),
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
                    element.marketType.toLowerCase().startsWith(
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
                        hintText: "Exchange name or id or market type",
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
                          title: Text(
                            data[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            data[index].id,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: DarkForeground,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 10,
                            ),
                            child: Text(
                              data[index].marketType,
                              style: TextStyle(fontSize: 10),
                            ),
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
