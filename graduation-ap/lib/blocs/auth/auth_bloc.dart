import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../repositories/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(CommonState()) {
    on<AuthUserEvent>(_authUser);
  }

  Future<void> _authUser(AuthUserEvent event, Emitter<AuthState> emit) async {
    try {
      emit(ProcessAuthState());

      User user = await UserRepository.auth(
        event.accessKey,
      );

      emit(SuccessfulAuthState(user));
    }
    catch (error) {
      emit(FailedState(error.toString()));
    }
  }
}