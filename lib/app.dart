import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/configs/app_configs.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'router/route_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) {
          return AuthRepositoryImpl();
        }),
        RepositoryProvider<UserRepository>(create: (context) {
          return UserRepositoryImpl();
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (context) {
            final userRepo = RepositoryProvider.of<UserRepository>(context);
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            return AppCubit(
              userRepo: userRepo,
              authRepo: authRepo,
            );
          }),
        ],
        child: GetMaterialApp(
          title: AppConfigs.appName,
          initialRoute: RouteConfig.splash,
          getPages: RouteConfig.getPages,
        ),
      ),
    );
  }
}
