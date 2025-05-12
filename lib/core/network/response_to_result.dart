import 'package:dio/dio.dart' as http;

import 'network_error.dart';
import 'result.dart';

Future<Result<T, NetworkError>> responseToResult<T>(
  http.Response response,
  T Function(List<Map<String, dynamic>>) fromJson,
) async {
  try {
    final statusCode = response.statusCode;

    if (statusCode! >= 200 && statusCode! < 300) {
      try {
        var processeddata = processResponse(response.data);
        final data = fromJson(processeddata);
        return Success<T, NetworkError>(data);
      } catch (e) {
        return Failure<T, NetworkError>(NetworkError.serialization);
      }
    }

    switch (statusCode) {
      case 408:
        return Failure<T, NetworkError>(NetworkError.requestTimeout);
      case 429:
        return Failure<T, NetworkError>(NetworkError.tooManyRequests);
      case >= 500 && < 600:
        return Failure<T, NetworkError>(NetworkError.serverError);
      default:
        return Failure<T, NetworkError>(NetworkError.unknown);
    }
  } catch (e) {
    return Failure<T, NetworkError>(NetworkError.unknown);
  }
}

List<Map<String, dynamic>> processResponse(dynamic response) {
  List<Map<String, dynamic>> userList;

  if (response is Map<String, dynamic>) {
    return userList = [response];
  } else if (response is List<dynamic>) {
    return userList =
        response
            .where((item) => item is Map<String, dynamic>)
            .map((item) => item as Map<String, dynamic>)
            .toList();
  } else {
    return [];
  }
}
