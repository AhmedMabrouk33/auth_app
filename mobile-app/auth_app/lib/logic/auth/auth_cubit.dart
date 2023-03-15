import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/clientmodel.dart';
import '../../data/repositories/auth_repository.dart';
import '../../utils/data/universal_data.dart';

part 'auth_state.dart';

enum AuthScreenStateEnum {
  welcomeState,
  loginState,
  signUpState,
  loadingState,
  errorState,
  completeState,
}

class AuthCubit extends Cubit<AuthCubitState> {
  AuthScreenStateEnum _previousScreenState = AuthScreenStateEnum.welcomeState;
  final AuthRepository _repository = AuthRepository();

  AuthCubit()
      : super(
          AuthCubitState(
            currentAuthScreenState: AuthScreenStateEnum.loadingState,
          ),
        ) {
    _readUserCached();
  }

  ///////////////////////////////////////////////////////////////////////////////

  // ************* * Global Actions. *********** /

  void goToPreviousScreenStateAction() {
    emit(AuthCubitState(currentAuthScreenState: _previousScreenState));
  }

  void changeScreenStateAction(AuthScreenStateEnum newScreenState) {
    _previousScreenState = newScreenState;
    print(state.currentAuthScreenState);
    emit(AuthCubitState(currentAuthScreenState: newScreenState));
    print(state.currentAuthScreenState);
  }

  void changePasswordState({
    bool newPasswordObscureState = false,
    bool newConfirmPasswordObscureState = false,
  }) {
    emit(
      AuthCubitState(
        currentAuthScreenState: state.currentAuthScreenState,
        passwordObscureState: newPasswordObscureState,
        confirmPasswordObscureState: newConfirmPasswordObscureState,
      ),
    );
  }

  void loginAction({required String email, required String password}) async {
    print('Email is $email\nPassword is $password');
    if (_verifyLoginData(email: email, password: password)) {
      emit(
        AuthCubitState(
          currentAuthScreenState: AuthScreenStateEnum.loadingState,
        ),
      );

      Either<String, ClientModel> repositorySide =
          await _repository.loginRepository(
        email: email.toLowerCase(),
        password: password,
      );

      repositorySide.fold(
        (leftSideMessage) => emit(
          AuthCubitState(
            currentAuthScreenState: AuthScreenStateEnum.errorState,
            errorMessage: leftSideMessage,
          ),
        ),
        (right) async {
          clientData = right;

          await _repository.saveCached(clientData.user);

          emit(
            AuthCubitState(
              currentAuthScreenState: AuthScreenStateEnum.completeState,
            ),
          );
        },
      );
    } else {
      emit(
        AuthCubitState(
          currentAuthScreenState: AuthScreenStateEnum.errorState,
          errorMessage: appLanguage == 'en'
              ? 'There is an error in your input data\nPlease check your data'
              : 'يوجد خطأ في بيانات الإدخال الخاصة بك \n الرجاء التحقق من البيانات الخاصة بك',
        ),
      );
    }
  }

  void signUpAction({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required String dateOfBirth,
    required String phoneNumber,
    required XFile? imagePicked,
  }) {}

  ///////////////////////////////////////////////////////////////////////////////

  // ************* * Private method. *********** /

  void _readUserCached() async {
    UserModel? tempUser = await _repository.readCached();

    if (tempUser != null && tempUser.isAutoLogin) {
      loginAction(email: tempUser.email, password: tempUser.password);
    } else {
      emit(AuthCubitState(
          currentAuthScreenState: AuthScreenStateEnum.welcomeState));
    }
  }

  bool _verifyLoginData({required String email, required String password}) {
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _verifySignUpData({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required String dateOfBirth,
    required String phoneNumber,
    required XFile? imagePicked,
  }) {
    return false;
  }

  ///////////////////////////////////////////////////////////////////////////////
}
