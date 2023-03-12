part of 'auth_cubit.dart';

class AuthCubitState extends Equatable {
  final AuthScreenStateEnum currentAuthScreenState;
  bool passwordObscureState;
  bool confirmPasswordObscureState;
  String errorMessage;

  AuthCubitState({
    required this.currentAuthScreenState,
    this.passwordObscureState = false,
    this.confirmPasswordObscureState = false,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [
        currentAuthScreenState,
        passwordObscureState,
        confirmPasswordObscureState,
        errorMessage
      ];
}
