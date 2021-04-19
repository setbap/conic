import 'dart:convert';

import 'package:coingecko/src/api/endpoints.dart';
import 'package:coingecko/src/helper/error.dart';
import 'package:coingecko/src/models/models.dart';
import 'package:coingecko/src/models/ping.dart';
import 'package:coingecko/src/models/simple_price.dart';
import 'package:http/http.dart' as http;

class CoinGeckoClient {
  // late Dio _dio;
  final _client = http.Client();
  final _host = 'api.coingecko.com';
  Uri _uri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      Uri(
        scheme: 'https',
        host: _host,
        path: '/api/v3$path',
        queryParameters: queryParameters,
      );

  Map<String, dynamic> _mapCleaner(Map<String, dynamic> map) {
    map.removeWhere((key, value) => value == null);
    return map;
  }

  Future<dynamic> _genericGet({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    print(_uri(
      path: path,
      queryParameters: queryParameters,
    ).toString());
    try {
      final pingData = await _client.get(_uri(
        path: path,
        queryParameters: queryParameters,
      ));
      if (pingData.statusCode == 200) {
        return jsonDecode(pingData.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw InternetConnetionException();
    }
  }

//
  Future<Ping> ping() async {
    final pingMap = await _genericGet(path: Endpoints.ping());
    return Ping.fromMap(pingMap);
  }

  Future<SimplePrice> simplePrice({
    required String currency,
    required String tokenId,
    bool? includeMarketCap,
    bool? include24hrVol,
    bool? include24hrChange,
  }) async {
    final qs = _mapCleaner({
      'ids': tokenId,
      'vs_currencies': currency,
      'include_market_cap': includeMarketCap.toString(),
      'include_24hr_vol': include24hrVol.toString(),
      'include_24hr_change': include24hrChange.toString(),
      'include_last_updated_at': 'true',
    });
    final simplePriceMap = await _genericGet(
      path: Endpoints.simplePrice(),
      queryParameters: qs,
    );

    if (!simplePriceMap.containsKey(tokenId)) {
      throw BadRequestException("$currency doesn't exist  ");
    } else {
      simplePriceMap[tokenId]['currency'] = currency;
      return SimplePrice.fromMap(simplePriceMap[tokenId]);
    }
  }

  Future<Map<String, SimplePrice>> simpleMultiCoinPrice({
    required String currency,
    required List<String> tokensId,
    bool? includeMarketCap,
    bool? include24hrVol,
    bool? include24hrChange,
  }) async {
    final qs = _mapCleaner({
      'ids': tokensId.join(','),
      'vs_currencies': currency,
      'include_market_cap': includeMarketCap.toString(),
      'include_24hr_vol': include24hrVol.toString(),
      'include_24hr_change': include24hrChange.toString(),
      'include_last_updated_at': 'true',
    });
    final simplePriceMap = await _genericGet(
      path: Endpoints.simplePrice(),
      queryParameters: qs,
    );

    var prices = <String, SimplePrice>{};
    for (var element in tokensId) {
      if (simplePriceMap.containsKey(element)) {
        simplePriceMap[element]['currency'] = currency;
        final simplePrice = SimplePrice.fromMap(simplePriceMap[element]);
        prices[element] = simplePrice;
      }
    }
    return prices;
  }

  Future<List<TopCoin>> topCoinInfo({
    int perPage = 6,
    int page = 1,
    List<String>? coins,
    bool sparkLine = false,
  }) async {
    final topCoinsRaw = await _genericGet(
      path: Endpoints.coinsMarkets(),
      queryParameters: {
        'vs_currency': 'usd',
        'ids': coins?.join(','),
        'order': 'market_cap_desc',
        'per_page': perPage.toString(),
        'page': page.toString(),
        'sparkline': sparkLine.toString(),
        'price_change_percentage': '24h',
      },
    );

    var topCoins = <TopCoin>[];
    for (var element in topCoinsRaw) {
      topCoins.add(TopCoin.fromJson(element));
    }
    return topCoins;
  }

  Future<CoinDecription> coinDesc({required String coinId}) async {
    final coinDescRaw = await _genericGet(
      path: Endpoints.coinsId(id: coinId),
      queryParameters: {
        'localization': false.toString(),
        'tickers': false.toString(),
        'market_data': false.toString(),
        'sparkline': false.toString(),
        'developer_data': false.toString(),
      },
    );

    return CoinDecription.fromJson(coinDescRaw);
  }

  Future<CoinChart> coinChart({
    required String coinName,
    required int days,
  }) async {
    print("raw");
    final coinChartRaw = await _genericGet(
      path: Endpoints.coinsIdMarketChart(id: coinName),
      queryParameters: {
        'days': days.toString(),
        'vs_currency': 'usd',
      },
    );
    print(coinChartRaw);

    return CoinChart.fromJson(coinChartRaw);
  }

  Future<List<ExchangesItem>> topExchangesInfo({
    int perPage = 6,
    int page = 1,
  }) async {
    final topExchangesRaw = await _genericGet(
      path: Endpoints.exchanges(),
      queryParameters: {
        'per_page': perPage.toString(),
        'page': page.toString(),
      },
    );

    var topExchanges = <ExchangesItem>[];

    for (var element in topExchangesRaw) {
      topExchanges.add(ExchangesItem.fromJson(element));
    }

    return topExchanges;
  }

  Future<List> supportedVsCurrencies() async {
    final simpleSupportVsCurrencies =
        await _genericGet(path: Endpoints.simpleSupportVsCurrencies()) as List;
    return simpleSupportVsCurrencies;
  }

  Future<TrendigCoins> trendigCoins() async {
    final trendig = await _genericGet(path: Endpoints.searchTrending());
    return TrendigCoins.fromJson(trendig);
  }
}
