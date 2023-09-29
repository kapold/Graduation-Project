abstract class LoginState {}

class LoginProcessState extends LoginState {}

class SuccessfulLogin extends LoginState {}

class FailedLogin extends LoginState {
  final String errorMessage;

  FailedLogin(this.errorMessage);
}
