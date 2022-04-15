import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';

class ApiResponse<T> {
  ApiResponseStatus status;
  T? data;
  String? message;

  ApiResponse.idle() : status = ApiResponseStatus.idle;

  ApiResponse.loading(this.message) : status = ApiResponseStatus.loading;

  ApiResponse.completed(this.data) : status = ApiResponseStatus.completed;

  ApiResponse.unProcessable(this.message) : status = ApiResponseStatus.unProcessable;

  ApiResponse.error(this.message) : status = ApiResponseStatus.error;

  @override
  String toString() {
    return "ApiResponseStatus : $status \n Message : $message \n Data : $data";
  }
}
