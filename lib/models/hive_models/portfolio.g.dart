// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PortfolioStorageAdapter extends TypeAdapter<PortfolioStorage> {
  @override
  final int typeId = 1;

  @override
  PortfolioStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioStorage(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[7] as String,
      symbol: fields[6] as String,
      price: fields[2] as double,
      fee: fields[3] as double,
      desc: fields[4] as String,
      count: fields[5] as double,
      time: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioStorage obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.fee)
      ..writeByte(4)
      ..write(obj.desc)
      ..writeByte(5)
      ..write(obj.count)
      ..writeByte(6)
      ..write(obj.symbol)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
