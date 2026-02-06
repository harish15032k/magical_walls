import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class BaseApiService {
  Future<Map<String, dynamic>> post(String url, dynamic data, {String? token});
  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? params, String? token});
  Future<Map<String, dynamic>> delete(String url, {Map<String, dynamic>? params, String? token});
  Future<Map<String, dynamic>> upload(
      String url,
      Map<String, String> fields,
      List<PlatformFile> files, {
        String? token,
        Map<String, String>? fileFieldMap,
      });
}

class NetworkApiService extends BaseApiService {
  static const int _maxRetries = 3;
  static const Duration _timeout = Duration(seconds: 30);
  static const Duration _uploadTimeout = Duration(minutes: 2);
  static const Duration _initialBackoff = Duration(milliseconds: 400);

  // ✅ Reuse single client
  final http.Client _client = http.Client();

  @override
  Future<Map<String, dynamic>> post(String url, dynamic data, {String? token}) async {
    debugPrint("token $token");
    return _request(() async {
      return await _client
          .post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: _headers(token),
      )
          .timeout(_timeout);
    }, url, data);
  }

  @override
  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? params, String? token}) async {
    debugPrint("token $token");
    return _request(() async {
      final uri = Uri.parse(url).replace(
        queryParameters: params?.map((k, v) => MapEntry(k, v.toString())),
      );
      return await _client.get(uri, headers: _headers(token)).timeout(_timeout);
    }, url, params);
  }

  @override
  Future<Map<String, dynamic>> delete(String url, {Map<String, dynamic>? params, String? token}) async {
    return _request(() async {
      final uri = Uri.parse(url).replace(
        queryParameters: params?.map((k, v) => MapEntry(k, v.toString())),
      );
      return await _client.delete(uri, headers: _headers(token)).timeout(_timeout);
    }, url, params);
  }

  @override
  Future<Map<String, dynamic>> upload(
      String url,
      Map<String, String> fields,
      List<PlatformFile> files, {
        String? token,
        Map<String, String>? fileFieldMap,
      }) async {
    return _multipartRequest(() async {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(_headers(token))
        ..fields.addAll(fields);

      for (final file in files) {
        if (file.path != null) {
          final mimeType = lookupMimeType(file.path!) ?? 'application/octet-stream';

          // 👇 pick correct field name
          final fieldName = fileFieldMap?[file.name] ?? 'files[]';

          request.files.add(await http.MultipartFile.fromPath(
            fieldName,
            file.path!,
            contentType: MediaType.parse(mimeType),
          ));
        }
      }

      final streamedResponse =
      await _client.send(request).timeout(_uploadTimeout);
      return await http.Response.fromStream(streamedResponse);
    }, url, fields);
  }

  // -----------------------
  // 🔹 Private Helpers
  // -----------------------

  Future<Map<String, dynamic>> _request(
      Future<http.Response> Function() request,
      String url,
      dynamic data,
      ) async {
    int retryCount = 0;
    Duration backoff = _initialBackoff;

    while (retryCount < _maxRetries) {
      try {
        // ✅ Check connectivity
        final connectivityResult = await Connectivity().checkConnectivity();
        log('🌐 Network: $connectivityResult', name: 'API');
        if (connectivityResult == ConnectivityResult.none) {
          return _errorResponse('No internet connection');
        }

        final stopwatch = Stopwatch()..start();
        final response = await request();
        stopwatch.stop();

        log(
          '🔹 API CALL\n'
              'URL     : $url\n'
              'REQUEST : ${jsonEncode(data)}\n'
              'STATUS  : ${response.statusCode}\n'
              'HEADERS : ${response.headers}\n'
              'RESPONSE: ${response.body}\n'
              '⏱ Duration: ${stopwatch.elapsed.inMilliseconds} ms',
          name: 'API',
        );

        if ((response.statusCode == 503 || response.statusCode == 429) &&
            retryCount < _maxRetries - 1) {
          log(
            '⚠️ ${response.statusCode} for $url, retrying after ${backoff.inSeconds}s',
            name: 'API',
          );
          await Future.delayed(backoff);
          backoff *= 2;
          retryCount++;
          continue;
        }

        return _normalizeResponse(response);
      } on SocketException {
        return _errorResponse('No internet connection');
      } on TimeoutException {
        if (retryCount < _maxRetries - 1) {
          await Future.delayed(backoff);
          backoff *= 2;
          retryCount++;
          continue;
        }
        return _errorResponse('Request timed out');
      } on FormatException {
        return _errorResponse('Invalid response format');
      } catch (e) {
        log('🔥 Unexpected error on $url: $e', name: 'API');
        return _errorResponse('Something went wrong');
      }
    }
    return _errorResponse('Request failed after $_maxRetries retries');
  }

  Future<Map<String, dynamic>> _multipartRequest(
      Future<http.Response> Function() request,
      String url,
      dynamic data,
      ) async {
    int retryCount = 0;
    Duration backoff = _initialBackoff;

    while (retryCount < _maxRetries) {
      try {
        final stopwatch = Stopwatch()..start();
        final response = await request();
        stopwatch.stop();

        log(
          '🔹 MULTIPART API CALL\n'
              'URL     : $url\n'
              'REQUEST : $data\n'
              'STATUS  : ${response.statusCode}\n'
              'HEADERS : ${response.headers}\n'
              'RESPONSE: ${response.body}\n'
              '⏱ Duration: ${stopwatch.elapsed.inMilliseconds} ms',
          name: 'API',
        );

        if ((response.statusCode == 503 || response.statusCode == 429) &&
            retryCount < _maxRetries - 1) {
          await Future.delayed(backoff);
          backoff *= 2;
          retryCount++;
          continue;
        }

        return _normalizeResponse(response);
      } on SocketException {
        return _errorResponse('No internet connection');
      } on TimeoutException {
        if (retryCount < _maxRetries - 1) {
          await Future.delayed(backoff);
          backoff *= 2;
          retryCount++;
          continue;
        }
        return _errorResponse('Upload timed out');
      } on FormatException {
        return _errorResponse('Invalid response format');
      } catch (e) {
        log('🔥 Multipart Error on $url: $e', name: 'API');
        return _errorResponse('Something went wrong');
      }
    }
    return _errorResponse('Upload failed after $_maxRetries retries');
  }

  Map<String, dynamic> _normalizeResponse(http.Response response) {
    try {
      final body = jsonDecode(response.body);

      final normalized = <String, dynamic>{
        'status': body['status'] ?? (response.statusCode >= 200 && response.statusCode < 300),
        'message': body['message'] ?? _defaultErrorMessage(response.statusCode),
        'data': body['data'],
      };

      // Merge other keys
      body.forEach((key, value) {
        normalized.putIfAbsent(key, () => value);
      });

      return normalized;
    } catch (_) {
      return _errorResponse('Invalid response format');
    }
  }

  String _defaultErrorMessage(int code) {
    switch (code) {
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Access denied.';
      case 404:
        return 'Resource not found.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Try again later.';
      case 503:
        return 'Service unavailable.';
      default:
        return 'Unexpected error ($code).';
    }
  }

  Map<String, String> _headers([String? token]) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
  };

  Map<String, dynamic> _errorResponse(String message) =>
      {'status': false, 'message': message, 'data': null};
}
