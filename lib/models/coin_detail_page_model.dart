import 'package:coingecko/coingecko.dart';

class CoinDetailPageDataModel {
  final TopCoin coinPrice;
  final CoinDecription coinDecription;
  final CoinChart oneDayChartData;
  final CoinChart sevenDayChartData;
  final CoinChart thirtyDayChartData;
  final CoinChart allTimeChartData;

  const CoinDetailPageDataModel({
    required this.coinDecription,
    required this.coinPrice,
    required this.oneDayChartData,
    required this.sevenDayChartData,
    required this.thirtyDayChartData,
    required this.allTimeChartData,
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
