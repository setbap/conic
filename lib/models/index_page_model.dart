import 'package:coingecko/coingecko.dart';
import 'package:flutter/foundation.dart';

class ListPageDataModel {
  final List<TopCoin> topCoinList;

  const ListPageDataModel({
    required this.topCoinList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListPageDataModel &&
        listEquals(other.topCoinList, topCoinList);
  }

  @override
  int get hashCode => topCoinList.hashCode;
}
