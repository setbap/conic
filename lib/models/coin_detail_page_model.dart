import 'package:coingecko/coingecko.dart';

class CoinDetailPageDataModel {
  final TopCoin coinPrice;
  final CoinDecription coinDecription;

  const CoinDetailPageDataModel({
    required this.coinDecription,
    required this.coinPrice,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoinDetailPageDataModel &&
        other.coinPrice == coinPrice &&
        other.coinDecription == coinDecription;
  }

  @override
  int get hashCode => coinPrice.hashCode ^ coinDecription.hashCode;
}
