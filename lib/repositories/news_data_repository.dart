import 'package:conic/models/models.dart';
import 'package:cryptopanic/cryptopanic.dart';

class NewsDataRepo {
  final CryptoPanicClient _newApi;

  const NewsDataRepo({required CryptoPanicClient newApi}) : _newApi = newApi;

  Future<List<NewsItem>> getLatestNews({int count = 6}) async {
    final news = await _newApi.getNews(currencies: []);
    final List<NewsItem> newsItems = [];
    news.results.take(count).forEach((element) {
      newsItems.add(NewsItem(
          title: element.title,
          link: element.url,
          subTitle: "${element.source.title} - ${element.source.domain} "));
    });
    return newsItems;
  }

  Future<List<NewsItem>> getLatestNewsWithCoin(
      {int count = 6, required String coinName}) async {
    final news = await _newApi.getNews(currencies: [coinName]);
    final List<NewsItem> newsItems = [];
    news.results.take(count).forEach((element) {
      newsItems.add(NewsItem(
          title: element.title,
          link: element.url,
          subTitle: "${element.source.domain} - "));
    });
    return newsItems;
  }
}
