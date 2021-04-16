import 'package:coingecko/coingecko.dart';
import 'package:cryptopanic/cryptopanic.dart';
import 'package:flutter/foundation.dart';

class IndexPageDataModel {
  final NewsApiResualt newsApiResualt;
  final List<TopCoin> topCoinList;
  final TrendigCoins trendigCoins;

  const IndexPageDataModel({
    required this.newsApiResualt,
    required this.topCoinList,
    required this.trendigCoins,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IndexPageDataModel &&
        other.newsApiResualt == newsApiResualt &&
        listEquals(other.topCoinList, topCoinList) &&
        other.trendigCoins == trendigCoins;
  }

  @override
  int get hashCode =>
      newsApiResualt.hashCode ^ topCoinList.hashCode ^ trendigCoins.hashCode;
}
