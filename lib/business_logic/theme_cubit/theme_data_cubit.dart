import 'package:conic/manager/manager.dart';
import 'package:conic/models/hive_models/hive_modals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeDataCubit extends Cubit<AppThemeMode> {
  ThemeDataCubit() : super(AppThemeModeManager().getThemeMode()) {
    Hive.box<AppThemeMode>(appThemeKey).watch().listen((event) {
      emit(event.value as AppThemeMode);
    });
  }

  void changeTheme({
    required AppThemeMode mode,
  }) {
    AppThemeModeManager().changeTheme(mode: mode);
    emit(mode);
  }
}
