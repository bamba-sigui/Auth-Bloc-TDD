import 'package:auth_bloc/features/authentification/data/models/login_payload.dart';
import 'package:auth_bloc/features/authentification/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';

abstract class SignInUseCase<Type, Params> {
  Future<Either<Failure, Type>> call();
}

class SignInUseCaseImpl extends UseCase<Map, LoginPayload> {
  late final AuthRepository authRepository;
  SignInUseCaseImpl(this.authRepository);

  @override
  Future<Either<Failure, Map>> call(LoginPayload params) async {
    return await authRepository.signiIn(params);
  }
}
