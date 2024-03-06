import 'dart:async';

import 'package:client/features/settings/bloc/profile_event.dart';
import 'package:client/features/settings/bloc/profile_state.dart';
import 'package:client/repositories/user_repository.dart';
import 'package:client/utils/profile_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/local_storage.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(CommonProfileState()) {
    on<UpdateUserEvent>(_updateUserHandler);
    on<DeleteUserEvent>(_deleteUserHandler);
    on<LogoutEvent>(_logoutHandler);
  }

  Future<void> _updateUserHandler(UpdateUserEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(SavingProfileState());

      UserRepository.updateUserById(event.id, event.name).then((value) => ProfileData.user.name = event.name);

      emit(CommonProfileState());
    }
    catch (error) {
      emit(FailedProfileState(error.toString()));
    }
  }

  Future<void> _deleteUserHandler(DeleteUserEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(DeletingProfileState());

      UserRepository.deleteUserById(event.id).then((value) => LocalStorage.clearToken());

      emit(CommonProfileState());
    }
    catch (error) {
      emit(FailedProfileState(error.toString()));
    }
  }

  Future<void> _logoutHandler(LogoutEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(LogoutProfileState());

      LocalStorage.clearToken();

      emit(CommonProfileState());
    }
    catch (error) {
      emit(FailedProfileState(error.toString()));
    }
  }
}