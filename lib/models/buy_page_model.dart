import 'package:conic/models/hive_models/hive_modals.dart';

class BuyPageDataModel extends PortfolioStorage {
  final String id;
  final String name;
  final String desc;
  final String symbol;
  final String image;

  final double price;
  final double fee;
  final double count;
  final DateTime time;
  final double type;
  BuyPageDataModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.symbol,
    required this.image,
    required this.price,
    required this.fee,
    required this.count,
    required this.time,
    required this.type,
  }) : super(
          id: id,
          name: name,
          desc: desc,
          symbol: symbol,
          image: image,
          price: price,
          fee: fee,
          count: count,
          time: time,
        );

  BuyPageDataModel copyWith({
    String? id,
    String? name,
    String? desc,
    String? symbol,
    String? image,
    double? price,
    double? fee,
    double? count,
    DateTime? time,
    double? type,
  }) {
    return BuyPageDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      symbol: symbol ?? this.symbol,
      image: image ?? this.image,
      price: price ?? this.price,
      fee: fee ?? this.fee,
      count: count ?? this.count,
      time: time ?? this.time,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuyPageDataModel &&
        other.id == id &&
        other.name == name &&
        other.desc == desc &&
        other.symbol == symbol &&
        other.image == image &&
        other.price == price &&
        other.fee == fee &&
        other.count == count &&
        other.time == time &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        symbol.hashCode ^
        image.hashCode ^
        price.hashCode ^
        fee.hashCode ^
        count.hashCode ^
        time.hashCode ^
        type.hashCode;
  }
}
