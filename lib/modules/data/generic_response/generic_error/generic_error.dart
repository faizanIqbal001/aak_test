import 'package:aak_test/export.dart';

class GenericError {
  final String message;
  final int statusCode;

  GenericError({
    required this.message,
    required this.statusCode,
  });
}
