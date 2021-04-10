import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
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
      final String valueS = value.toString();
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

class NewsApiResualt {
  NewsApiResualt({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory NewsApiResualt.fromJson(Map<String, dynamic> jsonRes) {
    final List<NewsModel>? results =
        jsonRes['results'] is List ? <NewsModel>[] : null;
    if (results != null) {
      for (final dynamic item in jsonRes['results']!) {
        if (item != null) {
          tryCatch(() {
            results.add(NewsModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return NewsApiResualt(
      count: asT<int>(jsonRes['count'])!,
      next: asT<String?>(jsonRes['next']),
      previous: asT<Object?>(jsonRes['previous']),
      results: results!,
    );
  }

  final int count;
  final String? next;
  final Object? previous;
  final List<NewsModel> results;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'next': next,
        'previous': previous,
        'results': results,
      };

  NewsApiResualt clone() => NewsApiResualt.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class NewsModel {
  NewsModel({
    required this.kind,
    required this.domain,
    required this.source,
    required this.title,
    required this.publishedAt,
    required this.currencies,
    required this.id,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<Currencies>? currencies =
        jsonRes['currencies'] is List ? <Currencies>[] : null;
    if (currencies != null) {
      for (final dynamic item in jsonRes['currencies']!) {
        if (item != null) {
          tryCatch(() {
            currencies
                .add(Currencies.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return NewsModel(
      kind: asT<String>(jsonRes['kind'])!,
      domain: asT<String>(jsonRes['domain'])!,
      source: Source.fromJson(asT<Map<String, dynamic>>(jsonRes['source'])!),
      title: asT<String>(jsonRes['title'])!,
      publishedAt: asT<String>(jsonRes['published_at'])!,
      currencies: currencies!,
      id: asT<int>(jsonRes['id'])!,
      url: asT<String>(jsonRes['url'])!,
    );
  }

  final String kind;
  final String domain;
  final Source source;
  final String title;
  final String publishedAt;
  final List<Currencies> currencies;
  final int id;
  final String url;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'kind': kind,
        'domain': domain,
        'source': source,
        'title': title,
        'published_at': publishedAt,
        'currencies': currencies,
        'id': id,
        'url': url,
      };

  NewsModel clone() => NewsModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Source {
  Source({
    required this.title,
    required this.region,
    required this.domain,
  });

  factory Source.fromJson(Map<String, dynamic> jsonRes) => Source(
        title: asT<String>(jsonRes['title'])!,
        region: asT<String>(jsonRes['region'])!,
        domain: asT<String>(jsonRes['domain'])!,
      );

  final String title;
  final String region;
  final String domain;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'region': region,
        'domain': domain,
      };

  Source clone() =>
      Source.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Currencies {
  Currencies({
    required this.code,
    required this.title,
    required this.slug,
    required this.url,
  });

  factory Currencies.fromJson(Map<String, dynamic> jsonRes) => Currencies(
        code: asT<String>(jsonRes['code'])!,
        title: asT<String>(jsonRes['title'])!,
        slug: asT<String>(jsonRes['slug'])!,
        url: asT<String>(jsonRes['url'])!,
      );

  final String code;
  final String title;
  final String slug;
  final String url;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'title': title,
        'slug': slug,
        'url': url,
      };

  Currencies clone() => Currencies.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
