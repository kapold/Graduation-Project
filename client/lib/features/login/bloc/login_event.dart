abstract class LoginEvent {}

class ProcessLoginEvent extends LoginEvent {
  final String phoneNumber;
  final String password;

  ProcessLoginEvent({
    required this.phoneNumber,
    required this.password
  });
}
