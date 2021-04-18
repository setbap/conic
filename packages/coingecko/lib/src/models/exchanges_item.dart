import 'dart:convert';
import './models.dart';

class ExchangesItem {
  ExchangesItem({
    required this.id,
    required this.name,
    this.yearEstablished,
    this.country,
    this.description,
    this.url,
    this.image,
    this.hasTradingIncentive,
    this.trustScore,
    this.trustScoreRank,
    this.tradeVolume24hBtc,
    this.tradeVolume24hBtcNormalized,
  });

  factory ExchangesItem.fromJson(Map<String, dynamic> jsonRes) => ExchangesItem(
        id: asT<String>(jsonRes['id'])!,
        name: asT<String>(jsonRes['name'])!,
        yearEstablished: asT<int?>(jsonRes['year_established']),
        country: asT<String?>(jsonRes['country']),
        description: asT<String?>(jsonRes['description']),
        url: asT<String?>(jsonRes['url']),
        image: asT<String?>(jsonRes['image']),
        hasTradingIncentive: asT<bool?>(jsonRes['has_trading_incentive']),
        trustScore: asT<int?>(jsonRes['trust_score']),
        trustScoreRank: asT<int?>(jsonRes['trust_score_rank']),
        tradeVolume24hBtc: asT<double?>(jsonRes['trade_volume_24h_btc']),
        tradeVolume24hBtcNormalized:
            asT<double?>(jsonRes['trade_volume_24h_btc_normalized']),
      );

  final String id;
  final String name;
  final int? yearEstablished;
  final String? country;
  final String? description;
  final String? url;
  final String? image;
  final bool? hasTradingIncentive;
  final int? trustScore;
  final int? trustScoreRank;
  final double? tradeVolume24hBtc;
  final double? tradeVolume24hBtcNormalized;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'year_established': yearEstablished,
        'country': country,
        'description': description,
        'url': url,
        'image': image,
        'has_trading_incentive': hasTradingIncentive,
        'trust_score': trustScore,
        'trust_score_rank': trustScoreRank,
        'trade_volume_24h_btc': tradeVolume24hBtc,
        'trade_volume_24h_btc_normalized': tradeVolume24hBtcNormalized,
      };

  ExchangesItem clone() => ExchangesItem.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
