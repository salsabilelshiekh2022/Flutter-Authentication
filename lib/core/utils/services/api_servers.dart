import 'package:dio/dio.dart';

class ApiServer {
  final Dio dio;

  ApiServer(this.dio);

  static init() {
    Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json', 'lang': 'en'},
      ),
    );
  }

  Future<Response> getData(
      {required String url,
      required Map<String, dynamic> query,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {'lang': lang, 'Authorization': token};
    return await dio.get(url, queryParameters: query);
  }

  Future<Response> postData(
      {required Map<String, dynamic> data,
      required String url,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {'lang': lang, 'Authorization': token};
    return await dio.post(
      url,
      data: data,
    );
  }
}
