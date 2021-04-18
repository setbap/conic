import 'package:coingecko/coingecko.dart';
import 'package:flutter/foundation.dart';

class ListPageDataModel {
  final List<TopCoin> topCoinList;
  final List<ExchangesItem> topExchangeList;

  const ListPageDataModel({
    required this.topCoinList,
    required this.topExchangeList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListPageDataModel &&
        listEquals(other.topCoinList, topCoinList) &&
        listEquals(other.topExchangeList, topExchangeList);
  }

  @override
  int get hashCode => topCoinList.hashCode ^ topExchangeList.hashCode;
}
