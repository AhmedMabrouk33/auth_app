import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repositories/auth_repository.dart';

part 'auth_state.dart';

enum AuthScreenStateEnum {
  welcomeState,
  loginState,
  signUpState,
  loadingState,
  errorState,
  succeedState,
}

class AuthCubit extends Cubit<AuthCubitState> {
  AuthScreenStateEnum _previousScreenState = AuthScreenStateEnum.welcomeState;
  AuthRepository _repository = AuthRepository();

  AuthCubit()
      : super(
          AuthCubitState(
            currentAuthScreenState: AuthScreenStateEnum.welcomeState,
          ),
        );

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

  void loginAction({required String email, required String password}) {}

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
  
  

  ///////////////////////////////////////////////////////////////////////////////
}
