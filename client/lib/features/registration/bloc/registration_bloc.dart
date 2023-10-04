import 'package:client/features/registration/bloc/registration_event.dart';
import 'package:client/features/registration/bloc/registration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(CommonRegistrationState()) {
    on<ProcessRegistrationEvent>(_loginHandler);
  }

  Future<void> _loginHandler(ProcessRegistrationEvent event, Emitter<RegistrationState> emit) async {
    try {
      emit(RegistrationProcessState());



      emit(SuccessfulRegistrationState());
    }
    catch (error) {
      emit(FailedRegistrationState(error.toString()));
    }
  }
}