import 'dart:convert';
import '../models/clientmodel.dart';
import '../../utils/data/universal_data.dart';

class AuthLocalService {
  // ********* * Read Requests *********** /
  UserModel? readCachedRequest() {
    String? userCached = sharedPreferences.getString('user');
    if (userCached != null) {
      return UserModel.fromLocalServices(jsonDecode(userCached));
    } else {
      return null;
    }
  }

  // ********* * Save Requests *********** /
  Future<bool> saveCachedRequest(Map<String, dynamic> userMap) async {
   return await sharedPreferences.setString('user', jsonEncode(userMap));
  }
}
