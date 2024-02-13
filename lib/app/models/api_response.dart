class ApiResponse<T> {
  final bool succeeded;
  final String? message;
  final dynamic errors;

  final T data;

  ApiResponse(this.succeeded, this.message, this.errors, this.data);

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      json['success'] ?? false,
      json['message'],
      json['errors'],
      fromJsonT(json['data']['result']),
    );
  }
}
