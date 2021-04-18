import 'dart:convert';
import './models.dart';

class CoinDecription {
  CoinDecription({
    required this.id,
    required this.symbol,
    required this.name,
    required this.assetPlatformId,
    required this.categories,
    required this.description,
    required this.links,
    this.image,
    this.sentimentVotesUpPercentage,
    this.sentimentVotesDownPercentage,
    required this.marketCapRank,
    required this.coingeckoRank,
    required this.coingeckoScore,
    required this.lastUpdated,
  });

  factory CoinDecription.fromJson(Map<String, dynamic> jsonRes) {
    final categories = jsonRes['categories'] is List ? <String>[] : null;
    if (categories != null) {
      for (final dynamic item in jsonRes['categories']!) {
        if (item != null) {
          tryCatch(() {
            categories.add(asT<String>(item)!);
          });
        }
      }
    }
    return CoinDecription(
      id: asT<String>(jsonRes['id'])!,
      symbol: asT<String>(jsonRes['symbol'])!,
      name: asT<String>(jsonRes['name'])!,
      assetPlatformId: asT<Object>(jsonRes['asset_platform_id']),
      categories: categories!,
      description: Description.fromJson(
          asT<Map<String, dynamic>>(jsonRes['description'])!),
      links: Links.fromJson(asT<Map<String, dynamic>>(jsonRes['links'])!),
      image: jsonRes['image'] == null
          ? null
          : CoinImages.fromJson(asT<Map<String, dynamic>>(jsonRes['image'])!),
      sentimentVotesUpPercentage:
          asT<double?>(jsonRes['sentiment_votes_up_percentage']),
      sentimentVotesDownPercentage:
          asT<double?>(jsonRes['sentiment_votes_down_percentage']),
      marketCapRank: asT<int>(jsonRes['market_cap_rank']),
      coingeckoRank: asT<int>(jsonRes['coingecko_rank'])!,
      coingeckoScore: asT<double>(jsonRes['coingecko_score'])!,
      lastUpdated: asT<String>(jsonRes['last_updated'])!,
    );
  }

