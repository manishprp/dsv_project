import 'dart:io';

import 'package:dio/dio.dart' as http;

import 'network_error.dart';
import 'response_to_result.dart';
import 'result.dart';

Future<Result<T, NetworkError>> safeCall<T>(
  Future<http.Response> Function() execute,
  T Function(List<Map<String, dynamic>>) fromJson,
) async {
  http.Response response;

  try {
    response = await execute();
  } on SocketException {
    return Failure<T, NetworkError>(NetworkError.noInternet);
  } on FormatException {
    return Failure<T, NetworkError>(NetworkError.serialization);
  } catch (e) {
    return Failure<T, NetworkError>(NetworkError.unknown);
  }

  return responseToResult(response, fromJson);
}
