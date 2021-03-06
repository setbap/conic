import 'package:coingecko/coingecko.dart';
import 'package:flutter/foundation.dart';

import 'package:conic/models/hive_models/hive_modals.dart';

class CoinCountWithSparkLineList {
  final List<double> sparkLineList;
  final double coinCount;
  const CoinCountWithSparkLineList({
    required this.sparkLineList,
    required this.coinCount,
  });
}

List<double> sumList(List<CoinCountWithSparkLineList>? sparks) {
  if (sparks == null) return [];
  int biggestLen = 0;
  sparks.forEach((data) {
    if (data.sparkLineList.length > biggestLen)
      biggestLen = data.sparkLineList.length;
  });
  List<double> allSum = List.generate(biggestLen, (_) => 0);
  for (int i = 0; i < sparks.length; i++) {
    final spark = sparks[i].sparkLineList;
    final count = sparks[i].coinCount;
    for (int d = 0; d < spark.length; d++) {
      allSum[d] += spark[d] * count;
    }
  }

  return allSum;
}

class PortfolioPageDataModel {
  final List<TopCoin> coinsList;
  final Map<String, PortfolioStorage> portfolio;
  List<double> sparkLine = [];
  double currentPrice = 0;
  double oldPrice = 0;
  double priceChange = 0;

  PortfolioPageDataModel({
    required this.coinsList,
    required this.portfolio,
  }) {
    List<CoinCountWithSparkLineList> sparks = [];
    for (var i = 0; i < coinsList.length; i++) {
      sparks.add(CoinCountWithSparkLineList(
        coinCount: portfolio[coinsList[i].id]?.count ?? 1,
        sparkLineList: coinsList[i].sparklineIn7d?.price ?? [],
      ));
      this.currentPrice +=
          coinsList[i].currentPrice! * portfolio[coinsList[i].id]!.count;
      this.oldPrice += portfolio[coinsList[i].id]!.price;
    }
    this.priceChange = currentPrice - oldPrice;
    this.sparkLine = sumList(sparks);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PortfolioPageDataModel &&
        listEquals(other.coinsList, coinsList) &&
        listEquals(other.sparkLine, sparkLine);
  }

  @override
  int get hashCode => coinsList.hashCode ^ sparkLine.hashCode;
}
