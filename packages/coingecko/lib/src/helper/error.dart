abstract class CoinGeckoException implements Exception {
  String get message;
}

class InternetConnetionException implements CoinGeckoException {
  @override
  String get message => 'problem with yout connection to CoinGecko';
}

class BadRequestException implements CoinGeckoException {
  final String text;

  BadRequestException(this.text);
  @override
  String get message => 'bad request,$text';
}

class ServerException implements CoinGeckoException {
  @override
  String get message => 'problem with yout connection to CoinGecko';
}
