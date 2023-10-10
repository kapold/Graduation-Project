abstract class RegistrationEvent {}

class ProcessRegistrationEvent extends RegistrationEvent {
  final String phoneNumber;
  final String password;
  final String name;

  ProcessRegistrationEvent({
    required this.phoneNumber,
    required this.password,
    required this.name
  });
}
