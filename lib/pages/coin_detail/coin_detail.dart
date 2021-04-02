import 'package:conic/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatefulWidget {
  const CoinDetail({Key? key,required this.id}) : super(key: key);

  static String route({required String id}) => "/coin/$id";
  static String get routeRegEx => "/coin/:id";
  final String id;

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
          child: PriceData(),
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
          child: MarketState(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16, right: 8, left: 8),
            child: Divider(
              color: DarkForeground,
            ),
          ),
        ),
        CoinAbout(),
        SliverToBoxAdapter(
          child: Container(
            height: 120,
          ),
        ),
      ],
    );
  }
}
