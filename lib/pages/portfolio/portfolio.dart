import 'dart:math';
import 'package:conic/pages/portfolio/widgets/widgets.dart';
import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        PortfolioAppBar(
          price: 432,
          controller: controller,
          onPress: () {},
        ),
        PriceChange(
          change: 2,
          price: 439.21,
        ),
        SliverChartBox(),
        PortfollioTableHeader(),
        SliverToBoxAdapter(
            child: Divider(
          thickness: 3,
        )),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) => PortfolioTableDataRow(
              imageSrc:
                  'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png',
              price: 100,
              id: 'btc',
              name: 'bitcoin',
              change: Random().nextDouble() - 0.5,
              coinCount: 12,
              onPress: () {},
            ),
            childCount: 5,
          ),
        ),
        SliverToBoxAdapter(
          child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () {},
          ),
        ),
        SliverPadding(padding: EdgeInsets.only(top: 100))
      ],
    );
  }
}
