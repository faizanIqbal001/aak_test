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

  Future<Either<String, GenericError>> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    dynamic encoding,
    bool modifyHeader = true,
    bool encodeBody = true,
  });

  Future<Either<String, GenericError>> multipart(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    dynamic files,
  });

  Future<Either<Map<String, dynamic>, GenericError>> multipartWithDio(
    String url, {
    dynamic formData,
    String header,
  });

  Future<Either<String, GenericError>> delete(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  Future<Either<String, GenericError>> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    dynamic encoding,
  });

  Future<Map<String, String>> appendHeader({
    Map<String, String>? headers,
    String url,
  });

  Future<Either<String, GenericError>> handleResponse({
    http.Response response,
  });
}
