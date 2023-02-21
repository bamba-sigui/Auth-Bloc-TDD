import 'package:auth_bloc/core/platform/network/network_info.dart';
import 'package:auth_bloc/core/providers/hive_helper.dart';
import 'package:auth_bloc/features/authentification/data/datasources/auth_local_datasource.dart';
import 'package:auth_bloc/features/authentification/data/datasources/auth_remote_datasource.dart';
import 'package:auth_bloc/features/authentification/data/repositories/auth_repository_impl.dart';
import 'package:auth_bloc/features/authentification/domain/repositories/auth_repository.dart';
import 'package:auth_bloc/features/authentification/domain/usecases/get_auth_local.dart';
import 'package:auth_bloc/features/authentification/domain/usecases/sign_in.dart';
import 'package:auth_bloc/features/authentification/presentation/cubit/auth/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // App Features
  //BLOC

  // Business Features
  // CUBIT
  sl.registerFactory(() => AuthCubit(signInUseCase: sl(), getAuthLocalUseCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => SignInUseCaseImpl(sl()));
  sl.registerLazySingleton(() => GetAuthLocalUseCaseImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Datasource
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(hive: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Providers
  sl.registerLazySingleton(() => HiveHelper(hive: sl()));

  // External
  final Dio dio = Dio();
  final HiveInterface hive = Hive;
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => hive);
}
