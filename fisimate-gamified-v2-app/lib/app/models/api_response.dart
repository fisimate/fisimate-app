class ApiResponse<T> {
  final bool success;
  final String? message;

  final T data;

  ApiResponse(
    this.success,
    this.message,
    this.data,
  );

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      json['success'] ?? false,
      json['message'],
      fromJsonT(json['data']['result']),
    );
  }
}
