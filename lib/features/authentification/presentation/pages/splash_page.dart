import 'package:auth_bloc/features/authentification/presentation/cubit/auth/auth_cubit.dart';
import 'package:auth_bloc/features/authentification/presentation/pages/home_page.dart';
import 'package:auth_bloc/features/authentification/presentation/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocListener<AuthCubit, AuthState>(
        listener: (authContext, state) {
          if (state is LoginSuccess) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            });
          } else if (state is GetLocalFailure) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            });
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      )),
    );
  }
}
