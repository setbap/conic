import 'dart:convert';
import 'package:conic/models/models.dart';
import 'package:conic/models/simple_coin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

List<SimpleCoin> parseCoins(String string) {
  final parsed = jsonDecode(string).cast<Map<String, dynamic>>();
  return parsed.map<SimpleCoin>((json) => SimpleCoin.fromMap(json)).toList();
}

List<SimpleExchange> parseExchanges(String string) {
  final parsed = jsonDecode(string).cast<Map<String, dynamic>>();
  return parsed
      .map<SimpleExchange>((json) => SimpleExchange.fromMap(json))
      .toList();
}

class ParsDataRepo {
  List<SimpleExchange>? simpleExchanges;
  List<SimpleCoin>? simpleCoins;

  Future<List<SimpleCoin>> fetchCoins() async {
    final String response = await rootBundle.loadString('assets/coins.json');
    return compute(parseCoins, response);
  }

  Future<List<SimpleExchange>> fetchExchanges() async {
    final String response =
        await rootBundle.loadString('assets/exchanges.json');
    return compute(parseExchanges, response);
  }
}
