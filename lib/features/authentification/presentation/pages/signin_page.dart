import 'package:auth_bloc/features/authentification/data/models/login_payload.dart';
import 'package:auth_bloc/features/authentification/presentation/cubit/auth/auth_cubit.dart';
import 'package:auth_bloc/features/authentification/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showPassword = false;
  final emailController = TextEditingController(text: "test@example.com");
  final passwordController = TextEditingController(text: "123456");

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: SafeArea(
            minimum: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                  controller: emailController,
                                  validator: (val) =>
                                      val!.isEmpty ? 'Entrez un email' : null,
                                  textInputAction: TextInputAction.next,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                    hintText: 'Entrez votre email svp?',
                                    labelText: 'Email *',
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  controller: passwordController,
                                  obscureText: _showPassword,
                                  validator: (val) => val!.isEmpty
                                      ? 'Entrez un password'
                                      : null,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: const Icon(Icons.password),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        },
                                        icon: _showPassword
                                            ? const Icon(Icons.lock_open)
                                            : const Icon(Icons.lock)),
                                    hintText: 'Entrez votre mot de passe svp?',
                                    labelText: 'Mot de passe *',
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              BlocConsumer<AuthCubit, AuthState>(
                                listener: (authContext, state) {
                                  if (state is LoginSuccess) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  }
                                },
                                builder: (authContext, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(160, 20),
                                      backgroundColor: lightBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(width: 1)),
                                    ),
                                    child: state is LoginInProgress
                                        ? const Center(
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                  color: darkBlue),
                                            ),
                                          )
                                        : const Text("Se connecter",
                                            style: TextStyle(
                                                color: darkBlue,
                                                fontSize: 20,
                                                fontFamily: 'ceraMedium')),
                                    onPressed: () {
                                      authContext.read<AuthCubit>().login(
                                          LoginPayload(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text));
                                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(title: "Note List")));
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                ))));
  }
}
