import 'package:auth_app/utils/colors/color_configuration.dart';
import 'package:auth_app/utils/data/universal_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/auth/auth_cubit.dart';
import '../../logic/setting/appsetting_cubit.dart';

import '../widgets/auth/auth_widget.dart';

class AuthUi {
  final AuthCubit authAction;
  final AppSettingCubit settingAction;

  AuthUi({
    required this.authAction,
    required this.settingAction,
  });

  //////////////////////////////////////////////////////

  // ************** * Local Attribute. ************** /

  // Image picked.
  XFile? _imagePickedFile;

  ///////////////////////////////

  final AuthWidget _authWidget = AuthWidget();

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
            _authWidget.languageCard(
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

      _authWidget.loginButton(
        () =>
            authAction.changeScreenStateAction(AuthScreenStateEnum.loginState),
      ),

      // ? Spacing.
      const SizedBox(height: 77),

      _authWidget.signUpButton(
        () =>
            authAction.changeScreenStateAction(AuthScreenStateEnum.signUpState),
      ),
    ];
  }

  //////////////////////////////////////////////////////

  // ************** * Login Ui. ************** /

  //////////////////////////////////////////////////////

  // ************** * Sign up Ui. ************** /

  //////////////////////////////////////////////////////

  // ************** * Loading Ui. ************** /

  //////////////////////////////////////////////////////

  // ************** * Error Ui. ************** /

  //////////////////////////////////////////////////////

  // ************** * Welcome Ui. ************** /
}
