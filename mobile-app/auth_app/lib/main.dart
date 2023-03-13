import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logic/setting/appsetting_cubit.dart';
import 'presentation/router/app_router.dart';

import 'utils/data/universal_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  sharedPreferences = await SharedPreferences.getInstance();

  runApp(AuthApp(appRouter: AppRouter()));
}

class AuthApp extends StatelessWidget {
  final AppRouter appRouter;
  const AuthApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppSettingCubit>(
      create: (context) => AppSettingCubit(),
      child: MaterialApp(
        title: 'Auth App',
        onGenerateRoute: appRouter.appRoutesGenerator,
      ),
    );
  }
}
