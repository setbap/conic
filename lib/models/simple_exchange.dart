class SimpleExchange {
  final String id;
  final String name;
  final String marketType;
  final String largeThumb;

  const SimpleExchange({
    required this.id,
    required this.name,
    required this.marketType,
    required this.largeThumb,
  });

  factory SimpleExchange.fromMap(Map<String, dynamic> map) {
    return new SimpleExchange(
      id: map['id'] as String,
      name: map['name'] as String,
      marketType: map['market_type'] as String,
      largeThumb: map['large'] as String,
    );
  }
}
