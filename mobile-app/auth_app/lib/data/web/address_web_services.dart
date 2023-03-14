import '../../../data/models/clientmodel.dart';

import '../../../data/models/citymodel.dart';

import '../../utils/web/services/get_network.dart';
import '../../utils/web/services/post_network.dart';

import '../../utils/web/constant/api_end_point.dart'
    show CLIENT_LOCATIONS_ENDPOINT, CITY_ENDPOINT;

import '../../utils/web/constant/network_constants.dart'
    show RESPONSE_MAP_TYPE, RESPONSE_STATUS_CODE_KEY;

class AddressWebService {
  // ******************* * Private attributes. **************** /
  final GetWebRequestServices _getRequest = DioGetWebRequestService();
  final PostWebRequestServices _postRequest = DioPostWebRequestService();

  ////////////////////////////////////////////////////////////////////////////

  // ******************* * Read cities. **************** /

  Future<List<CityModel>> readCitiesRequest() async {
    List<CityModel> cities = [];

    RESPONSE_MAP_TYPE citiesResponse =
        await _getRequest.getRequest(CITY_ENDPOINT);

    if (citiesResponse[RESPONSE_STATUS_CODE_KEY] == 200) {
      int responseLength = citiesResponse['data'].length;

      for (int index = 0; index < responseLength; index++) {
        cities.add(CityModel.fromWebService(citiesResponse['data'][index]));
      }
    }

    return cities;
  }

  ////////////////////////////////////////////////////////////////////////////

  // ******************* * Post location. **************** /

  Future<ClientLocationModel?> sendLocationRequest({
    required ClientLocationModel clientLocation,
    required int clientId,
  }) async {
    ClientLocationModel? tempClientLocation;

    RESPONSE_MAP_TYPE clientResponse = await _postRequest.postRequest(
      endPoint: CLIENT_LOCATIONS_ENDPOINT,
      postBody: clientLocation.toWebService(clientId: clientId),
    );

    if (clientResponse[RESPONSE_STATUS_CODE_KEY] == 200) {
      tempClientLocation = ClientLocationModel.fromWebService(
        clientResponse['data'],
      );
    }

    return tempClientLocation;
  }

  ////////////////////////////////////////////////////////////////////////////
}
