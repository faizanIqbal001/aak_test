import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:aak_test/export.dart';

import '../../../../export.dart';

class NetworkHelperImpl extends NetworkHelper {
  NetworkHelperImpl({
    required this.onTokenExpire,
    required this.onClientExpire,
    required this.client,
    required this.dio,
  });

  final Function onTokenExpire;
  final Function onClientExpire;
  final http.Client client;
  final Dio dio;

  @override
  Future<Either<String, GenericError>> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    debugPrint('GET--> URL: $url');
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: await appendHeader(
          headers: headers,
          url: url,
        ),
      );
      return handleResponse(
        response: response,
        url: url,
      );
    } catch (e) {
      if (e is SocketException || e is http.ClientException) {
        _clientExceptionLogs(e);
        return Right(
          GenericError(
            statusCode: 404,
            message: 'Please check you internet and try again',
          ),
        );
      }
      return Right(
        GenericError(
          statusCode: 404,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<String, GenericError>> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    dynamic encoding,
    bool modifyHeader = true,
    bool encodeBody = true,
  }) async {
    try {
      debugPrint('POST--> URL: $url');
      debugPrint('POST--> BODY: ${json.encode(body)}');
      final response = await client.post(
        Uri.parse(url),
        body: encodeBody ? (body != null ? json.encode(body) : '') : body,
        headers: headers ?? await appendHeader(headers: headers, url: url),
        encoding: encoding,
      );

      debugPrint('POST--> RESPONSE: ${response.body}');

      // if (response.body == null || response.body.isEmpty) {
      //   return const Right(
      //     GenericError(
      //       status: false,
      //       message: 'Response body is empty',
      //     ),
      //   );
      // }

      return handleResponse(
        response: response,
        requestBody: json.encode(body),
        url: url,
      );
    } catch (e) {
      final internet = await _checkInternetConnection();
      if (e is SocketException || !internet) {
        return Right(
          GenericError(
            statusCode: 404,
            message: 'Please check you internet and try again',
          ),
        );
      }

      return Right(
        GenericError(
          statusCode: 404,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<String, GenericError>> delete(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    return client
        .delete(
      Uri.parse(url),
      headers: await appendHeader(
        headers: headers,
        url: url,
      ),
      body: body,
    )
        .then((http.Response response) {
      return handleResponse(
        response: response,
        url: url,
      );
    });
  }

  @override
  Future<Either<String, GenericError>> handleResponse({
    http.Response? response,
    String? requestBody,
    String? url,
  }) async {
    final statusCode = response!.statusCode;
    if (statusCode >= 400) {
      if (statusCode >= 500) {
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('text/html')) {
          return Right(
            GenericError(
              statusCode: statusCode,
              message: 'Something went wrong with server, try again later',
            ),
          );
        }
        final errorJson = jsonDecode(response.body);
        // onGettingServerException(_extractErrorMessage(errorJson));
        return Right(
          GenericError(
            statusCode: statusCode,
            message: _extractErrorMessage(errorJson) ??
                'Something went wrong with server, try again later',
          ),
        );
      }
      final errorJson = response.body;
      return Right(
        GenericError(
          statusCode: statusCode,
          message: errorJson.toString(),
        ),
      );
    } else {
      if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
        if (statusCode == 204) {
          final content = response.body.toString();
          if (content.isNotEmpty) {
            return Left(content);
          } else {
            const Left('Successfully updated');
          }
        }
        return Left(response.body);
      } else {
        final errorJson = jsonDecode(response.body);
        return Right(
          GenericError(
            statusCode: 404,
            message: errorJson,
          ),
        );
      }
    }
  }

  String _extractErrorMessage(Map<String, dynamic> errorJson) {
    if (errorJson.containsKey('errors')) {
      final errors = errorJson['errors'];
      if (errors is Map<String, dynamic>) {
        return errors.values
            .map((e) => e is String ? e : e.toString())
            .join(', ');
      } else if (errors is List) {
        return errors.join(', ');
      } else if (errors is String) {
        return errors;
      }
    }

    return errorJson['message'] ?? 'An unknown error occurred';
  }

  @override
  Future<Map<String, String>> appendHeader({
    Map<String, String>? headers,
    bool refresh = false,
    String? url,
  }) async {
    try {
      headers ??= <String, String>{};
      headers['Content-Type'] = 'application/json';
    } catch (e) {}

    return headers!;
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final response =
          await http.get(Uri.parse('https://www.google.com')).timeout(
                const Duration(seconds: 5),
              );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void _clientExceptionLogs(dynamic e) {}
}
