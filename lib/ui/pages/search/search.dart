import 'package:conic/ui/pages/coin_detail/coin_detail.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:conic/ui/pages/search/widgets/widgets.dart';

class Search extends StatefulWidget {
  static const String route = "/search";
  static String get routeRegEx => "/search";
  @override
  _SearchState createState() => _SearchState();
  final int _kTabCount = 2;
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  late final tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: widget._kTabCount,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget._kTabCount,
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: BackButton(),
            centerTitle: true,
            title: Container(
              width: 200,
              child: TabBar(
                physics: BouncingScrollPhysics(),
                indicatorColor: Theme.of(context).primaryColor,
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
              CoinSearch(
                onPressed: ({required id}) {
                  Navigator.pushNamed(
                    context,
                    CoinDetail.route,
                    arguments: id,
                  );
                },
              ),
              ExchangeSearch(),
            ],
          )),
    );
  }
}
