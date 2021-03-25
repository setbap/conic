import 'package:conic/pages/coin_list/widgets/widgets.dart';
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
          CoinListAppBar(tabController: tabController),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              physics: BouncingScrollPhysics(),
              children: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
