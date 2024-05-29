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
      throw _getExceptionForStatusCode(response.statusCode);
    }
  }

  Future _handleError(DioException error) async {
    switch (error.type) {
      case DioException.connectionTimeout:
      case DioException.sendTimeout:
      case DioException.receiveTimeout:
        throw NetworkException('Request timeout');
      case DioException.requestCancelled:
        break;
      case DioException.badResponse:
        throw _getExceptionForStatusCode(error.response?.statusCode);
      case DioException.connectionError:
        throw Exception('Connection error');
      default:
        throw Exception('Unhandle exception error');
    }
  }

  Exception _getExceptionForStatusCode(int? statusCode) {
    if (statusCode == null) {
      return Exception('No status code provided');
    }
    if (statusCode >= 400 && statusCode < 500) {
      return BadRequestException('Bad request (status code: $statusCode)');
    } else if (statusCode >= 500) {
      return ServerException(
          'Internal server error (status code: $statusCode)');
    } else {
      return Exception('Unexpected status code: $statusCode');
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
