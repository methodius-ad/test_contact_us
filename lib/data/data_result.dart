import 'package:dio/dio.dart';

class DataResult<T> {
  final T? data;
  final String? errorMessage;

  DataResult({this.data, this.errorMessage});

  factory DataResult.fromResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return DataResult(data: response.data);
    } else {
      return DataResult(errorMessage: "Request failed with status code ${response.statusCode}");
    }
  }

  bool isSuccess() {
    return data != null;
  }
}