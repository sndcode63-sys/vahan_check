import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../utils/app_logger.dart';
import '../utils/secure_storage_service.dart';
import 'api_response.dart';
import 'network_exceptions.dart';

class ApiClient {
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),
        headers: {
          "Content-Type": ApiConstants.contentType,
          "Accept": "application/json",
        },
      ),
    );
    _dio.interceptors.add(_LoggingInterceptor());
    _dio.interceptors.add(_AuthInterceptor());
  }

  static final ApiClient instance = ApiClient._internal();
  late final Dio _dio;

  Dio get dio => _dio;

  //  GENERIC METHODS
  // GET API

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    required T Function(dynamic json) fromJson,
  }) async {
    return _safeCall<T>(() => _dio.get(path, queryParameters: queryParams), fromJson);
  }

  // POST API
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic body,
    required T Function(dynamic json) fromJson,
  }) async {
    return _safeCall<T>(() => _dio.post(path, data: body), fromJson);
  }

  // PUT API
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic body,
    required T Function(dynamic json) fromJson,
  }) async {
    return _safeCall<T>(() => _dio.put(path, data: body), fromJson);
  }

  // DELETE API

  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic body,
    required T Function(dynamic json) fromJson,
  }) async {
    return _safeCall<T>(() => _dio.delete(path, data: body), fromJson);
  }

  //  CORE SAFE WRAPPER

  Future<ApiResponse<T>> _safeCall<T>(
    Future<Response> Function() request,
    T Function(dynamic json) fromJson,
  ) async {
    try {
      final response = await request();
      final parsedData = fromJson(response.data);
      return ApiResponse.success(parsedData);
    } on DioException catch (e, stack) {
      final message = NetworkExceptions.getErrorMessage(e);
      AppLogger.e(
        "API call failed: $message",
        error: e,
        stack: stack,
      );
      return ApiResponse.error(message, statusCode: e.response?.statusCode);
    } catch (e, stack) {
      AppLogger.e("Unexpected error", error: e, stack: stack);
      return ApiResponse.error("Unexpected error: ${e.toString()}");
    }
  }
}

// Auto request/response logging via AppLogger
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.apiRequest(
      method: options.method,
      url: options.uri.toString(),
      headers: options.headers,
      body: options.data,
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.apiResponse(
      url: response.requestOptions.uri.toString(),
      statusCode: response.statusCode,
      body: response.data,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.apiError(
      url: err.requestOptions.uri.toString(),
      message: NetworkExceptions.getErrorMessage(err),
      statusCode: err.response?.statusCode,
    );
    handler.next(err);
  }
}


class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authHeaderKey] = "Bearer $token";
    }
    handler.next(options);
  }
}
