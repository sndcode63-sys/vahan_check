
class ApiResponse<T> {
  final Status status;
  final T? data;
  final String? message;
  final int? statusCode;

  ApiResponse.loading()
      : status = Status.loading,
        data = null,
        message = null,
        statusCode = null;

  ApiResponse.success(this.data)
      : status = Status.success,
        message = null,
        statusCode = 200;

  ApiResponse.error(this.message, {this.statusCode})
      : status = Status.error,
        data = null;

  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
  bool get isLoading => status == Status.loading;

  @override
  String toString() {
    return "ApiResponse(status: $status, data: $data, message: $message, code: $statusCode)";
  }
}

enum Status { loading, success, error }
