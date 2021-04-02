import 'package:conic/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatefulWidget {
  @override
  _CoinDetailState createState() => _CoinDetailState();
}

class _CoinDetailState extends State<CoinDetail> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      physics: BouncingScrollPhysics(),
      slivers: [
        CoinDetailAppBar(
          controller: _controller,
        ),
        PriceChange(),
        SliverChartBox(),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Ads", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
        SliverPadding(padding: EdgeInsets.all(8)),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text(
              "Price (1H)",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: PriceData(
            open: 1,
            high: 1,
            average: 1,
            close: 1,
            low: 1,
            change: 1,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text(
              "Market State",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: MarketState(
            mktCap: 4,
            circSupply: 4,
            totSupply: 4,
            rank: 4,
            volIn24h: 4,
            maxSupply: 4,
            roi: 4,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16, right: 8, left: 8),
            child: Divider(
              color: DarkForeground,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About Coin",
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 12,
                ),
                ExpansionTile(
                  title: Text("What is VECHAIN"),
                  leading: Icon(Icons.add_circle_outlined),
                  childrenPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    Text(
                        "lorem adha siud aa oasd pASYD asdpYASPD  ya sdpAYS DPUCL HCIU DH"),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        customChip("test"),
                        customChip("asda"),
                        customChip("test"),
                      ],
                    ),
                  ],
                ),
                Divider(),
                ListTile(
                  title: Text("What is VECHAIN"),
                  leading: Icon(Icons.add_circle_outlined),
                ),
                Divider(),
                ListTile(
                  title: Text("Reddit"),
                  leading: Icon(Icons.add_circle_outlined),
                ),
                Divider(),
                ListTile(
                  title: Text("Source"),
                  leading: Icon(Icons.add_circle_outlined),
                ),
                Divider(),
                ListTile(
                  title: Text("Twitter"),
                  leading: Icon(Icons.add_circle_outlined),
                ),
                Divider(),
                ListTile(
                  title: Text("Chat"),
                  leading: Icon(Icons.add_circle_outlined),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 120,
          ),
        ),
      ],
    );
  }

  Chip customChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: DarkForeground,
          ),
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
