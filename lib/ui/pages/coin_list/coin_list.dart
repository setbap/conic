import 'dart:math';
import 'package:conic/ui/pages/coin_list/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinList extends StatefulWidget {
  @override
  _CoinListState createState() => _CoinListState();
  final int _kTabCount = 2;
}

class _CoinListState extends State<CoinList>
    with SingleTickerProviderStateMixin {
  late final tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(vsync: this, length: widget._kTabCount, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget._kTabCount,
      child: CustomScrollView(
        slivers: [
          CoinExchangeAppBar(tabController: tabController),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 94,
                      top: 16,
                    ),
                    itemBuilder: (context, index) {
                      return LoadingShimmer(
                        loading: true,
                        loadingWidget: CoinListItemLoading(),
                        dataWidget: CoinListItemData(
                          imageSrc:
                              'https://s2.coinmarketcap.com/static/img/coins/64x64/$index.png',
                          name: 'bitcoin',
                          chartSrc:
                              'https://s3.coinmarketcap.com/generated/sparklines/web/7d/usd/1.png',
                          change: Random().nextDouble() * 10 - 5,
                          id: 'btc',
                          marketCap: 123123123,
                          price: 1234,
                          rank: index,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: 20,
                  ),
                ),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
