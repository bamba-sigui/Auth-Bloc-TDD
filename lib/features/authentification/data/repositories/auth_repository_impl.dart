import 'package:auth_bloc/core/error/failures.dart';
import 'package:auth_bloc/core/platform/network/network_info.dart';
import 'package:auth_bloc/core/usecases/usecases.dart';
import 'package:auth_bloc/features/authentification/data/datasources/auth_local_datasource.dart';
import 'package:auth_bloc/features/authentification/data/datasources/auth_remote_datasource.dart';
import 'package:auth_bloc/features/authentification/data/models/auth_model.dart';
import 'package:auth_bloc/features/authentification/data/models/login_payload.dart';
import 'package:auth_bloc/features/authentification/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_constants.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Map>> signiIn(LoginPayload loginPayload) async {
    if (await networkInfo.isConnected) {
      try {
        final authResponse = await remoteDataSource.signIn(loginPayload);
        TokenModel token = TokenModel(
            type: authResponse['token']['type'],
            token: authResponse['token']['token'],);
        UserModel user = UserModel(
            userId: authResponse['user']['user_id'],
            firstName: authResponse['user']['first_name'],
            lastName: authResponse['user']['last_name'],
            phoneNumber: authResponse['user']['phone_number'],
            emailAddress: authResponse['user']['email_address']);
        localDataSource.cacheToken(token);
        localDataSource.cacheUser(user);
        return Right(authResponse);
      } on RequestException catch (error) {
        return Left(ServerFailure(
          statusCode: error.statusCode!,
          message: error.message,
          response: error.response,
        ));
      }
    } else {
      return const Left(
        ServerFailure(
          statusCode: -1,
          message: AppConstants.networkError,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> getAuthLocal() async {
   try {
     final userFromLocal = await localDataSource.getUserFromLocal();
     final tokenFromLocal = await localDataSource.getTokenFromLocal();
     final AuthModel authModel = AuthModel(token: tokenFromLocal, user: userFromLocal);
     // final Map<String, dynamic> test = {"hell": "jjjj"};
     return Right(authModel);
   } on CacheException {
    throw const  Left(CacheFailure(message: "No data cached..."));
   }
   catch (error) {
     if (error is CacheFailure) {
       throw const  Left(CacheFailure(message: "No data cached..."));
     }
     throw const  Left(CacheFailure(message: "No data cached..."));
   }
  }
}
