import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';

class CoinSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BoxTextTitle(
          title: "Top Coins",
          onPressSeeAll: () {},
        ),
        TopCoinList(),
      ],
    );
  }
}
