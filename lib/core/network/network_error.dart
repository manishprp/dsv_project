import 'package:dsv_project/core/network/error.dart';

enum NetworkError implements AppError {
  requestTimeout,
  tooManyRequests,
  noInternet,
  serverError,
  serialization,
  unknown,
}
