import 'package:hive/hive.dart';

part 'portfolio.g.dart';

@HiveType(typeId: 1)
class TransactionStorage {
  static const TransactionKey = "Hive_Transaction";

  TransactionStorage({
    required this.id,
    required this.name,
    required this.image,
    required this.symbol,
    required this.price,
    required this.fee,
    required this.desc,
    required this.count,
    required this.transferStatus,
    required this.coinTransactionStatus,
    DateTime? time,
  }) : this.time = time ?? DateTime.now();

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

  @HiveField(8)
  final DateTime time;

  @HiveField(9)
  final TransferStatus transferStatus;

  @HiveField(10)
  final CoinTransactionStatus coinTransactionStatus;

  TransactionStorage copyWith({
    String? id,
    String? name,
    double? price,
    double? fee,
    String? desc,
    double? count,
    String? symbol,
    String? image,
    DateTime? time,
    TransferStatus? transferStatus,
    CoinTransactionStatus? coinTransactionStatus,
  }) {
    return TransactionStorage(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      fee: fee ?? this.fee,
      desc: desc ?? this.desc,
      count: count ?? this.count,
      symbol: symbol ?? this.symbol,
      image: image ?? this.image,
      time: time ?? this.time,
      transferStatus: transferStatus ?? this.transferStatus,
      coinTransactionStatus:
          coinTransactionStatus ?? this.coinTransactionStatus,
    );
  }
}

@HiveType(typeId: 2)
class PortfolioStorage {
  static const PortfolioKey = "Hive_Portfolio";

  PortfolioStorage({
    required this.id,
    required this.name,
    required this.image,
    required this.symbol,
    required this.price,
    required this.count,
    DateTime? time,
  }) : this.time = time ?? DateTime.now();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final double count;

  @HiveField(4)
  final String symbol;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final DateTime time;
}

@HiveType(typeId: 3)
enum TransferStatus {
  @HiveField(0)
  TransferIn,

  @HiveField(1)
  TransferOut,
}

@HiveType(typeId: 4)
enum CoinTransactionStatus {
  @HiveField(0)
  Buy,
  @HiveField(1)
  Sell,
  @HiveField(2)
  Transfer,
}
