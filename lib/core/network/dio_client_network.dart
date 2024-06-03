import 'package:dio/dio.dart';
import 'package:ecommerece_app/core/constants/http_constants.dart';

class DioClientNetwork {
  late Dio dio;

  Future<void> initializeDioClientNetwork({
    String? token,
    String? userId,
  }) async {
    dio = Dio();
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        // logPrint: LoggerUtil.logs
      ),
    );

    dio.options = setBaseOptions();
  }

  void changeBaseUrl() {
    dio.options.baseUrl = HttpConstants.base;
    dio.options.headers = {'Content-Type': 'application/json'};
  }

  void changeAuthBaseUrl() {
    dio.options.baseUrl = HttpConstants.authBase;
    dio.options.headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  }

  BaseOptions setBaseOptions() {
    return BaseOptions(
      baseUrl: HttpConstants.authBase,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
    );
  }
}
