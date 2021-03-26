import 'package:conic/pages/index/widgets/widgets.dart';
import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  final CupertinoTabController controller;

  const Index({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("Index"),
          pinned: true,
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
            controller.index = 1;
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
            controller.index = 3;
          },
        ),
        IndexNewsList(),
        SeeAllNews(onPress: () {
          controller.index = 3;
        }),
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 50),
        )
      ],
    );
  }
}
