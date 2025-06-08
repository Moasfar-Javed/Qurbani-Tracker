part of 'models.dart';

class GenericApiResponse {
  String? message;
  bool status;

  GenericApiResponse({required this.message, required this.status});

  factory GenericApiResponse.fromJson(Map<String, dynamic> json) {
    return GenericApiResponse(
      message: json['message'],
      status: json['status'] ?? false,
    );
  }
}

class ApiResponse<T> extends GenericApiResponse {
  T? data;

  ApiResponse({required super.message, required super.status, this.data});
}

class ApiCallResponse<T> {
  final bool isSuccess;
  final String? message;
  final T? data;

  ApiCallResponse(this.isSuccess, this.message, {this.data});

  factory ApiCallResponse.withResult(bool isSuccess, String? message, T? data) {
    return ApiCallResponse(isSuccess, message, data: data);
  }
}
