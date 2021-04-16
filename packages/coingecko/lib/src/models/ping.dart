import 'dart:convert';

class Ping {
  final String geckoSays;
  const Ping({required this.geckoSays});

  factory Ping.fromMap(Map<String, dynamic> map) {
    return Ping(
      geckoSays: map['gecko_says'],
    );
  }

  factory Ping.fromJson(String source) => Ping.fromMap(json.decode(source));
}
