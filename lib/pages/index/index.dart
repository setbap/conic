import 'package:conic/pages/coin_list/coin_list.dart';
import 'package:conic/pages/index/widgets/widgets.dart';
import 'package:conic/pages/news/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("Index"),
          actions: [
            CupertinoButton(
              onPressed: () {},
              child: Icon(Icons.search_outlined),
            )
          ],
        ),
        IndexToolsList(),
        BoxTextTitle(
          title: "Top Coins",
          onPressSeeAll: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CoinList(),
              ),
            );
          },
        ),
        TopCoinList(),
        SliverPadding(padding: EdgeInsets.all(12)),
        BoxTextTitle(
          title: "Most Searched Coins",
          subTitle: "Based on Top search in last 24h",
        ),
        TopCoinList(),
        BoxTextTitle(
          title: "News",
          subTitle: "Last trend and breakding news",
          onPressSeeAll: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => News(),
              ),
            );
          },
        ),
        IndexNewsList(),
        SeeAllNews(),
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 50),
        )
      ],
    );
  }
}
