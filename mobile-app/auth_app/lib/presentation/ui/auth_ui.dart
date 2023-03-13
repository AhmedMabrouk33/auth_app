import 'package:auth_app/utils/colors/color_configuration.dart';
import 'package:auth_app/utils/data/universal_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/auth/auth_cubit.dart';
import '../../logic/setting/appsetting_cubit.dart';

import '../widgets/auth/auth_widget.dart';

class AuthUi {
  final AuthCubit authActions;
  final AppSettingCubit settingAction;

  AuthUi({
    required this.authActions,
    required this.settingAction,
  });

  //////////////////////////////////////////////////////

  // ************** * Local Attribute. ************** /

  // Image picked.
  XFile? _imagePickedFile;

  ///////////////////////////////

  final AuthWidget _authWidgets = AuthWidget();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  //////////////////////////////////////////////////////

  // ************** * Welcome Ui. ************** /
  List<Widget> welcomeUi() {
    return [
      const SizedBox(height: 79),
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _authWidgets.languageCard(
              appLanguage == 'en' ? 'ar' : 'en',
              settingAction.changeLanguageSetting,
            ),
            const SizedBox(width: 53),
          ],
        ),
      ),

      // ? Spacing.
      const SizedBox(height: 42),

      Text(
        appLanguage == 'en' ? 'Welcome to....' : 'مرحبأ بك ....',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          height: 1,
          fontWeight: FontWeight.w700,
          color: HexColor('#DC8E22'),
          // TODO: ADD Font Family.
        ),
      ),

      // -~ Project image
      Image.asset(
        'assets/images/fakeshop-logo.png',
        fit: BoxFit.cover,
      ),

      // ? Spacing.
      const SizedBox(height: 133),

      _authWidgets.loginButton(
        () =>
            authActions.changeScreenStateAction(AuthScreenStateEnum.loginState),
      ),

      // ? Spacing.
      const SizedBox(height: 77),

      _authWidgets.signUpButton(
        () => authActions
            .changeScreenStateAction(AuthScreenStateEnum.signUpState),
      ),
    ];
  }

  //////////////////////////////////////////////////////

  // ************** * Login Ui. ************** /
  List<Widget> loginUi() {
    return [
      const SizedBox(height: 44),

      // -~ Screen Header.
      _authWidgets.screenHeader(
        onPressed: () => authActions.changeScreenStateAction(
          AuthScreenStateEnum.welcomeState,
        ),
        hasHeaderText: false,
      ),

      // -~ Project image
      Image.asset(
        'assets/images/fakeshop-logo.png',
        fit: BoxFit.cover,
      ),

      // ? Spacing.
      const SizedBox(height: 60),

      // -~ Email text field.
      _authWidgets.regularTextField(
        hint: appLanguage == 'en' ? 'email' : 'بريد إلكتروني',
        keyboardType: TextInputType.emailAddress,
        textDirection: TextDirection.ltr,
        controller: _emailController,
      ),

      // ? Spacing.
      const SizedBox(height: 51),

      // -~ Password text field.
      // appLanguage == 'en' ? 'Password' : 'كلمة المرور'
      BlocSelector<AuthCubit, AuthCubitState, bool>(
        selector: (state) => state.passwordObscureState,
        builder: (_, state) {
          return _authWidgets.passwordTextField(
            hint: appLanguage == 'en' ? 'Password' : 'كلمة المرور',
            controller: _passwordController,
            obscureTextState: state,
            onPressed: () => authActions.changePasswordState(
              newPasswordObscureState: !state,
            ),
          );
        },
      ),

      // ? Spacing.
      const SizedBox(height: 218),

      // Login Action.
      _authWidgets.loginButton(
        () => authActions.loginAction(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      ),
    ];
  }

  //////////////////////////////////////////////////////

  // ************** * Sign up Ui. ************** /

  //////////////////////////////////////////////////////

  // ************** * Loading Ui. ************** /
  List<Widget> loadingUi() {
    return [
      // ? Top Padding.
      const SizedBox(height: 110),

      // -~ Loading wiidget.
      Image.asset(
        'assets/images/loading_animation.gif',
        fit: BoxFit.cover,
        height: 200,
        width: 200,
      ),

      // ? Spacing.
      const SizedBox(height: 72),

      // -~ Loading Data text
      Text(
        appLanguage == 'en' ? 'Loading your data' : 'تحميل بياناتك',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 27,
          height: 1,
          fontWeight: FontWeight.w700,
          color: HexColor('#BA9062'),
          // TODO: Add Font family.
        ),
      ),

      // ? Spacing.
      const SizedBox(height: 80),

      // -~ Please wait
      Text(
        appLanguage == 'en' ? 'Please wait' : 'انتظر من فضلك',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          height: 1,
          fontWeight: FontWeight.w700,
          color: HexColor('#000000'),
          // TODO: Add Font family.
        ),
      ),
    ];
  }

  //////////////////////////////////////////////////////

  // ************** * Error Ui. ************** /
  List<Widget> errorUi(String errorMessage) {
    return [
      // ? Top Padding.
      const SizedBox(height: 70),

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
      const SizedBox(height: 50),

      // Image.
      Image.asset(
        'assets/images/error_connection_image.png',
        fit: BoxFit.cover,
      ),

      // -~ Message.
      Text(
        appLanguage == 'en' ? 'SomeThing went wrong' : 'هناك خطأ ما',
        style: TextStyle(
          // height: 1,
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: HexColor('#DC395F'),
          // TODO: Add Family.
        ),
      ),

      // ? Spacing.
      const SizedBox(height: 25),

      // -~ Message.
      // TODO: Check how to read language cubit state to account cubit.
      Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 1.1,
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: HexColor('#000000'),
          // TODO: Add Family.
        ),
      ),

      // ? Spacing.
      const SizedBox(height: 140),

      // Return Action.
      _authWidgets.returnButton(authActions.goToPreviousScreenStateAction),

      // ? Spacing.
      const SizedBox(height: 90),
    ];
  }

  //////////////////////////////////////////////////////
}
