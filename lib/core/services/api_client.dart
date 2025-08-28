import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hari_tari/core/exceptions/exceptions.dart';

class DioClient {
  final Dio _dio;
  final String baseUrl;

  DioClient({Dio? client, required this.baseUrl}) : _dio = client ?? Dio() {
    _dio.options.headers = {'Content-Type': 'application/json'};
    _dio.options.baseUrl = baseUrl;
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Performs a GET request
  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get('$endpoint');

      return _processResponse(response, () => get(endpoint));
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  /// Performs a POST request
  Future<Response> post(String endpoint, {dynamic body}) async {
    try {
      final response = await _dio.post('$endpoint', data: body);

      return await _processResponse(response, () => post(endpoint, body: body));
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  /// Performs a PUT request
  Future<Response> put(String endpoint, {dynamic body}) async {
    try {
      final response = await _dio.put('$endpoint', data: jsonEncode(body));

      return await _processResponse(response, () => put(endpoint, body: body));
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  /// Process API response
  Future<Response> _processResponse(
    Response response,
    Future<dynamic> Function() retryRequest,
  ) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 400:
        throw BadRequestException(response.data, response: response);
      // case 401:
      //   return await _handleUnauthorized(retryRequest);
      case 403:
        throw UnauthorizedException(response.data);
      case 404:
        throw NotFoundException(response.data);
      case 500:
      default:
        throw ServerException(response.data);
    }
  }

  Dio get dio => _dio;
}
