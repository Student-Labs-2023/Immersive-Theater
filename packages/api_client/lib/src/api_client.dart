import 'package:api_client/src/errors/network_error.dart';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;

const String baseUrlIos = "http://127.0.0.1:1337";
const String baseUrlAndroid = "http://10.0.2.2:1337";

class ApiClient implements Interceptor {
  late Dio _dio;
  static String baseUrl = Platform.isAndroid ? baseUrlAndroid : baseUrlIos;
  Dio get dio => _dio;
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '$baseUrl/api/',
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300 ||
              status == 304;
        },
      ),
    )..interceptors.add(this);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final networkError = NetworkError(err);
    handler.next(networkError);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
