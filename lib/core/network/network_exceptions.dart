import 'package:dio/dio.dart';

/// Saari DioException yaha handle hoti hai aur ek clean readable
/// String message me convert ho jaati hai. ApiClient ke andar hi use hota hai.
class NetworkExceptions {
  NetworkExceptions._();

  static String getErrorMessage(dynamic error) {
    String errorMessage = "Something went wrong. Please try again.";

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = "Connection timeout. Please check your internet.";
          break;

        case DioExceptionType.sendTimeout:
          errorMessage = "Sending data timeout. Please try again.";
          break;

        case DioExceptionType.receiveTimeout:
          errorMessage = "Server took too long to respond.";
          break;

        case DioExceptionType.badCertificate:
          errorMessage = "Security certificate error.";
          break;

        case DioExceptionType.connectionError:
          errorMessage = "No internet connection.";
          break;

        case DioExceptionType.cancel:
          errorMessage = "Request was cancelled.";
          break;

        case DioExceptionType.badResponse:
          errorMessage = _handleStatusCode(error.response?.statusCode, error);
          break;

        case DioExceptionType.unknown:
          errorMessage = error.message ?? errorMessage;
          break;

        default:
          errorMessage = error.message ?? errorMessage;
          break;
      }
    } else {
      errorMessage = error.toString();
    }

    return errorMessage;
  }

  static String _handleStatusCode(int? code, DioException error) {
    // Try to pull server's own error message first (common pattern)
    final serverMsg = _extractServerMessage(error.response?.data);

    switch (code) {
      case 400:
        return serverMsg ?? "Bad request.";
      case 401:
        return serverMsg ?? "Unauthorized. Please login again.";
      case 403:
        return serverMsg ?? "Access forbidden.";
      case 404:
        return serverMsg ?? "Requested resource not found.";
      case 409:
        return serverMsg ?? "Conflict occurred.";
      case 422:
        return serverMsg ?? "Validation error.";
      case 500:
        return serverMsg ?? "Internal server error.";
      case 502:
        return serverMsg ?? "Bad gateway.";
      case 503:
        return serverMsg ?? "Service unavailable.";
      default:
        return serverMsg ?? "Unexpected error occurred (code: $code).";
    }
  }

  static String? _extractServerMessage(dynamic data) {
    try {
      if (data is Map<String, dynamic>) {
        return data['message'] ?? data['error'] ?? data['msg'];
      }
    } catch (_) {}
    return null;
  }
}