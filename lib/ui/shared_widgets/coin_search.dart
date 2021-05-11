import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/models/models.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
typedef void onCoinPressed({required String id});

class CoinSearch extends StatefulWidget {
  final bool hasArrow;
  final onCoinPressed onPressed;
  const CoinSearch({
    Key? key,
    required this.onPressed,
    this.hasArrow = false,
  }) : super(key: key);

  @override
  _CoinSearchState createState() => _CoinSearchState();
}

class _CoinSearchState extends State<CoinSearch> {
  String searchText = '';
  final _textController = TextEditingController();

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
        backgroundColor: Theme.of(context).backgroundColor,
        body: BlocBuilder<SearchPageDataCubit, GenericPageStete<SearchData>>(
          builder: (context, state) {
            if (state.isLoading || state.isError) {
              return SearchShimmer();
            } else {
              final data = state.data!.simpleCoins!
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
                      color: Theme.of(context).chipTheme.backgroundColor,
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
                          onTap: () {
                            widget.onPressed(
                              id: data[index].id,
                            );
                          },
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
                          trailing: widget.hasArrow
                              ? Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Theme.of(context).cardColor,
                                )
                              : SizedBox(),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 44,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 10,
                                ),
                                child: Center(
                                  child: Text(
                                    data[index].symbol,
                                    style: TextStyle(fontSize: 8),
                                  ),
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
