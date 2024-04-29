abstract class AuthEvent {}

class AuthUserEvent extends AuthEvent {
  final String accessKey;

  AuthUserEvent(this.accessKey);
}