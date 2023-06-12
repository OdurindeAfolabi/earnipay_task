import 'package:dio/dio.dart';

import '../../../app/utils/constants.dart';
import 'logging_interceptor.dart';

class DioFactory {
  final String _baseUrl;

  DioFactory(this._baseUrl);


  Map<String, String> headers = {
    "Authorization" : "Client-ID $clientIdToken",
  };

  BaseOptions _createBaseOptions() => BaseOptions(
        baseUrl: _baseUrl,
        receiveTimeout: 30 * 1000, //30 seconds
        sendTimeout: 30 * 1000,
        connectTimeout: 30 * 1000,
        headers: headers
      );

  Dio create() => Dio(_createBaseOptions())
    ..interceptors.addAll([
      LoggerInterceptor(),
    ]);
}
