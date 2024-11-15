import 'package:dio/dio.dart';
import 'package:moji_backoffice/app/data/provider/api_interface.dart';

class MAMSInterceptor extends Interceptor {
  final Dio _dioInstance;
  MAMSInterceptor(this._dioInstance);

  //onRequest
  //onError
}

class MAMSApiProvider implements MAMSApiInterface {
  final Dio dio = Dio();
  final baseUrl = "https:...";

  MAMSApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(MAMSInterceptor(dio));
  }

  @override
  Future<void> getInfo() async {
    String url = "/test";
    dio.post(url);
  }
}
