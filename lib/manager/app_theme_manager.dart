import 'package:conic/models/hive_models/hive_modals.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const appThemeKey = "Theme_Mode";

class AppThemeModeManager {
  static final AppThemeModeManager _instance = AppThemeModeManager._internal();
  final Box<AppThemeMode> appThemeStorageBox =
      Hive.box<AppThemeMode>(appThemeKey);

  factory AppThemeModeManager() {
    return _instance;
  }

  AppThemeModeManager._internal();

  void changeTheme({
    required AppThemeMode mode,
  }) {
    appThemeStorageBox.put("mode", mode);
  }

  AppThemeMode getThemeMode() {
    return appThemeStorageBox.get("mode") ?? AppThemeMode.Dark;
  }

  ThemeData getTheme() {
    return getThemeMode() == AppThemeMode.Dark ? darkTheme : lightTheme;
  }
}
