import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/clientmodel.dart';

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
///   # en,
///     or
///   # ar.
///
String appLanguage = 'en';

///
/// Global variable: Client Model.
/// Can save in it:
///   # Client data which get from backend.
///
late ClientModel clientData;

// ClientModel clientData = ClientModel(
//   clientId: -1,
//   phoneNo: '',
//   dateOfBirth: '',
//   user: UserModel(
//     userId: -1,
//     userName: '',
//     email: '',
//     password: '',
//     isAutoLogin: false,
//   ),
//   clientLocation: [],
// );
