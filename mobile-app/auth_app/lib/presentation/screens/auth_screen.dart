import 'package:auth_app/logic/auth/auth_cubit.dart';
import 'package:auth_app/logic/setting/appsetting_cubit.dart';
import 'package:auth_app/presentation/ui/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              : _noInternetConnectionWidget(),
        ),
      ),
    );
  }

  Widget _noInternetConnectionWidget() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            appLanguage == 'en' ? 'Oups!' : 'للاسف',
            style: TextStyle(
              height: 1,
              fontSize: 35,
              fontWeight: FontWeight.w700,
              color: HexColor('#DC395F'),
              // TODO: Add Family.
            ),
          ),

          // ? Spacing.
          // const SizedBox(height: 50),

          // Image.
          Image.asset(
            'assets/images/error_connection_image.png',
            fit: BoxFit.cover,
          ),

          // -~ Message.
          Text(
            appLanguage == 'en' ? 'SomeThing went wrong' : 'هناك خطأ ما',
            style: TextStyle(
              height: 1,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: HexColor('#FDFDFD'),
              // TODO: Add Family.
            ),
          ),

          // ? Spacing.
          // const SizedBox(height: 10),

          // -~ Message.
          Text(
            appLanguage == 'en'
                ? 'Please check \nyour internet connection'
                : 'يرجى المراجعة\nاتصالك بالإنترنت',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: HexColor('#DC395F'),
              // TODO: Add Family.
            ),
          ),
        ],
      ),
    );
  }

  Widget _authScreens() {
    return BlocSelector<AppSettingCubit, AppSettingState, String>(
      selector: (state) {
        print('State is $state');
        return state.languageSetting;
      },
      builder: (context, languageState) => Directionality(
        textDirection:
            languageState == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<AuthCubit, AuthCubitState>(
          buildWhen: (previous, current) {
            // BUG Delete this print method.
            print(
              'Previous screenState name is ${previous.currentAuthScreenState}, \nCurrent Screen State name is ${current.currentAuthScreenState}',
            );

            return previous.currentAuthScreenState !=
                current.currentAuthScreenState;
          },
          builder: (context, state) {
            // TODO: Check that State is complete state Navigate to address screen.
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
                      ..._authUi.loadingUi()

                    // **** * Error UI ******* /
                    else if (state.currentAuthScreenState ==
                        AuthScreenStateEnum.errorState)
                      ..._authUi.errorUi(state.errorMessage)

                    // **** * Other ******* /
                    else ...[
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
}
