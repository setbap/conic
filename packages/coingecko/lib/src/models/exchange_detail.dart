import 'dart:convert';
import 'models.dart';

class ExchangeDetail {
  ExchangeDetail({
    required this.name,
    required this.yearEstablished,
    required this.country,
    required this.description,
    required this.url,
    required this.image,
    this.facebookUrl,
    this.redditUrl,
    this.telegramUrl,
    this.slackUrl,
    this.otherUrl1,
    this.otherUrl2,
    this.twitterHandle,
    this.hasTradingIncentive,
    required this.centralized,
    required this.publicNotice,
    this.alertNotice,
    required this.trustScore,
    required this.trustScoreRank,
    required this.tradeVolume24hBtc,
    required this.tradeVolume24hBtcNormalized,
    required this.tickers,
    required this.statusUpdates,
  });

  factory ExchangeDetail.fromJson(Map<String, dynamic> jsonRes) {
    final List<Tickers>? tickers =
        jsonRes['tickers'] is List ? <Tickers>[] : null;
    if (tickers != null) {
      for (final dynamic item in jsonRes['tickers']!) {
        if (item != null) {
          tryCatch(() {
            tickers.add(Tickers.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<StatusUpdates>? statusUpdates =
        jsonRes['status_updates'] is List ? <StatusUpdates>[] : null;
    if (statusUpdates != null) {
      for (final dynamic item in jsonRes['status_updates']!) {
        if (item != null) {
          tryCatch(() {
            statusUpdates
                .add(StatusUpdates.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return ExchangeDetail(
      name: asT<String>(jsonRes['name'])!,
      yearEstablished: asT<int>(jsonRes['year_established'])!,
      country: asT<String>(jsonRes['country'])!,
      description: asT<String>(jsonRes['description'])!,
      url: asT<String>(jsonRes['url'])!,
      image: asT<String>(jsonRes['image'])!,
      facebookUrl: asT<String?>(jsonRes['facebook_url']),
      redditUrl: asT<String?>(jsonRes['reddit_url']),
      telegramUrl: asT<String?>(jsonRes['telegram_url']),
      slackUrl: asT<String?>(jsonRes['slack_url']),
      otherUrl1: asT<String?>(jsonRes['other_url_1']),
      otherUrl2: asT<String?>(jsonRes['other_url_2']),
      twitterHandle: asT<String?>(jsonRes['twitter_handle']),
      hasTradingIncentive: asT<bool?>(jsonRes['has_trading_incentive']),
      centralized: asT<bool>(jsonRes['centralized'])!,
      publicNotice: asT<String>(jsonRes['public_notice'])!,
      alertNotice: asT<String?>(jsonRes['alert_notice']),
      trustScore: asT<int>(jsonRes['trust_score'])!,
      trustScoreRank: asT<int>(jsonRes['trust_score_rank'])!,
      tradeVolume24hBtc: asT<double>(jsonRes['trade_volume_24h_btc'])!,
      tradeVolume24hBtcNormalized:
          asT<double>(jsonRes['trade_volume_24h_btc_normalized'])!,
      tickers: tickers!,
      statusUpdates: statusUpdates!,
    );
  }

  final String name;
  final int yearEstablished;
  final String country;
  final String description;
  final String url;
  final String image;
  final String? facebookUrl;
  final String? redditUrl;
  final String? telegramUrl;
  final String? slackUrl;
  final String? otherUrl1;
  final String? otherUrl2;
  final String? twitterHandle;
  final bool? hasTradingIncentive;
  final bool centralized;
  final String publicNotice;
  final String? alertNotice;
  final int trustScore;
  final int trustScoreRank;
  final double tradeVolume24hBtc;
  final double tradeVolume24hBtcNormalized;
  final List<Tickers> tickers;
  final List<StatusUpdates> statusUpdates;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'year_established': yearEstablished,
        'country': country,
        'description': description,
        'url': url,
        'image': image,
        'facebook_url': facebookUrl,
        'reddit_url': redditUrl,
        'telegram_url': telegramUrl,
        'slack_url': slackUrl,
        'other_url_1': otherUrl1,
        'other_url_2': otherUrl2,
        'twitter_handle': twitterHandle,
        'has_trading_incentive': hasTradingIncentive,
        'centralized': centralized,
        'public_notice': publicNotice,
        'alert_notice': alertNotice,
        'trust_score': trustScore,
        'trust_score_rank': trustScoreRank,
        'trade_volume_24h_btc': tradeVolume24hBtc,
        'trade_volume_24h_btc_normalized': tradeVolume24hBtcNormalized,
        'tickers': tickers,
        'status_updates': statusUpdates,
      };

  ExchangeDetail clone() => ExchangeDetail.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Tickers {
  Tickers({
    required this.base,
    required this.target,
    required this.market,
    required this.last,
    required this.volume,
    this.convertedLast,
    this.convertedVolume,
    required this.trustScore,
    required this.bidAskSpreadPercentage,
    required this.timestamp,
    required this.lastTradedAt,
    required this.lastFetchAt,
    required this.isAnomaly,
    required this.isStale,
    this.tradeUrl,
    this.tokenInfoUrl,
    this.coinId,
    this.targetCoinId,
  });

  factory Tickers.fromJson(Map<String, dynamic> jsonRes) => Tickers(
        base: asT<String>(jsonRes['base'])!,
        target: asT<String>(jsonRes['target'])!,
        market: Market.fromJson(asT<Map<String, dynamic>>(jsonRes['market'])!),
        last: asT<double>(jsonRes['last'])!,
        volume: asT<double>(jsonRes['volume'])!,
        convertedLast: jsonRes['converted_last'] == null
            ? null
            : ConvertedLast.fromJson(
                asT<Map<String, dynamic>>(jsonRes['converted_last'])!),
        convertedVolume: jsonRes['converted_volume'] == null
            ? null
            : ConvertedVolume.fromJson(
                asT<Map<String, dynamic>>(jsonRes['converted_volume'])!),
        trustScore: asT<String>(jsonRes['trust_score']),
        bidAskSpreadPercentage:
            asT<double>(jsonRes['bid_ask_spread_percentage'])!,
        timestamp: asT<String>(jsonRes['timestamp'])!,
        lastTradedAt: asT<String>(jsonRes['last_traded_at'])!,
        lastFetchAt: asT<String>(jsonRes['last_fetch_at'])!,
        isAnomaly: asT<bool>(jsonRes['is_anomaly'])!,
        isStale: asT<bool>(jsonRes['is_stale'])!,
        tradeUrl: asT<String?>(jsonRes['trade_url']),
        tokenInfoUrl: asT<Object?>(jsonRes['token_info_url']),
        coinId: asT<String?>(jsonRes['coin_id']),
        targetCoinId: asT<String?>(jsonRes['target_coin_id']),
      );

  final String base;
  final String target;
  final Market market;
  final double last;
  final double volume;
  final ConvertedLast? convertedLast;
  final ConvertedVolume? convertedVolume;
  final String? trustScore;
  final double bidAskSpreadPercentage;
  final String timestamp;
  final String lastTradedAt;
  final String lastFetchAt;
  final bool isAnomaly;
  final bool isStale;
  final String? tradeUrl;
  final Object? tokenInfoUrl;
  final String? coinId;
  final String? targetCoinId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'base': base,
        'target': target,
        'market': market,
        'last': last,
        'volume': volume,
        'converted_last': convertedLast,
        'converted_volume': convertedVolume,
        'trust_score': trustScore,
        'bid_ask_spread_percentage': bidAskSpreadPercentage,
        'timestamp': timestamp,
        'last_traded_at': lastTradedAt,
        'last_fetch_at': lastFetchAt,
        'is_anomaly': isAnomaly,
        'is_stale': isStale,
        'trade_url': tradeUrl,
        'token_info_url': tokenInfoUrl,
        'coin_id': coinId,
        'target_coin_id': targetCoinId,
      };

  Tickers clone() => Tickers.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Market {
  Market({
    required this.name,
    required this.identifier,
    required this.hasTradingIncentive,
  });

  factory Market.fromJson(Map<String, dynamic> jsonRes) => Market(
        name: asT<String>(jsonRes['name'])!,
        identifier: asT<String>(jsonRes['identifier'])!,
        hasTradingIncentive: asT<bool>(jsonRes['has_trading_incentive'])!,
      );

  final String name;
  final String identifier;
  final bool hasTradingIncentive;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'identifier': identifier,
        'has_trading_incentive': hasTradingIncentive,
      };

  Market clone() =>
      Market.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class ConvertedLast {
  ConvertedLast({
    this.btc,
    this.eth,
    this.usd,
  });

  factory ConvertedLast.fromJson(Map<String, dynamic> jsonRes) => ConvertedLast(
        btc: asT<double?>(jsonRes['btc']),
        eth: asT<double?>(jsonRes['eth']),
        usd: asT<double?>(jsonRes['usd']),
      );

  final double? btc;
  final double? eth;
  final double? usd;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'btc': btc,
        'eth': eth,
        'usd': usd,
      };

  ConvertedLast clone() => ConvertedLast.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class ConvertedVolume {
  ConvertedVolume({
    this.btc,
    this.eth,
    this.usd,
  });

  factory ConvertedVolume.fromJson(Map<String, dynamic> jsonRes) =>
      ConvertedVolume(
        btc: asT<double?>(jsonRes['btc']),
        eth: asT<double?>(jsonRes['eth']),
        usd: asT<double?>(jsonRes['usd']),
      );

  final double? btc;
  final double? eth;
  final double? usd;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'btc': btc,
        'eth': eth,
        'usd': usd,
      };

  ConvertedVolume clone() => ConvertedVolume.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class StatusUpdates {
  StatusUpdates({
    required this.description,
    required this.category,
    required this.createdAt,
    required this.user,
    required this.userTitle,
    required this.pin,
    required this.project,
  });

  factory StatusUpdates.fromJson(Map<String, dynamic> jsonRes) => StatusUpdates(
        description: asT<String>(jsonRes['description'])!,
        category: asT<String>(jsonRes['category'])!,
        createdAt: asT<String>(jsonRes['created_at'])!,
        user: asT<String>(jsonRes['user'])!,
        userTitle: asT<String>(jsonRes['user_title'])!,
        pin: asT<bool>(jsonRes['pin'])!,
        project:
            Project.fromJson(asT<Map<String, dynamic>>(jsonRes['project'])!),
      );

  final String description;
  final String category;
  final String createdAt;
  final String user;
  final String userTitle;
  final bool pin;
  final Project project;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'description': description,
        'category': category,
        'created_at': createdAt,
        'user': user,
        'user_title': userTitle,
        'pin': pin,
        'project': project,
      };

  StatusUpdates clone() => StatusUpdates.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Project {
  Project({
    required this.type,
    required this.id,
    required this.name,
    required this.image,
  });

  factory Project.fromJson(Map<String, dynamic> jsonRes) => Project(
        type: asT<String>(jsonRes['type'])!,
        id: asT<String>(jsonRes['id'])!,
        name: asT<String>(jsonRes['name'])!,
        image: ExchangeImage.fromJson(
            asT<Map<String, dynamic>>(jsonRes['image'])!),
      );

  final String type;
  final String id;
  final String name;
  final ExchangeImage image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'id': id,
        'name': name,
        'image': image,
      };

  Project clone() => Project.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class ExchangeImage {
  ExchangeImage({
    required this.thumb,
    required this.small,
    required this.large,
  });

  factory ExchangeImage.fromJson(Map<String, dynamic> jsonRes) => ExchangeImage(
        thumb: asT<String>(jsonRes['thumb'])!,
        small: asT<String>(jsonRes['small'])!,
        large: asT<String>(jsonRes['large'])!,
      );

  final String thumb;
  final String small;
  final String large;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'thumb': thumb,
        'small': small,
        'large': large,
      };

  ExchangeImage clone() => ExchangeImage.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
