import 'dart:io';
import 'package:dio/dio.dart';

import '../constant/network_constants.dart';
import '../constant/network_configuration.dart';

abstract class GetWebRequestServices {
  Future<RESPONSE_MAP_TYPE> getRequest(String endPoint);
  Future<RESPONSE_MAP_TYPE> getIdFilterRequest(
      {required String endPoint, required int id});

  Future<RESPONSE_MAP_TYPE> getSingleEntityFilterRequest({
    required String endPoint,
    required String entityName,
    required String value,
  });

  Future<RESPONSE_MAP_TYPE> getRelationalFilterRequest({
    required String endPoint,
    required String attribute,
    required String entityName,
    required String value,
  });
}

class DioGetWebRequestService implements GetWebRequestServices {
  /// FIXME: CHNAGE TRY AND CATCH FOR RESPONSE.
  @override
  Future<RESPONSE_MAP_TYPE> getRequest(String endPoint) async {
    try {
      final Response jsonResponse = await dioConnection.get(endPoint,
          queryParameters: POPULATE_API_QUERY);
      final RESPONSE_MAP_TYPE responseBody = jsonResponse.data;
      responseBody[RESPONSE_STATUS_CODE_KEY] = jsonResponse.statusCode;
      return responseBody;
    } catch (error) {
      return {RESPONSE_STATUS_CODE_KEY: -1};
    }
  }

  @override
  Future<RESPONSE_MAP_TYPE> getRelationalFilterRequest({
    required String endPoint,
    required String attribute,
    required String entityName,
    required String value,
  }) async {
    /// * Create Query parameters.
    final Map<String, dynamic> queryParameters = {
      'filters[' + attribute + '][' + entityName + '][\$eq]': value.toString(),
    };

    queryParameters.addEntries(POPULATE_API_QUERY.entries);

    // * Try to send request.
    try {
      final Response response = await dioConnection.get(
        endPoint,
        queryParameters: queryParameters,
      );

      final RESPONSE_MAP_TYPE returnMap = response.data;
      returnMap[RESPONSE_STATUS_CODE_KEY] = response.statusCode;
      return returnMap;
    } catch (error) {
      return {RESPONSE_STATUS_CODE_KEY: -1};
    }
  }

  ////////////////////////////////////////////////////////////////////////

  /// TODO: Complete filter request.
  @override
  Future<RESPONSE_MAP_TYPE> getIdFilterRequest(
      {required String endPoint, required int id}) {
    // TODO: implement getIdFilterRequest
    throw UnimplementedError();
  }

  @override
  Future<RESPONSE_MAP_TYPE> getSingleEntityFilterRequest(
      {required String endPoint,
      required String entityName,
      required String value}) {
    // TODO: implement getSingleEntityFilterRequest
    throw UnimplementedError();
  }
}
