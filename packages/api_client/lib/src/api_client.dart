import 'package:api_client/src/errors/network_error.dart';
import 'package:dio/dio.dart';

class ApiClient implements Interceptor {
  late Dio _dio;
  static const String baseUrl = 'http://2.59.41.159:5001/';
  Dio get dio => _dio;
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
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
