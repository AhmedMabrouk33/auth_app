part of 'appsetting_cubit.dart';

class AppSettingState extends Equatable {
  String languageSetting;
  AppSettingState(this.languageSetting);

  @override
  List<Object> get props => [languageSetting];

  Map<String, dynamic> toMap() {
    return {
      'languageSetting': languageSetting,
    };
  }

  factory AppSettingState.fromMap(Map<String, dynamic> map) {
    return AppSettingState(
      map['languageSetting'] ?? '',
    );
  }

  
}
