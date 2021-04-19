import 'dart:convert';

import 'package:cryptopanic/helper/helper.dart';
import 'package:cryptopanic/models/models.dart';
import 'package:http/http.dart' as http;

class CryptoPanicClient {
  final _client = http.Client();
  final _host = 'cryptopanic.com';
  Uri _uri({
    Map<String, dynamic>? queryParameters,
  }) =>
      Uri(
        scheme: 'https',
        host: _host,
        path: "/api/v1/posts/",
        queryParameters: queryParameters,
      );

  Map<String, dynamic> _mapCleaner(Map<String, dynamic> map) {
    map.removeWhere((key, value) => value == null);
    return map;
  }

  Future<dynamic> _genericGet({
    Map<String, dynamic>? queryParameters,
  }) async {
    print(_uri(
      queryParameters: queryParameters,
    ).toString());
    try {
      final pingData = await _client.get(_uri(
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

  Future<NewsApiResualt> getNews({
    String authToken = "3fcd3ed8aefec83d3a05a18a28c671dff54cbc1a",
    required List<String>? currencies,
    String filter = "rising",
    bool public = true,
  }) async {
    final qs = _mapCleaner({
      'auth_token': authToken,
      'currencies': currencies?.join(","),
      'filter': filter,
      'public': public.toString(),
    });
    final newsApiResMap = await _genericGet(
      queryParameters: qs,
    );
    return NewsApiResualt.fromJson(newsApiResMap);
  }
}
