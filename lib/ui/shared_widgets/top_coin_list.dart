import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_square.dart';

typedef DataWidgetBuilder<T> = Widget Function(T data);

class TopCoinList<T> extends StatelessWidget {
  final bool isLoading;
  final List<T> data;
  final DataWidgetBuilder<T> dataBuilder;
  const TopCoinList({
    Key? key,
    required this.dataBuilder,
    required this.isLoading,
    this.data = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 150,
        child: LoadingShimmer(
          loading: isLoading,
          error: false,
          dataWidget: ListView(
            scrollDirection: Axis.horizontal,
            children: data.map(dataBuilder).toList(),
          ),
          loadingWidget: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CoinSquareLoading(),
            itemCount: 6,
          ),
        ),
      ),
    );
  }
}
