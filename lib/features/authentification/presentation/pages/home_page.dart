import 'package:auth_bloc/features/authentification/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page')
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (authContext, state) {
              if (state is LoginSuccess) {
                print(state);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text('Nom : ${state.user.firstName} '),
                     Text('Prenom : ${state.user.lastName} '),
                     Text('email : ${state.user.emailAddress} '),
                     Text('Telephone : ${state.user.phoneNumber} '),
                  ]
                );
              } else {
                return const Text('il n y a rien a voir');
              }
            },
          ),
        ),
      ),
    );
  }
}
