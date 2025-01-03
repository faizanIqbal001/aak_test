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
    required this.onGettingServerException,
  });

  final Function onTokenExpire;
  final Function onClientExpire;
  final http.Client client;
  final Dio dio;
  final Function(String exception) onGettingServerException;

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
        return const Right(
          GenericError(
            status: false,
            message: 'Please check you internet and try again',
          ),
        );
      }
      return Right(
        GenericError(
          status: false,
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
        return const Right(
          GenericError(
            status: false,
            message: 'Please check you internet and try again',
          ),
        );
      }

      if (e is http.ClientException) {
        _clientExceptionLogs(e);
        onClientExpire();
        return Right(
          GenericError(
            status: false,
            message: e.toString(),
          ),
        );
      }

      return Right(
        GenericError(
          status: false,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<String, GenericError>> multipart(
      String url, {
        Map<String, String>? headers,
        dynamic body,
        dynamic files,
      }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      print('url: $url');

      // Add body fields to the request
      if (body != null) {
        body.forEach((dynamic key, dynamic value) {
          request.fields[key] = value;
        });
      }

      // Add headers to the request
      headers?.forEach((key, value) {
        request.headers[key] = value;
      });

      // Add files to the request
      if (files != null) {
        for (var entry in files.entries) {
          final fileField = entry.key;
          final filePath = entry.value;

          if (filePath != null) {
            request.files.add(
              await http.MultipartFile.fromPath(
                fileField,
                filePath,
                // Optional: you can specify the content type if known
                //  contentType: MediaType('image', 'jpeg'), // for example, for JPEG images
              ),
            );
          }
        }
      }

      final response = await request.send();
      final responseText = await response.stream.bytesToString();
      final statusCode = response.statusCode;

      print('responseText: $responseText');

      if (statusCode >= 400) {
        return const Right(
          GenericError(
            status: false,
            message: 'Something went wrong',
          ),
        );
      } else {
        return Left(responseText);
      }
    } catch (e) {
      final internet = await _checkInternetConnection();
      if (e is SocketException || !internet) {
        return const Right(
          GenericError(
            status: false,
            message: 'Please check your internet and try again',
          ),
        );
      }

      if (e is http.ClientException) {
        _clientExceptionLogs(e);
        onClientExpire();
        return Right(
          GenericError(
            status: false,
            message: e.toString(),
          ),
        );
      }
      return Right(
        GenericError(
          status: false,
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
  Future<Either<String, GenericError>> put(
      String url, {
        Map<String, String>? headers,
        dynamic body,
        dynamic encoding,
      }) async {
    try {
      debugPrint('PUT--> URL: $url');
      debugPrint('PUT--> BODY: ${json.encode(body)}');
      final response = await client.put(
        Uri.parse(url),
        body: json.encode(body),
        headers: await appendHeader(
          headers: headers,
          url: url,
        ),
        encoding: encoding,
      );
      return handleResponse(
        response: response,
        url: url,
      );
    } catch (e) {
      final internet = await _checkInternetConnection();
      if (e is SocketException || !internet) {
        return const Right(
          GenericError(
            status: false,
            message: 'Please check you internet and try again',
          ),
        );
      }

      if (e is http.ClientException) {
        _clientExceptionLogs(e);
        onClientExpire();
        return Right(
          GenericError(
            status: false,
            message: e.toString(),
          ),
        );
      }
      return Right(
        GenericError(
          status: false,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<String, GenericError>> patch(
      String url, {
        Map<String, String>? headers,
        dynamic body,
        dynamic encoding,
        bool modifyHeader = true,
        bool encodeBody = true,
      }) async {
    try {
      debugPrint('patch--> URL: $url');
      debugPrint('patch--> BODY: ${json.encode(body)}');
      final response = await client.patch(
        Uri.parse(url),
        headers: modifyHeader
            ? await appendHeader(
          headers: headers,
          url: url,
        )
            : headers!,
        encoding: encoding,
        body: body == null ? null : json.encode(body),
      );

      return handleResponse(
        response: response,
        url: url,
        requestBody: json.encode(
          body,
        ),
      );
    } catch (e) {
      final internet = await _checkInternetConnection();
      if (e is SocketException || !internet) {
        return const Right(
          GenericError(
            status: false,
            message: 'Please check you internet and try again',
          ),
        );
      }

      if (e is http.ClientException) {
        _clientExceptionLogs(e);
        onClientExpire();
        return Right(
          GenericError(
            status: false,
            message: e.toString(),
          ),
        );
      }
      return Right(
        GenericError(
          status: false,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Map<String, dynamic>, GenericError>> multipartWithDio(
      String url, {
        dynamic formData,
        String? header,
      }) async {
    try {
      final response = await dio.request<dynamic>(
        url,
        data: formData,
        options: Options(
          method: 'POST',
          headers: {
            'Content-Type': 'multipart/form-data',
            if (header != null) 'Authorization': 'Bearer $header',
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return Left(response.data as Map<String, dynamic>);
      } else {
        return const Right(
          GenericError(
            status: false,
            message: 'Unexpected response format from server',
          ),
        );
      }
    } on DioException catch (e) {
      final internet = await _checkInternetConnection();
      if (e.type == DioExceptionType.connectionError || !internet) {
        return const Right(
          GenericError(
            status: false,
            message: 'Please check your internet connection and try again',
          ),
        );
      }

      return Right(
        GenericError(
          status: false,
          message: e.response?.data?['message'] ?? 'Something went wrong!',
        ),
      );
    }
  }

  @override
  Future<Either<String, GenericError>> handleResponse({
    http.Response? response,
    String? requestBody,
    String? url,
  }) async {
    final statusCode = response!.statusCode;
    print('Status code $statusCode');
    if (statusCode >= 400) {
      if (statusCode >= 500) {
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('text/html')) {
          onGettingServerException('Received an html from server');
          return const Right(
            GenericError(
              status: false,
              message: 'Something went wrong with server, try again later',
            ),
          );
        }
        final errorJson = jsonDecode(response.body);
        // onGettingServerException(_extractErrorMessage(errorJson));
        return Right(
          GenericError(
            status: false,
            message: _extractErrorMessage(errorJson) ??
                'Something went wrong with server, try again later',
          ),
        );
      }
      final errorJson = jsonDecode(response.body);
      return Right(
        GenericError(
          status: false,
          message: _extractErrorMessage(errorJson),
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
            status: false,
            message: _extractErrorMessage(errorJson),
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
