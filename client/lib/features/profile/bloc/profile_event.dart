abstract class ProfileEvent {}

class GetUserEvent extends ProfileEvent {
  final int id;

  GetUserEvent({
    required this.id,
  });
}

class UpdateUserEvent extends ProfileEvent {
  final int id;
  final String name;

  UpdateUserEvent({
    required this.id,
    required this.name,
  });
}

class DeleteUserEvent extends ProfileEvent {
  final int id;

  DeleteUserEvent({
    required this.id,
  });
}

class LogoutEvent extends ProfileEvent {}
