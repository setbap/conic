class SimpleCoin {
  final String id;
  final String name;
  final String symbol;
  final String largeThumb;

  const SimpleCoin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.largeThumb,
  });

  factory SimpleCoin.fromMap(Map<String, dynamic> map) {
    return new SimpleCoin(
      id: map['id'] as String,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      largeThumb: map['large'] as String,
    );
  }
}
