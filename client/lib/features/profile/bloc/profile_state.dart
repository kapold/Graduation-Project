abstract class ProfileState {}

class CommonProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class SavingProfileState extends ProfileState {}

class DeletingProfileState extends ProfileState {}

class LogoutProfileState extends ProfileState {}

class FailedProfileState extends ProfileState {
  final String errorMessage;

  FailedProfileState(this.errorMessage);
}
