import 'package:auth_bloc/core/usecases/usecases.dart';
import 'package:auth_bloc/features/authentification/data/models/auth_model.dart';
import 'package:auth_bloc/features/authentification/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';

abstract class GetAuthLocalUseCase<Type, Params> {
  Future<Either<Failure, Type>> call();
}

class GetAuthLocalUseCaseImpl extends GetAuthLocalUseCase {
  late final AuthRepository authRepository;
  GetAuthLocalUseCaseImpl(this.authRepository);

  @override
  Future<Either<Failure, AuthModel>> call() async {
    return await authRepository.getAuthLocal();
  }
}
