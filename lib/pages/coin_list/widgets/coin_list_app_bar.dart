import 'package:flutter/material.dart';

class CoinListAppBar extends StatelessWidget {
  const CoinListAppBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      pinned: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
      title: Container(
        width: 220,
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
    );
  }
}
