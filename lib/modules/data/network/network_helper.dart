import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../export.dart';

abstract class NetworkHelper {
  Future<Either<String, GenericError>> get(
    String url, {
    Map<String, String>? headers,
  });

  Future<Either<String, GenericError>> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    dynamic encoding,
    bool encodeBody,
  });

  Future<Map<String, String>> appendHeader({
    Map<String, String>? headers,
    String url,
  });

  Future<Either<String, GenericError>> handleResponse({
    http.Response response,
  });
}
