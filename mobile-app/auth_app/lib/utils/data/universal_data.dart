import 'package:shared_preferences/shared_preferences.dart';

///
/// Global variable: Shared Preferences.
/// variable based on shared_preferences package.
/// 
/// Note: This variable will use in all local services.
///
late SharedPreferences sharedPreferences;

///
/// Global variable: App language.
/// Can save in it:
/// # en, # ar.
///
String appLanguage = 'en';
