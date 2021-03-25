import 'package:conic/pages/index/widgets/widgets.dart';
import 'package:conic/pages/news/widgest/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        NewsAppBarSliver(),
        BoxTextTitle(
          title: "News Cardano",
          subTitle: "Last News About Cardano",
          onPressSeeAll: () {},
        ),
        IndexNewsList(),
        SeeAllNews(onPress: () {}),
        BoxTextTitle(
          title: "News Cake",
          subTitle: "Last News About Cake",
          onPressSeeAll: () {},
        ),
        IndexNewsList(),
        SeeAllNews(onPress: () {}),
        BoxTextTitle(
          title: "News Cardano",
          subTitle: "Last News About BitCoin",
          onPressSeeAll: () {},
        ),
        IndexNewsList(),
        SeeAllNews(onPress: () {}),
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 50),
        )
      ],
    );
  }
}
