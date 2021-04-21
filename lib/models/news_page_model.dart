import 'package:cryptopanic/cryptopanic.dart';

import 'package:conic/models/models.dart';

class NewsPageDataModel {
  final NewsApiResualt? topCoinApiResualt;
  final NewsApiResualt? bearishApiResualt;
  final NewsApiResualt? bullishApiResualt;
  final NewsApiResualt? hotApiResualt;
  final NewsApiResualt? importantApiResualt;
  final NewsFilter newsFilter;

  const NewsPageDataModel({
    required this.newsFilter,
    this.topCoinApiResualt,
    this.bearishApiResualt,
    this.bullishApiResualt,
    this.hotApiResualt,
    this.importantApiResualt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsPageDataModel &&
        other.topCoinApiResualt == topCoinApiResualt &&
        other.bearishApiResualt == bearishApiResualt &&
        other.bullishApiResualt == bullishApiResualt &&
        other.hotApiResualt == hotApiResualt &&
        other.importantApiResualt == importantApiResualt &&
        other.newsFilter == newsFilter;
  }

  @override
  int get hashCode {
    return topCoinApiResualt.hashCode ^
        bearishApiResualt.hashCode ^
        bullishApiResualt.hashCode ^
        hotApiResualt.hashCode ^
        importantApiResualt.hashCode ^
        newsFilter.hashCode;
  }

  NewsPageDataModel copyWith({
    NewsApiResualt? topCoinApiResualt,
    NewsApiResualt? bearishApiResualt,
    NewsApiResualt? bullishApiResualt,
    NewsApiResualt? hotApiResualt,
    NewsApiResualt? importantApiResualt,
    NewsFilter? newsFilter,
  }) {
    return NewsPageDataModel(
      topCoinApiResualt: topCoinApiResualt ?? this.topCoinApiResualt,
      bearishApiResualt: bearishApiResualt ?? this.bearishApiResualt,
      bullishApiResualt: bullishApiResualt ?? this.bullishApiResualt,
      hotApiResualt: hotApiResualt ?? this.hotApiResualt,
      importantApiResualt: importantApiResualt ?? this.importantApiResualt,
      newsFilter: newsFilter ?? this.newsFilter,
    );
  }

  NewsPageDataModel copyWithNewsFilter(
    NewsFilter newsFilter,
    NewsApiResualt newsApiResualt,
  ) {
    switch (newsFilter) {
      case NewsFilter.bearish:
        return copyWith(
          newsFilter: newsFilter,
          bearishApiResualt: newsApiResualt,
        );

      case NewsFilter.bullish:
        return copyWith(
          newsFilter: newsFilter,
          bullishApiResualt: newsApiResualt,
        );

      case NewsFilter.hot:
        return copyWith(
          newsFilter: newsFilter,
          hotApiResualt: newsApiResualt,
        );

      case NewsFilter.important:
        return copyWith(
          newsFilter: newsFilter,
          importantApiResualt: newsApiResualt,
        );

      case NewsFilter.rising:
      default:
        return copyWith(
          newsFilter: newsFilter,
          topCoinApiResualt: newsApiResualt,
        );
    }
  }

  NewsApiResualt? getValueFromFilter(
    NewsFilter newsFilter,
  ) {
    switch (newsFilter) {
      case NewsFilter.bearish:
        return bearishApiResualt;

      case NewsFilter.bullish:
        return bullishApiResualt;

      case NewsFilter.hot:
        return hotApiResualt;
      case NewsFilter.important:
        return importantApiResualt;

      case NewsFilter.rising:
      default:
        return topCoinApiResualt;
    }
  }
}
