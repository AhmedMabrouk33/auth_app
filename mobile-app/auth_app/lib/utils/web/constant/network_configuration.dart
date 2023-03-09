import 'dart:io';
import 'package:dio/dio.dart';

import 'network_constants.dart';

typedef RESPONSE_MAP_TYPE = Map<String, dynamic>;

final Dio dioConnection = Dio(dioConnectionBaseOptions);

BaseOptions dioConnectionBaseOptions = BaseOptions(
  baseUrl: API_BASE_URL,
  receiveDataWhenStatusError: true,
  connectTimeout: const Duration(seconds: 25), // 25 Seconds
  receiveTimeout: const Duration(seconds: 20), // 25 Seconds
  headers: {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  },
);
