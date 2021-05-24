import 'package:hive/hive.dart';

part 'app_theme_mode.g.dart';

@HiveType(typeId: 5)
enum AppThemeMode {
  @HiveField(0)
  Light,
  @HiveField(1)
  Dark,
  @HiveField(2)
  System,
}
