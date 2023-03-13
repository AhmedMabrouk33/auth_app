import '../../utils/web/constant/network_constants.dart'
    show RESPONSE_MAP_TYPE, RESPONSE_STATUS_CODE_KEY;

import '../../utils/web/constant/api_end_point.dart';

import '../../utils/web/services/get_network.dart';
import '../../utils/web/services/post_network.dart';

import '../models/clientmodel.dart';
import '../models/imagemodel.dart';

class AuthWebServices {
  final GetWebRequestServices _getRequest = DioGetWebRequestService();
  final PostWebRequestServices _postRequest = DioPostWebRequestService();

  ////////////////////////////////////////////////////////////////////////

  // ********* * Read Requests *********** /
  Future<UserModel?> requestUserAuth(
      {required String email, required String password}) async {
    UserModel? tempUserObject = UserModel(
      userId: -1,
      userName: '',
      email: email,
      password: password,
      isAutoLogin: false,
    );
    RESPONSE_MAP_TYPE userResponse = await _postRequest.authRequest(
      endPoint: AUTH_LOCAL_ENDPOINT,
      body: tempUserObject.toWebService(isLogin: true),
    );

    print(
        'userResponse[RESPONSE_STATUS_CODE_KEY] is ${userResponse[RESPONSE_STATUS_CODE_KEY]}');

    if (userResponse[RESPONSE_STATUS_CODE_KEY] == 200) {
      tempUserObject = UserModel.fromWebService(
        userResponse['user'],
        isAttributeJson: false,
        password: password,
      );
    } else {
      tempUserObject = null;
    }

    return tempUserObject;
  }

  //////////////////////////////////////////////

  Future<ClientModel?> requestClientData(
      {required int userId, required String password}) async {
    ClientModel? tempClientObject = null;

    RESPONSE_MAP_TYPE clientResponse =
        await _getRequest.getRelationalFilterRequest(
      endPoint: CLIENTS_ENDPOINT,
      attribute: 'user',
      entityName: 'id',
      value: userId.toString(),
    );

    if (clientResponse[RESPONSE_STATUS_CODE_KEY] == 200) {
      tempClientObject = ClientModel.fromWebServices(
        clientResponse['data'].first,
        password: password,
      );
    }

    return tempClientObject;
  }

  ////////////////////////////////////////////////////////////////////////
  // ********* * Post Requests *********** /
}
