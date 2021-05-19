import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    print(e);
    print(stack);
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
      <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class TopCoin {
  TopCoin({
    required this.id,
    required this.symbol,
    required this.name,
    this.image,
    required this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.ath,
    this.atl,
    this.sparklineIn7d,
  });

  factory TopCoin.fromJson(Map<String, dynamic> jsonRes) => TopCoin(
        id: asT<String>(jsonRes['id'])!,
        symbol: asT<String>(jsonRes['symbol'])!,
        name: asT<String>(jsonRes['name'])!,
        image: asT<String>(jsonRes['image']),
        currentPrice: asT<double>(jsonRes['current_price'])!,
        marketCap: asT<double>(jsonRes['market_cap']),
        marketCapRank: asT<int>(jsonRes['market_cap_rank']),
        high24h: asT<double>(jsonRes['high_24h']),
        low24h: asT<double>(jsonRes['low_24h']),
        priceChange24h: asT<double>(jsonRes['price_change_24h']),
        priceChangePercentage24h:
            asT<double>(jsonRes['price_change_percentage_24h']),
        ath: asT<double>(jsonRes['ath']),
        atl: asT<double>(jsonRes['atl']),
        sparklineIn7d: jsonRes['sparkline_in_7d'] == null
            ? null
            : SparklineIn7d.fromJson(
                asT<Map<String, dynamic>>(jsonRes['sparkline_in_7d'])!),
      );

  final String id;
  final String symbol;
  final String name;
  final String? image;
  final double? currentPrice;
  final double? marketCap;
  final int? marketCapRank;
  final double? high24h;
  final double? low24h;
  final double? priceChange24h;
  final double? priceChangePercentage24h;
  final double? ath;
  final double? atl;
  final SparklineIn7d? sparklineIn7d;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'symbol': symbol,
        'name': name,
        'image': image,
        'current_price': currentPrice,
        'market_cap': marketCap,
        'market_cap_rank': marketCapRank,
        'high_24h': high24h,
        'low_24h': low24h,
        'price_change_24h': priceChange24h,
        'price_change_percentage_24h': priceChangePercentage24h,
        'ath': ath,
        'atl': atl,
        'sparkline_in_7d': sparklineIn7d,
      };

  TopCoin clone() => TopCoin.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class SparklineIn7d {
  SparklineIn7d({
    required this.price,
  });

  factory SparklineIn7d.fromJson(Map<String, dynamic> jsonRes) {
    final price = jsonRes['price'] is List ? <double>[] : null;
    if (price != null) {
      for (final dynamic item in jsonRes['price']!) {
        if (item != null) {
          tryCatch(() {
            price.add(asT<double>(item)!);
          });
        }
      }
    }
    return SparklineIn7d(
      price: price!,
    );
  }

  final List<double> price;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'price': price,
      };

  SparklineIn7d clone() => SparklineIn7d.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
