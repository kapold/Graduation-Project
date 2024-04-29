import '../../../models/user.dart';

abstract class AuthState {}

class CommonState extends AuthState {}

class FailedState extends AuthState {
  final String errorMessage;

  FailedState(this.errorMessage);
}

class ProcessAuthState extends AuthState {}

class SuccessfulAuthState extends AuthState {
  final User user;

  SuccessfulAuthState(this.user);
}
