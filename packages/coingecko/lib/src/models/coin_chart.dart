import 'dart:convert';
import 'package:coingecko/coingecko.dart';

class CoinChartTimeData {
  final DateTime time;
  final double price;

  CoinChartTimeData({required int timeInMilisecond, required this.price})
      : time = DateTime.fromMillisecondsSinceEpoch(timeInMilisecond);
}

class CoinChart {
  CoinChart({
    this.prices,
  });

  factory CoinChart.fromJson(Map<String, dynamic> jsonRes) {
    print("ffffuckk");
    final List<CoinChartTimeData>? prices =
        jsonRes['prices'] is List ? <CoinChartTimeData>[] : null;
    if (prices != null) {
      for (final dynamic item0 in asT<List<dynamic>>(jsonRes['prices'])!) {
        print(item0);
        if (item0 != null) {
          final item0nn = asT<List<dynamic>>(item0)!;
          prices.add(
            CoinChartTimeData(
              price: item0nn[1],
              timeInMilisecond: item0nn[0],
            ),
          );
        }
      }
    }
    return CoinChart(
      prices: prices,
    );
  }

  final List<CoinChartTimeData>? prices;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'prices': prices,
      };

  CoinChart clone() => CoinChart.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
