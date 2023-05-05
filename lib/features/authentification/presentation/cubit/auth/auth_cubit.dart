import 'package:auth_bloc/features/authentification/data/models/auth_model.dart';
import 'package:auth_bloc/features/authentification/data/models/login_payload.dart';
import 'package:auth_bloc/features/authentification/domain/usecases/sign_in.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_auth_local.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.signInUseCase, required this.getAuthLocalUseCase})
      : super(AuthInitial());

  final SignInUseCaseImpl signInUseCase;
  final GetAuthLocalUseCaseImpl getAuthLocalUseCase;

  getAuthLoaded() async {
    emit(GetLocalInProgress());
    try {
      final Either<Failure, AuthModel> getUserLocal = await getAuthLocalUseCase();
      getUserLocal.fold((Failure failure) {
        emit(
          GetLocalFailure(),
        );
      }, (AuthModel result) {
        emit(LoginSuccess(user : result.user));
      });
    } catch (error) {
      if (error is CacheFailure) {
        emit(
          GetLocalFailure(),
        );
      }
      emit(
        GetLocalFailure(),
      );
    }
  }

  login(LoginPayload loginPayload) async {
    emit(LoginInProgress());
    final Either<Failure, Map> loginResult = await signInUseCase(loginPayload);
    loginResult.fold((Failure failure) {
      emit(
        LoginFailure(message: failure.message),
      );
    }, (Map result) {
      UserModel user = UserModel(
          userId: result['user']['user_id'],
          firstName: result['user']['first_name'],
          lastName: result['user']['last_name'],
          phoneNumber: result['user']['phone_number'],
          emailAddress: result['user']['email_address']);
      emit(LoginSuccess(user: user));
    });
  }
}
