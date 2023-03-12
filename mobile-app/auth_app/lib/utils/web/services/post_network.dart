import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../constant/api_end_point.dart' show IMAGE_ENDPOINT;
import '../constant/network_constants.dart';
import '../constant/network_configuration.dart';

abstract class PostWebRequestServices {
  Future<RESPONSE_MAP_TYPE> postRequest({
    required String endPoint,
    required RESPONSE_MAP_TYPE postBody,
  });

  Future<RESPONSE_MAP_TYPE> postNewImageRequest({
    required String imagePath,
    required String imageName,
  });

  Future<RESPONSE_MAP_TYPE> authRequest({
    String? userName,
    required String endPoint,
    required RESPONSE_MAP_TYPE body,
  });
}

class DioPostWebRequestService implements PostWebRequestServices {
  @override
  Future<RESPONSE_MAP_TYPE> authRequest({
    String? userName,
    required String endPoint,
    required RESPONSE_MAP_TYPE body,
  }) async {
    final String postBody = jsonEncode(body);
    try {
      final Response jsonResponse = await dioConnection.post(
        endPoint,
        data: postBody,
        queryParameters: POPULATE_API_QUERY,
      );

      RESPONSE_MAP_TYPE responseBody = jsonResponse.data;
      dioConnection.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer' + responseBody['jwt'];
      responseBody.remove('jwt');
      responseBody[RESPONSE_STATUS_CODE_KEY] = jsonResponse.statusCode;
      return responseBody;
    } catch (error) {
      return {RESPONSE_STATUS_CODE_KEY: -1};
    }
  }

  @override
  Future<RESPONSE_MAP_TYPE> postNewImageRequest({
    required String imagePath,
    required String imageName,
  }) async {
    final formData = FormData.fromMap(
      {
        'files': await MultipartFile.fromFile(
          imagePath,
          filename: imageName,
          contentType: MediaType('image', ''),
        ),
      },
    );

    try {
      final Response response = await dioConnection.post(
        IMAGE_ENDPOINT,
        data: formData,
        queryParameters: POPULATE_API_QUERY,
      );

      Map<String, dynamic> returnMap = response.data.first;

      returnMap[RESPONSE_STATUS_CODE_KEY] = response.statusCode;

      return returnMap;
    } catch (error) {
      // FIXME remove this print line.
      print(error);
      return {RESPONSE_STATUS_CODE_KEY: -1};
    }
  }

  @override
  Future<RESPONSE_MAP_TYPE> postRequest({
    required String endPoint,
    required RESPONSE_MAP_TYPE postBody,
  }) async {
    final String dioBody = jsonEncode(
      {
        'data': postBody,
      },
    );

    try {
      final Response response = await dioConnection.post(
        endPoint,
        data: dioBody,
        queryParameters: POPULATE_API_QUERY,
      );

      final Map<String, dynamic> returnMap = response.data;

      returnMap[RESPONSE_STATUS_CODE_KEY] = response.statusCode;
      return returnMap;
    } catch (error) {
      // FIXME remove this print line.
      print('Post request Error message is $error');
      return {RESPONSE_STATUS_CODE_KEY: -1};
    }
  }
}
