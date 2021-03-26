import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:conic/pages/search/widgets/widgets.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
  final int _kTabCount = 2;
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
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
      child: Scaffold(
        backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: false,
            title: Container(
              width: 200,
              child: TabBar(
                physics: BouncingScrollPhysics(),
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.only(bottom: 4),
                controller: tabController,
                tabs: [
                  Text("CryptoAssets"),
                  Text("Exchanges"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: tabController,
            physics: BouncingScrollPhysics(),
            children: [
              CoinSearch(),
              ExchangeSearch(),
            ],
          )),
    );
  }
}
