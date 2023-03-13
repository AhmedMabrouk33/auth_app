import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens_name.dart';

import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';

import '../../logic/auth/auth_cubit.dart';
import '../../logic/connection/network_connection_cubit.dart';

class AppRouter {
  Route? appRoutesGenerator(RouteSettings setting) {
    switch (setting.name) {
      case AUTH_SCREEN:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => NetworkConnectionCubit()),
              BlocProvider(create: (context) => AuthCubit()),
            ],
            child: const AuthScreen(),
          ),
        );

      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
        return null;
    }
  }
}
