import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:conic/pages/search/widgets/widgets.dart';
import 'package:conic/shared_widgets/shared_widgets.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
  final int _kTabCount = 2;
}

class _SearchState extends State<Search>
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
          CoinExchangeAppBar(tabController: tabController,showSearch: false,),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              physics: BouncingScrollPhysics(),
              children: [
                CoinSearch(),
                ExchangesSearch(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
