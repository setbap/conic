import 'package:flutter/foundation.dart';

import 'package:conic/models/models.dart';

class SearchData {
  List<SimpleExchange>? simpleExchanges;
  List<SimpleCoin>? simpleCoins;
  SearchData({
    this.simpleExchanges,
    this.simpleCoins,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchData &&
        listEquals(other.simpleExchanges, simpleExchanges) &&
        listEquals(other.simpleCoins, simpleCoins);
  }

  @override
  int get hashCode => simpleExchanges.hashCode ^ simpleCoins.hashCode;
}
