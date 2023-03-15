import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/auth_ui.dart';
import '../ui/global/global_ui.dart';
import '../router/screens_name.dart';

import '../../logic/auth/auth_cubit.dart';
import '../../logic/setting/appsetting_cubit.dart';
import '../../logic/connection/network_connection_cubit.dart';

import '../../utils/colors/color_configuration.dart';
import '../../utils/data/universal_data.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthUi _authUi;
  @override
  void initState() {
    super.initState();
    _authUi = AuthUi(
      authActions: context.read<AuthCubit>(),
      settingAction: context.read<AppSettingCubit>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<NetworkConnectionCubit, NetworkConnectionState>(
          builder: (context, state) => state is InternetConnectedState
              ? _authScreens()
              : noInternetConnectionUi(),
        ),
      ),
    );
  }

  Widget _authScreens() {
    return BlocSelector<AppSettingCubit, AppSettingState, String>(
      selector: (state) => state.languageSetting,
      builder: (context, languageState) => Directionality(
        textDirection:
            languageState == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<AuthCubit, AuthCubitState>(
          buildWhen: (previous, current) =>
              previous.currentAuthScreenState != current.currentAuthScreenState,
          builder: (context, state) {
            return WillPopScope(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.ltr,
                  children: [
                    // **** * Welcome UI ******* /
                    if (state.currentAuthScreenState ==
                        AuthScreenStateEnum.welcomeState)
                      ..._authUi.welcomeUi().toList()

                    // **** * Login UI ******* /
                    else if (state.currentAuthScreenState ==
                        AuthScreenStateEnum.loginState)
                      ..._authUi.loginUi()

                    // **** * Sign up UI ******* /
                    else if (state.currentAuthScreenState ==
                        AuthScreenStateEnum.signUpState) ...[
                      Center(
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<AuthCubit>()
                              .changeScreenStateAction(
                                  AuthScreenStateEnum.errorState),
                          child: Text('Press me2'),
                        ),
                      )
                    ]

                    // **** * Loading UI ******* /
                    else if (state.currentAuthScreenState ==
                        AuthScreenStateEnum.loadingState)
                      ...loadingUi(null)

                    // **** * Error UI ******* /
                    else if (state.currentAuthScreenState ==
                        AuthScreenStateEnum.errorState)
                      ...errorUi(
                        errorMessage: state.errorMessage,
                        onPressed: context
                            .read<AuthCubit>()
                            .goToPreviousScreenStateAction,
                      )
                    // ..._authUi.errorUi(state.errorMessage)

                    // **** * Other ******* /
                    else
                      ...loadingUi(
                        () => Future.delayed(
                          const Duration(milliseconds: 20),
                          _navigateToNextScreen,
                        ),
                      ),
                  ],
                ),
              ),
              onWillPop: () async {
                switch (state.currentAuthScreenState) {
                  case AuthScreenStateEnum.loginState:
                  case AuthScreenStateEnum.signUpState:
                    context.read<AuthCubit>().changeScreenStateAction(
                          AuthScreenStateEnum.welcomeState,
                        );
                    break;

                  case AuthScreenStateEnum.errorState:
                    context.read<AuthCubit>().goToPreviousScreenStateAction();
                    break;
                  default:
                }

                return false;
              },
            );
          },
        ),
      ),
    );
  }

  void _navigateToNextScreen() {
    Navigator.of(context).popAndPushNamed(
      clientData.clientLocation.isNotEmpty ? HOME_SCREEN : ADDRESS_SCREEN,
    );
  }
}
