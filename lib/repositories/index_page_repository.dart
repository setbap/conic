import 'package:conic/models/models.dart';
import 'package:cryptopanic/cryptopanic.dart';
import 'package:coingecko/coingecko.dart';

class IndexDataRepository {
  final CryptoPanicClient _newsApi;
  final CoinGeckoClient _coinApi;

  const IndexDataRepository({
    required CryptoPanicClient newApi,
    required CoinGeckoClient coinApi,
  })  : _newsApi = newApi,
        _coinApi = coinApi;

  Future<IndexPageDataModel> getIndexPageInfo() async {
    final indexPageData = await Future.wait([
      _newsApi.getNews(currencies: []),
      _coinApi.topCoinInfo(perPage: 10),
      _coinApi.trendigCoins()
    ]);
    final news = indexPageData[0] as NewsApiResualt;
    final topCoin = indexPageData[1] as List<TopCoin>;
    final trendingCoin = indexPageData[2] as TrendigCoins;

    return IndexPageDataModel(
      newsApiResualt: news,
      topCoinList: topCoin,
      trendigCoins: trendingCoin,
    );
  }

  Future<ListPageDataModel> getListPageInfo() async {
    final listPageRawData = await Future.wait([
      _coinApi.topCoinInfo(perPage: 100, sparkLine: true),
      _coinApi.topExchangesInfo(perPage: 100),
    ]);

    // ignore: unnecessary_cast
    final topCoin = listPageRawData[0] as List<TopCoin>;
    final topExchange = listPageRawData[1] as List<ExchangesItem>;

    return ListPageDataModel(
      topCoinList: topCoin,
      topExchangeList: topExchange,
    );
  }

  Future<CoinDetailPageDataModel> getCoinDetaiPageInfo(String coinName) async {
    final listPageRawData = await Future.wait([
      _coinApi.topCoinInfo(coins: [coinName], sparkLine: true),
      _coinApi.coinDesc(coinId: coinName),
    ]);

    // ignore: unnecessary_cast
    final topCoin = listPageRawData[0] as List<TopCoin>;
    final coinDecription = listPageRawData[1] as CoinDecription;

    return CoinDetailPageDataModel(
      coinPrice: topCoin[0],
      coinDecription: coinDecription,
    );
  }
}
