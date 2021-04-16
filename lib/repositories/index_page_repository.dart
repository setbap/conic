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
      _coinApi.topCoinInfo(perPage: 6),
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
}
