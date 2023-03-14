import 'package:dartz/dartz.dart';

import '../../utils/data/universal_data.dart';
import '../models/clientmodel.dart';
import '../web/auth_web_services.dart';
import '../local_services/auth_local_service.dart';

class AuthRepository {
  // ******************* * Private attributes. **************** /
  final AuthWebServices _webServices = AuthWebServices();
  final AuthLocalService _localService = AuthLocalService();

  //////////////////////////////////////////////////////////////////////////////////

  /// *************************** * Web Services. *************************** /

  /// ***************** * Login Method. ***************** /

  Future<Either<String, ClientModel>> loginRepository(
      {required String email, required String password}) async {
    Either<String, ClientModel> returnSide = Left('');
    final UserModel? userResponse =
        await _webServices.requestUserAuth(email: email, password: password);

    if (userResponse != null) {
      final ClientModel? clientResponse = await _webServices.requestClientData(
          userId: userResponse.userId, password: password);

      if (clientResponse != null) {
        returnSide = Right(clientResponse);
      } else {
        return Left(
          appLanguage == 'en'
              ? 'Sorry can\'t find your account\nPLease Contact us'
              : 'عذرا لا يمكن العثور على حسابك \n الرجاء الاتصال بنا',
        );
      }
    } else {
      returnSide = Left(
        appLanguage == 'en'
            ? 'Sorry can\'t login to your account\nPLease Try Again'
            : 'عذرا لا يمكن تسجيل الدخول إلى حسابك \n الرجاء المحاولة مرة أخرى',
      );
    }

    return returnSide;
  }

  ///////////////////////////////////////////////////////

  /// ***************** * Sign up Method. ***************** /

  //////////////////////////////////////////////////////////////////////////////////

  /// *************************** * Local  Services. *************************** /

  /// ***************** * Read cached Method. ***************** /

  UserModel? readCached() {
    return _localService.readCachedRequest();
  }

  ///////////////////////////////////////////////////////

  /// ***************** * Save cached Method. ***************** /
  Future<bool> saveCached(UserModel userModel) async {
    return _localService.saveCachedRequest(userModel.toLocalService());
  }
}
