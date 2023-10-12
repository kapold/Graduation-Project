import 'package:client/features/registration/bloc/registration_event.dart';
import 'package:client/features/registration/bloc/registration_state.dart';
import 'package:client/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../utils/local_storage.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(CommonRegistrationState()) {
    on<ProcessRegistrationEvent>(_registrationHandler);
  }

  Future<void> _registrationHandler(ProcessRegistrationEvent event, Emitter<RegistrationState> emit) async {
    try {
      emit(RegistrationProcessState());

      User user = await UserRepository.register(
          event.phoneNumber,
          event.password,
          event.name,
          event.isAdmin,
          event.isStaff
      );
      LocalStorage.saveToken(user.token);

      emit(SuccessfulRegistrationState());
    }
    catch (error) {
      emit(FailedRegistrationState(error.toString()));
    }
  }
}