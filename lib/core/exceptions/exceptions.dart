import 'package:dio/dio.dart';

/// Base Exception class
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

/// Network related exceptions
class NetworkException extends AppException {
  NetworkException(super.message);
}

/// Server related exceptions
class ServerException extends AppException {
  ServerException(super.message);
}

/// Bad request exception
class BadRequestException extends AppException {
  BadRequestException(super.message, {required this.response});
  final Response response;
}

/// Unauthorized exception
class UnauthorizedException extends AppException {
  UnauthorizedException(super.message);
}

/// Not found exception
class NotFoundException extends AppException {
  NotFoundException(super.message);
}
