import 'package:aak_test/export.dart';

class GenericSuccess {
  GenericSuccess({
    String? data,
  });

  factory GenericSuccess.fromJson(Map<String, Object?> json) {
    return GenericSuccess(
      data: json['data'] as String?,
    );
  }
}
