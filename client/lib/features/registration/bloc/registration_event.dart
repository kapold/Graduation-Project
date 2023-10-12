abstract class RegistrationEvent {}

class ProcessRegistrationEvent extends RegistrationEvent {
  final String phoneNumber;
  final String password;
  final String name;
  final bool isAdmin;
  final bool isStaff;

  ProcessRegistrationEvent({
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.isAdmin,
    required this.isStaff
  });
}
