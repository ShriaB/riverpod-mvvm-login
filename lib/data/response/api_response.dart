import 'package:riverpod_mvvm_login/data/response/status.dart';

/// [status] stores the current status of the API call (loading/successful/error)
/// [data] Stores the data if the API request is successful
/// [error] Stores the type of error in case the request failed

class ApiResponse<T> {
  Status? status;
  T? data;
  Error? error;

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.success(this.data) : status = Status.SUCCESS;

  ApiResponse.error(this.error) : status = Status.ERROR;
}
