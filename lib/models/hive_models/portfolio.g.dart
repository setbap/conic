// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransferStatusAdapter extends TypeAdapter<TransferStatus> {
  @override
  final int typeId = 3;

  @override
  TransferStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransferStatus.TransferIn;
      case 1:
        return TransferStatus.TransferOut;
      default:
        return TransferStatus.TransferIn;
    }
  }

  @override
  void write(BinaryWriter writer, TransferStatus obj) {
    switch (obj) {
      case TransferStatus.TransferIn:
        writer.writeByte(0);
        break;
      case TransferStatus.TransferOut:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransferStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoinTransactionStatusAdapter extends TypeAdapter<CoinTransactionStatus> {
  @override
  final int typeId = 4;

  @override
  CoinTransactionStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CoinTransactionStatus.Buy;
      case 1:
        return CoinTransactionStatus.Sell;
      case 2:
        return CoinTransactionStatus.Transfer;
      default:
        return CoinTransactionStatus.Buy;
    }
  }

  @override
  void write(BinaryWriter writer, CoinTransactionStatus obj) {
    switch (obj) {
      case CoinTransactionStatus.Buy:
        writer.writeByte(0);
        break;
      case CoinTransactionStatus.Sell:
        writer.writeByte(1);
        break;
      case CoinTransactionStatus.Transfer:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinTransactionStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionStorageAdapter extends TypeAdapter<TransactionStorage> {
  @override
  final int typeId = 1;

  @override
  TransactionStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionStorage(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[7] as String,
      symbol: fields[6] as String,
      price: fields[2] as double,
      fee: fields[3] as double,
      desc: fields[4] as String,
      count: fields[5] as double,
      transferStatus: fields[9] as TransferStatus,
      coinTransactionStatus: fields[10] as CoinTransactionStatus,
      time: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionStorage obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.time)
      ..writeByte(9)
      ..write(obj.transferStatus)
      ..writeByte(10)
      ..write(obj.coinTransactionStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PortfolioStorageAdapter extends TypeAdapter<PortfolioStorage> {
  @override
  final int typeId = 2;

  @override
  PortfolioStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioStorage(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[5] as String,
      symbol: fields[4] as String,
      price: fields[2] as double,
      count: fields[3] as double,
      time: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioStorage obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.symbol)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
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
