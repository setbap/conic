import 'dart:math';
import 'package:conic/pages/coin_detail/coin_detail.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_square.dart';

class TopCoinList extends StatelessWidget {
  const TopCoinList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [1, 2, 3, 4, 5, 6, 7]
              .map(
                (item) => LoadingShimmer(
                  loading: true,
                  loadingWidget: CoinSquareLoading(),
                  dataWidget: CoinSquare(
                    onPress: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CoinDetail(),
                        ),
                      );
                    },
                    change: Random().nextDouble() * 5 - 2.5,
                    coinName: "BitCoine",
                    price: 234.323,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
