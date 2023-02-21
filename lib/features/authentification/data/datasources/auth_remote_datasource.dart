
import 'package:auth_bloc/core/error/exceptions.dart';
import 'package:auth_bloc/core/providers/api_helper.dart';
import 'package:auth_bloc/core/utils/app_constants.dart';
import 'package:auth_bloc/features/authentification/data/models/login_payload.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Map> signIn(LoginPayload loginPayload);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl({required this.dio});
  @override
  Future<Map> signIn(LoginPayload loginPayload) async {
    dio.options.connectTimeout = 15000;
    try {
      final response = await APIHelper(dio: dio, apiBaseUrl: AppConstants.base_url).post("/login", body: loginPayload.toJson());
      return response;
    } on DioError catch (error) {
      throw RequestException.fromDioError(error);
    }

  }
  
}