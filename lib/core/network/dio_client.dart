import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    // if (kDebugMode) {
    //   // dio.interceptors.add(
    //   //   LogInterceptor(
    //   //     responseBody: true,
    //   //     error: true,
    //   //     requestHeader: true,
    //   //     responseHeader: true,
    //   //     request: true,
    //   //     requestBody: true,
    //   //   ),
    //   //);
    // }
  }
}

const baseUrl = "https://68209735259dad2655ad022e.mockapi.io/dsv_project";
