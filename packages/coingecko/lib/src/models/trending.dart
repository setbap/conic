import 'dart:convert';
import 'models.dart';

class TrendigCoins {
  TrendigCoins({
    required this.coins,
  });

  factory TrendigCoins.fromJson(Map<String, dynamic> jsonRes) {
    final coins = jsonRes['coins'] is List ? <Coins>[] : null;
    if (coins != null) {
      for (final dynamic item in jsonRes['coins']!) {
        if (item != null) {
          tryCatch(() {
            coins.add(Coins.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return TrendigCoins(
      coins: coins!,
    );
  }

  final List<Coins> coins;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'coins': coins,
      };

  TrendigCoins clone() => TrendigCoins.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Coins {
  Coins({
    required this.item,
  });

  factory Coins.fromJson(Map<String, dynamic> jsonRes) => Coins(
        item: Item.fromJson(asT<Map<String, dynamic>>(jsonRes['item'])!),
      );

  final Item item;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'item': item,
      };

  Coins clone() =>
      Coins.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.large,
    required this.score,
  });

  factory Item.fromJson(Map<String, dynamic> jsonRes) => Item(
        id: asT<String>(jsonRes['id'])!,
        name: asT<String>(jsonRes['name'])!,
        symbol: asT<String>(jsonRes['symbol'])!,
        marketCapRank: asT<int>(jsonRes['market_cap_rank'])!,
        thumb: asT<String>(jsonRes['thumb'])!,
        large: asT<String>(jsonRes['large'])!,
        score: asT<int>(jsonRes['score'])!,
      );

  final String id;
  final String name;
  final String symbol;
  final int marketCapRank;
  final String thumb;
  final String large;
  final int score;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'symbol': symbol,
        'market_cap_rank': marketCapRank,
        'thumb': thumb,
        'large': large,
        'score': score,
      };

  Item clone() =>
      Item.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
