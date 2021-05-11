import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeSearch extends StatefulWidget {
  @override
  _ExchangeSearchState createState() => _ExchangeSearchState();
}

class _ExchangeSearchState extends State<ExchangeSearch> {
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
              final data = state.data!.simpleExchanges!
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
                      color: Theme.of(context).chipTheme.backgroundColor,
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
                              color: Theme.of(context).canvasColor,
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
