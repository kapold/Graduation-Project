abstract class RegistrationState {}

class CommonRegistrationState extends RegistrationState {}

class RegistrationProcessState extends RegistrationState {}

class SuccessfulRegistrationState extends RegistrationState {}

class FailedRegistrationState extends RegistrationState {
  final String errorMessage;

  FailedRegistrationState(this.errorMessage);
}
