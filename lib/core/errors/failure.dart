import 'package:equatable/equatable.dart';

/// Base class for all failures.
abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

/// Failure for server-related errors (e.g., API errors).
class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  String toString() => 'ServerFailure: $message';
}

/// Failure for network issues (e.g., no internet connection).
class NetworkFailure extends Failure {
  const NetworkFailure({super.message});

  @override
  String toString() => 'NetworkFailure: $message';
}

/// Failure for cache-related issues (e.g., reading/writing to local storage).
class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  String toString() => 'CacheFailure: $message';
}

/// Failure for validation-related issues (e.g., invalid inputs).
class ValidationFailure extends Failure {
  const ValidationFailure({super.message});

  @override
  String toString() => 'ValidationFailure: $message';
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});

  @override
  String toString() => 'ServerException: $message';
}

class ClientException implements Exception {
  final String message;
  ClientException({required this.message});

  @override
  String toString() => 'ClientException: $message';
}
