import 'package:aak_test/export.dart';

class GenericError {
  const GenericError({
    String? message,
    List<String>? errorMessages,
    String? error,
    int? statusCode,
    bool? status,
  });

  factory GenericError.fromJson(Map<String, Object?> json) {
    return GenericError(
      message: json['message'] as String?,
      errorMessages: (json['errorMessages'] as List<Object?>?)
          ?.map((e) => e as String)
          .toList(),
      error: json['error'] as String?,
      statusCode: json['statusCode'] as int?,
      status: json['status'] as bool?,
    );
  }
}
