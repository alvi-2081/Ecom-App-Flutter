import 'package:dio/dio.dart';
import 'package:ecommerece_app/main.dart';
import 'package:ecommerece_app/core/network/dio_client_network.dart';

class DioApiServices {
  Future<dynamic> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await getIt<DioClientNetwork>()
          .dio
          .get(url, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> postRequest(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await getIt<DioClientNetwork>().dio.post(url,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> putRequest(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await getIt<DioClientNetwork>().dio.put(url,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> deleteRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await getIt<DioClientNetwork>().dio.delete(url,
          queryParameters: queryParameters, options: Options(headers: headers));
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> _handleResponse(Response response) async {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      return _getExceptionForStatusCode(response);
    }
  }

  Future _handleError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.badResponse:
        return _getExceptionForStatusCode(
            error.response ?? Response(requestOptions: RequestOptions()));
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Request timeout');
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw Exception('Connection error');
      default:
        throw Exception('Something went wrong');
    }
  }

  _getExceptionForStatusCode(Response response) {
    if (response.statusCode == null) {
      throw Exception('No status code provided');
    }
    if (response.statusCode! == 401 || response.statusCode! == 400) {
      return response.data;
    } else if (response.statusCode! >= 500) {
      throw ServerException('Internal server error');
    } else {
      throw Exception('Something went wrong');
    }
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}
