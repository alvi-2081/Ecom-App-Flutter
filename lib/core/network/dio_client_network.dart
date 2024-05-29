import 'package:dio/dio.dart';
import 'package:ecommerece_app/core/constants/http_constants.dart';

class DioClientNetwork {
  late Dio dio;

  Future<void> initializeDioClientNetwork({
    String? token,
    String? userId,
  }) async {
    dio = Dio();
    // dio.interceptors.add(
    //   LogInterceptor(
    //     responseBody: true,
    //     requestBody: true,
    //     // logPrint: LoggerUtil.logs
    //   ),
    // );

    dio.options = setBaseOptions();
  }

  BaseOptions setBaseOptions() {
    return BaseOptions(
      baseUrl: HttpConstants.base,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
    );
  }
}
