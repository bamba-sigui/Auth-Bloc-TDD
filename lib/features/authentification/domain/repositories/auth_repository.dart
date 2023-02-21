import 'package:auth_bloc/core/error/failures.dart';
import 'package:auth_bloc/features/authentification/data/models/login_payload.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/auth_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map>> signiIn(LoginPayload loginPayload);
  Future<Either<Failure, AuthModel>> getAuthLocal();
}