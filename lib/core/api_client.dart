

import 'package:dio/dio.dart';

abstract class ApiClient{
  final Dio _dio = Dio();

  ApiClient(){
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.baseUrl = 'http://10.0.2.2:8000/api/';
    // Set default headers for authentication
    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (RequestOptions options, handler) {
    //     String username = 'baren';
    //     String password = 'bk2023';
    //     String basicAuth =
    //         'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //     options.headers['Authorization'] = basicAuth;
    //     return handler.next(options);
    //   },
    // ));
  }

  Dio get dio => _dio;
}