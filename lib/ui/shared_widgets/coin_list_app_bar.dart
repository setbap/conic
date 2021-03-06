import 'package:flutter/material.dart';

class CoinExchangeAppBar extends StatelessWidget {
  final bool showSearch;
  final VoidCallback onPressed;
  const CoinExchangeAppBar({
    Key? key,
    required this.onPressed,
    this.showSearch = true,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      pinned: true,
      actions: [
        showSearch
            ? IconButton(
                icon: Icon(Icons.search),
                onPressed: onPressed,
              )
            : SizedBox()
      ],
      title: Container(
        width: 220,
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
    );
  }
}
