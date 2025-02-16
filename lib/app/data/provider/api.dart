import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mesa/app/data/provider/api_interface.dart';

class MESAInterceptor extends Interceptor {
  //onRequest
  //onError
}

class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH: ${options.path}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return handler.next(err);
  }
}

class MESAApiProvider implements MESAApiInterface {
  final Dio dio = Dio();
  final baseUrl = "https://api.findflag.kr/newsletter";

  MESAApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(MESAInterceptor());
    dio.interceptors.add(LogInterceptor());
  }

  @override
  Future<Map> login(String id, String password) async {
    String url = "/admin/login";

    Map<String, dynamic> data = {
      "userID": id,
      "userPW": password,
    };
    final response = await dio.post(url, data: data);

    log(response.data.toString());

    return response.data;
  }

  @override
  Future<Map> writeArticle(String id, String password, String subject, String title, String texts, String link, String imgdata) async {
    String url = "/admin/write/save/json";

    Map data = {
      "id": id,
      "password": password,
      "subject": subject,
      "title": title,
      "texts": texts,
      "link": link,
      "imgdata": imgdata,
    };

    final response = await dio.post(url, data: data);
    return response.data;
  }

  @override
  Future<Map> getSubjects() async {
    String url = "/admin/write/subject/json";

    final response = await dio.get(url);
    return response.data;
  }
}
