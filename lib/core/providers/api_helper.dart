import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import '../utils/app_constants.dart';

class APIHelper {
  final Dio dio;
  final String apiBaseUrl;
  const APIHelper({required this.dio, required this.apiBaseUrl});

  //for api helper testing only
  APIHelper.test({required this.dio, required this.apiBaseUrl});

  Future<dynamic> get(String url) async {
    try {
      dio.options.baseUrl = apiBaseUrl;
      final response = await dio.get(url);
      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw RequestException.fromJson(e.response?.data);
      } else {
        throw const RequestException(statusCode: -1, message: AppConstants.networkError);
      }
    }
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? headers, required body, encoding, onSendProgress}) async {
    try {
      dio.options.baseUrl = apiBaseUrl;
      final response = await dio.post(url, data: body, options: Options(headers: headers));
      // final String res = json.encode(response.data);

      return response.data;
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw RequestException.fromJson(e.response?.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> put(String url, {Map<String, dynamic>? headers, required body, encoding, onSendProgress}) async {
    try {
      dio.options.baseUrl = apiBaseUrl;
      final response = await dio.put(url, data: body, options: Options(headers: headers));
      // final String res = json.encode(response.data);

      return response.data;
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw RequestException.fromJson(e.response?.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Response> upload(String url, {Map<String, dynamic>? headers, required body, encoding, onSendProgress}) async {
    try {
      dio.options.baseUrl = apiBaseUrl;
      final response = await dio.post(url, data: body, options: Options(headers: headers), onSendProgress: (int sent, int total) {
        print("$sent $total");
      });
      return response;
    } on DioError catch (e) {
      print('[API Helper - UPLOAD] Connection Exception => ${e.message}');
      throw RequestException.fromJson({"statusCode": e.response?.statusCode, "message": e.response?.statusMessage});
    }
  }
}