  final String id;
  final String symbol;
  final String name;
  final Object? assetPlatformId;
  final List<String> categories;
  final Description description;
  final Links links;
  final CoinImages? image;
  final double? sentimentVotesUpPercentage;
  final double? sentimentVotesDownPercentage;
  final int? marketCapRank;
  final int coingeckoRank;
  final double coingeckoScore;
  final String lastUpdated;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'symbol': symbol,
        'name': name,
        'asset_platform_id': assetPlatformId,
        'categories': categories,
        'description': description,
        'links': links,
        'image': image,
        'sentiment_votes_up_percentage': sentimentVotesUpPercentage,
        'sentiment_votes_down_percentage': sentimentVotesDownPercentage,
        'market_cap_rank': marketCapRank,
        'coingecko_rank': coingeckoRank,
        'coingecko_score': coingeckoScore,
        'last_updated': lastUpdated,
      };

  CoinDecription clone() => CoinDecription.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Description {
  Description({
    required this.en,
  });

  factory Description.fromJson(Map<String, dynamic> jsonRes) => Description(
        en: asT<String>(jsonRes['en'])!,
      );

  final String en;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'en': en,
      };

  Description clone() => Description.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Links {
  Links({
    this.homepage,
    this.blockchainSite,
    this.officialForumUrl,
    this.chatUrl,
    this.twitterScreenName,
    this.facebookUsername,
    this.bitcointalkThreadIdentifier,
    this.telegramChannelIdentifier,
    this.subredditUrl,
    this.reposUrl,
  });

  factory Links.fromJson(Map<String, dynamic> jsonRes) {
    final homepage = jsonRes['homepage'] is List ? <String>[] : null;
    if (homepage != null) {
      for (final dynamic item in jsonRes['homepage']!) {
        if (item != null) {
          tryCatch(() {
            homepage.add(asT<String>(item)!);
          });
        }
      }
    }

    final blockchainSite =
        jsonRes['blockchain_site'] is List ? <String>[] : null;
    if (blockchainSite != null) {
      for (final dynamic item in jsonRes['blockchain_site']!) {
        if (item != null) {
          tryCatch(() {
            blockchainSite.add(asT<String>(item)!);
          });
        }
      }
    }

    final officialForumUrl =
        jsonRes['official_forum_url'] is List ? <String>[] : null;
    if (officialForumUrl != null) {
      for (final dynamic item in jsonRes['official_forum_url']!) {
        if (item != null) {
          tryCatch(() {
            officialForumUrl.add(asT<String>(item)!);
          });
        }
      }
    }

    final chatUrl = jsonRes['chat_url'] is List ? <String>[] : null;
    if (chatUrl != null) {
      for (final dynamic item in jsonRes['chat_url']!) {
        if (item != null) {
          tryCatch(() {
            chatUrl.add(asT<String>(item)!);
          });
        }
      }
    }
    return Links(
      homepage: homepage,
      blockchainSite: blockchainSite,
      officialForumUrl: officialForumUrl,
      chatUrl: chatUrl,
      twitterScreenName: asT<String?>(jsonRes['twitter_screen_name']),
      facebookUsername: asT<String?>(jsonRes['facebook_username']),
      bitcointalkThreadIdentifier:
          asT<Object?>(jsonRes['bitcointalk_thread_identifier']),
      telegramChannelIdentifier:
          asT<String?>(jsonRes['telegram_channel_identifier']),
      subredditUrl: asT<String?>(jsonRes['subreddit_url']),
      reposUrl: jsonRes['repos_url'] == null
          ? null
          : ReposUrl.fromJson(asT<Map<String, dynamic>>(jsonRes['repos_url'])!),
    );
  }

  final List<String>? homepage;
  final List<String>? blockchainSite;
  final List<String>? officialForumUrl;
  final List<String>? chatUrl;
  final String? twitterScreenName;
  final String? facebookUsername;
  final Object? bitcointalkThreadIdentifier;
  final String? telegramChannelIdentifier;
  final String? subredditUrl;
  final ReposUrl? reposUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'homepage': homepage,
        'blockchain_site': blockchainSite,
        'official_forum_url': officialForumUrl,
        'chat_url': chatUrl,
        'twitter_screen_name': twitterScreenName,
        'facebook_username': facebookUsername,
        'bitcointalk_thread_identifier': bitcointalkThreadIdentifier,
        'telegram_channel_identifier': telegramChannelIdentifier,
        'subreddit_url': subredditUrl,
        'repos_url': reposUrl,
      };

  Links clone() =>
      Links.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class ReposUrl {
  ReposUrl({
    this.github,
    this.bitbucket,
  });

  factory ReposUrl.fromJson(Map<String, dynamic> jsonRes) {
    final github = jsonRes['github'] is List ? <String>[] : null;
    if (github != null) {
      for (final dynamic item in jsonRes['github']!) {
        if (item != null) {
          tryCatch(() {
            github.add(asT<String>(item)!);
          });
        }
      }
    }

    final bitbucket = jsonRes['bitbucket'] is List ? <Object>[] : null;
    if (bitbucket != null) {
      for (final dynamic item in jsonRes['bitbucket']!) {
        if (item != null) {
          tryCatch(() {
            bitbucket.add(asT<Object>(item)!);
          });
        }
      }
    }
    return ReposUrl(
      github: github,
      bitbucket: bitbucket,
    );
  }

  final List<String>? github;
  final List<Object>? bitbucket;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'github': github,
        'bitbucket': bitbucket,
      };

  ReposUrl clone() => ReposUrl.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class CoinImages {
  CoinImages({
    this.thumb,
    this.small,
    this.large,
  });

  factory CoinImages.fromJson(Map<String, dynamic> jsonRes) => CoinImages(
        thumb: asT<String?>(jsonRes['thumb']),
        small: asT<String?>(jsonRes['small']),
        large: asT<String?>(jsonRes['large']),
      );

  final String? thumb;
  final String? small;
  final String? large;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'thumb': thumb,
        'small': small,
        'large': large,
      };

  CoinImages clone() => CoinImages.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
