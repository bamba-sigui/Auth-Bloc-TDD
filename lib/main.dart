import 'package:auth_bloc/features/authentification/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart' as nav;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:auth_bloc/injection_container.dart' as injection_container;

import 'core/providers/routes_provider.dart';
import 'core/utils/app_constants.dart';
import 'injection_container.dart';

void main() async {
  await injection_container.init();
  // Initialize hive
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.app_local_db);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthCubit>()..getAuthLoaded()),
        ],
        child: GetMaterialApp(
          navigatorKey: Get.key,
          enableLog: true,
          defaultTransition: nav.Transition.cupertino,
          title: "Authentication",
          initialRoute: RoutesProvider.splashScreen,
          getPages: RoutesProvider.routes,
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          navigatorObservers: const [],
        ));
  }
}
