abstract class CryptoPanicException implements Exception {
  String get message;
}

class InternetConnetionException implements CryptoPanicException {
  @override
  String get message => 'problem with yout connection to CryptoPanic';
}

class BadRequestException implements CryptoPanicException {
  final String text;

  BadRequestException(this.text);
  @override
  String get message => 'bad request,$text';
}

class ServerException implements CryptoPanicException {
  @override
  String get message => 'problem with yout connection to CryptoPanic';
}
