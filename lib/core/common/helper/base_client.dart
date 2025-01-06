import 'package:dio/dio.dart';
import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/core/errors/failure.dart';

class BaseClient {
  static Future<BaseOptions> getBaseOptions() async {
    return BaseOptions(
      baseUrl: '', // Set your base URL here, if applicable
      followRedirects: false,
      validateStatus: (status) => status != null && status < 500,
      headers: {
        "Accept": "application/json",
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer ${await storage.read('token')}',
      },
    );
  }

  static Dio _getDio() => Dio()..interceptors.add(LogInterceptor(responseBody: true));

  /// GET request
  static Future<Response> get({required String url, Map<String, dynamic>? queryParameters}) async {
    try {
      final dio = _getDio()..options = await getBaseOptions();
      final response = await dio.get(url, queryParameters: queryParameters);
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST request
  static Future<Response> post({required String url, dynamic data}) async {
    try {
      final dio = _getDio()..options = await getBaseOptions();
      final response = await dio.post(url, data: data);
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST with Query Parameters
  static Future<Response> postWithQueryParameters({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final dio = _getDio()..options = await getBaseOptions();
      final response = await dio.post(url, queryParameters: queryParameters);
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT request
  static Future<Response> put({required String url, dynamic data}) async {
    try {
      final dio = _getDio()..options = await getBaseOptions();
      final response = await dio.put(url, data: data);
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE request
  static Future<Response> delete({required String url}) async {
    try {
      final dio = _getDio()..options = await getBaseOptions();
      final response = await dio.delete(url);
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handles HTTP responses
  static void _handleResponse(Response response) {
    if (response.statusCode! >= 400 && response.statusCode! < 500) {
      throw ClientException(
        message: 'Client Error: ${response.statusCode}, ${response.statusMessage}',
      );
    } else if (response.statusCode! >= 500) {
      throw ServerException(
        message: 'Server Error: ${response.statusCode}, ${response.statusMessage}',
      );
    }
  }

  /// Maps DioError to custom exceptions
  static Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response?.statusCode;
      final serverMessage = error.response?.data is Map ? error.response?.data['message'] ?? 'Unknown server error' : error.response?.statusMessage ?? 'Unknown error';

      if (statusCode != null && statusCode >= 400 && statusCode < 500) {
        return ClientException(message: 'Client Error: $statusCode, $serverMessage');
      } else if (statusCode != null && statusCode >= 500) {
        return ServerException(message: 'Server Error: $statusCode, $serverMessage');
      }
    }

    if (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection Timeout');
    }

    return Exception('Unexpected Error: ${error.message}');
  }
}

/// Custom exceptions for better error handling
