import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_demo/core/constants/app_constants.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();
  static NetworkManager get instance => _instance;

  late Dio dio;

  NetworkManager._internal() {
    dio = Dio(
      BaseOptions(
        followRedirects: false,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        baseUrl: ApplicationConstants.BASE_URL,
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) async {
        if (e.type == DioExceptionType.connectionError) {
          await Future.delayed(const Duration(seconds: 2));
          return handler.resolve(await dio.fetch(e.requestOptions));
        }
        return handler.next(e);
      },
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (e, handler) {
        return handler.next(e);
      },
    ));
  }
}