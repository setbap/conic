import 'package:hive/hive.dart';

part 'portfolio.g.dart';

@HiveType(typeId: 1)
class PortfolioStorage {
  static const PortfolioKey = "hive.portfolio";

  const PortfolioStorage({
    required this.id,
    required this.name,
    required this.image,
    required this.symbol,
    required this.price,
    required this.fee,
    required this.desc,
    required this.count,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final double fee;

  @HiveField(4)
  final String desc;

  @HiveField(5)
  final double count;

  @HiveField(6)
  final String symbol;

  @HiveField(7)
  final String image;
}
