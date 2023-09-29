import 'package:client/features/login/bloc/login_event.dart';
import 'package:client/features/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginProcessState()) {
    on<ProcessLoginEvent>(_loginHandler);
  }

  Future<void> _loginHandler(ProcessLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginProcessState());



      emit(SuccessfulLogin());
    }
    catch (error) {
      emit(FailedLogin(error.toString()));
    }
  }
}