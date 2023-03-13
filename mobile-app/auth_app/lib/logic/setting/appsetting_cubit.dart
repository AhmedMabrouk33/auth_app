import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/data/universal_data.dart';

part 'appsetting_state.dart';

class AppSettingCubit extends HydratedCubit<AppSettingState> {
  AppSettingCubit() : super(AppSettingState(appLanguage)) {
    appLanguage = state.languageSetting;
  }

  void changeLanguageSetting() {
    appLanguage = state.languageSetting == 'en' ? 'ar' : 'en';

    emit(AppSettingState(appLanguage));
  }

  @override
  AppSettingState? fromJson(Map<String, dynamic> json) {
    return AppSettingState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AppSettingState state) {
    return state.toMap();
  }
}
