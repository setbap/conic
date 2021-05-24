// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppThemeModeAdapter extends TypeAdapter<AppThemeMode> {
  @override
  final int typeId = 5;

  @override
  AppThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppThemeMode.Light;
      case 1:
        return AppThemeMode.Dark;
      case 2:
        return AppThemeMode.System;
      default:
        return AppThemeMode.Light;
    }
  }

  @override
  void write(BinaryWriter writer, AppThemeMode obj) {
    switch (obj) {
      case AppThemeMode.Light:
        writer.writeByte(0);
        break;
      case AppThemeMode.Dark:
        writer.writeByte(1);
        break;
      case AppThemeMode.System:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppThemeModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
