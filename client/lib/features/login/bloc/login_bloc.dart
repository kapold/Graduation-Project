import 'package:client/features/login/bloc/login_event.dart';
import 'package:client/features/login/bloc/login_state.dart';
import 'package:client/repositories/user_repository.dart';
import 'package:client/utils/local_storage.dart';
import 'package:client/utils/logs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(CommonLoginState()) {
    on<ProcessLoginEvent>(_loginHandler);
  }

  Future<void> _loginHandler(ProcessLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginProcessState());

      User user = await UserRepository.login(
        event.phoneNumber,
        event.password
      );
      LocalStorage.saveToken(user.token);

      emit(SuccessfulLoginState());
    }
    catch (error) {
      emit(FailedLoginState(error.toString()));
    }
  }
}