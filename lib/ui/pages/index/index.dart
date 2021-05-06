import 'package:coingecko/coingecko.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/ui/pages/coin_detail/coin_detail.dart';
import 'package:conic/ui/pages/index/widgets/widgets.dart';
import 'package:conic/ui/pages/search/search.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Index extends StatelessWidget {
  final CupertinoTabController controller;

  const Index({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IndexPageDataCubit, IndexPageDataState>(
        listenWhen: (previous, current) {
      return !previous.isError && current.isError;
    }, listener: (context, state) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Text('an Error with you connection'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('dismiss'),
            ),
            TextButton(
              onPressed: () {
                context.read<IndexPageDataCubit>().getIndexData();
                Navigator.pop(context);
              },
              child: Text(
                'retry',
                style: TextStyle(color: Theme.of(context).cardColor),
              ),
            ),
          ],
        ),
      );
    }, builder: (context, state) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Index"),
            pinned: true,
            actions: [
              CupertinoButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Search.route,
                  );
                },
                child: Icon(
                  Icons.search_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
              )
            ],
          ),
          IndexToolsList(),
          BoxTextTitle(
            title: "Top 10 Coins",
            onPressSeeAll: () {
              controller.index = 1;
            },
          ),
          TopCoinList<TopCoin>(
            data: state.data?.topCoinList ?? [],
            isLoading: state.isLoading || state.isError,
            dataBuilder: (data) => CoinSquare(
              onPress: () {
                Navigator.pushNamed(
                  context,
                  CoinDetail.route,
                  arguments: data.id,
                );
              },
              change: data.priceChange24h ?? 0,
              coinName: data.name,
              imgSrc: data.image ?? "",
              price: data.currentPrice ?? 0,
            ),
          ),
          SliverPadding(padding: EdgeInsets.all(12)),
          BoxTextTitle(
            title: "Most Searched Coins",
            subTitle: "Based on Top search in last 24h",
          ),
          TopCoinList<Coins>(
            isLoading: state.isLoading || state.isError,
            data: state.data?.trendigCoins.coins ?? [],
            dataBuilder: (data) => CoinSquare(
              onPress: () {
                Navigator.pushNamed(
                  context,
                  CoinDetail.route,
                  arguments: data.item.id,
                );
              },
              change: data.item.score.toDouble(),
              coinName: data.item.name,
              imgSrc: data.item.large,
              price: data.item.marketCapRank.toDouble(),
            ),
          ),
          BoxTextTitle(
            title: "News",
            subTitle: "Last trend and breakding news",
            onPressSeeAll: () {
              controller.index = 3;
            },
          ),
          IndexNewsList(
            data: state.data != null
                ? state.data!.newsApiResualt.results.take(6).toList()
                : [],
            isLoading: state.isLoading || state.isError,
          ),
          SeeAllNews(onPress: () {
            controller.index = 3;
          }),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 54),
          )
        ],
      );
    });
  }
}
