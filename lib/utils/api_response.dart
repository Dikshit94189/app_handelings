enum Status {loading , complete , error}

class ApiResponse<T>{
  Status status;
  T? data;
  String? message;

  ApiResponse.loading() : status = Status.loading;
  ApiResponse.complete() : status = Status.complete;
  ApiResponse.error() : status = Status.error;
}