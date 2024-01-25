import 'package:client/features/delivery_addresses/bloc/delivery_addresses_event.dart';
import 'package:client/features/delivery_addresses/bloc/delivery_addresses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressesBloc extends Bloc<DeliveryAddressesEvent, DeliveryAddressesState> {
  DeliveryAddressesBloc() : super(CommonAddressesState()) {
    on<GetAddressesEvent>(_getAddressesHandler);
    on<AddAddressEvent>(_addAddresseHandler);
    on<DeleteAddressEvent>(_deleteAddressesHandler);
  }

  Future<void> _getAddressesHandler(GetAddressesEvent event, Emitter<DeliveryAddressesState> emit) async {
    try {
      emit(FetchingAddressesState());



      emit(SuccessfulAddressesState());
    }
    catch (error) {
      emit(FailedAddressesState(error.toString()));
    }
  }

  Future<void> _addAddresseHandler(AddAddressEvent event, Emitter<DeliveryAddressesState> emit) async {
    try {
      emit(AddingAddressState());



      emit(SuccessfulAddressesState());
    }
    catch (error) {
      emit(FailedAddressesState(error.toString()));
    }
  }

  Future<void> _deleteAddressesHandler(DeleteAddressEvent event, Emitter<DeliveryAddressesState> emit) async {
    try {
      emit(DeletingAddressState());



      emit(SuccessfulAddressesState());
    }
    catch (error) {
      emit(FailedAddressesState(error.toString()));
    }
  }
}