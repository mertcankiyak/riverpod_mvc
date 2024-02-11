import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/app_constants.dart';

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

        //Network isteklerinde oluşabilecek hataları manager kısmında ele alınıp,
        //istenilen aksiyonlar burada gerçekleştirilecek
        if (e.response?.statusCode == 401) {
          //Kullanıcını yetkisiz işlem yaptığı için muhtemel olarak token'ı öldü.
          //Varsa refresh token servisi kullanılmalı, yoksa login sayfasına yönlendirilmeli.
          log("Status code: 401");
          handler.next(e);
        }

        //Status code kontrolleri detaylandırılıp, ilgili durumlara göre yapılacak işlemler özelleştirilebilir.

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
