import 'dart:convert';

class SimplePrice {
  final String currency;
  final double price;
  final double? volIn24h;
  final double? usdMarketCap;
  final double? changeIn24h;
  final DateTime lastUpdatedAt;

  SimplePrice({
    required this.currency,
    required this.price,
    this.usdMarketCap,
    this.volIn24h,
    this.changeIn24h,
    required int lastUpdatedAt,
  }) : lastUpdatedAt =
            DateTime.fromMillisecondsSinceEpoch(1000 * lastUpdatedAt);

  factory SimplePrice.fromMap(Map<String, dynamic> map) {
    final String currency = map['currency'];
    return SimplePrice(
      currency: currency,
      price: map[currency],
      usdMarketCap: map['${currency}_market_cap'],
      volIn24h: map['${currency}_24h_vol'],
      changeIn24h: map['${currency}_24h_change'],
      lastUpdatedAt: map['last_updated_at'] as int,
    );
  }

  factory SimplePrice.fromJson(String source) =>
      SimplePrice.fromMap(json.decode(source));
}
