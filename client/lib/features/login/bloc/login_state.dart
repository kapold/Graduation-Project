abstract class LoginState {}

class CommonLoginState extends LoginState {}

class LoginProcessState extends LoginState {}

class SuccessfulLoginState extends LoginState {}

class FailedLoginState extends LoginState {
  final String errorMessage;

  FailedLoginState(this.errorMessage);
}
