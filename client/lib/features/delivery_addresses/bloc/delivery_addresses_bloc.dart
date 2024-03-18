import 'package:client/features/delivery_addresses/bloc/delivery_addresses_event.dart';
import 'package:client/features/delivery_addresses/bloc/delivery_addresses_state.dart';
import 'package:client/models/delivery_address.dart';
import 'package:client/repositories/address_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressesBloc extends Bloc<DeliveryAddressesEvent, DeliveryAddressesState> {
  DeliveryAddressesBloc() : super(LoadingAddressesState()) {
    on<GetAddressesEvent>(_getAddressesHandler);
    on<AddAddressEvent>(_addAddresseHandler);
    on<DeleteAddressEvent>(_deleteAddressesHandler);
  }

  Future<void> _getAddressesHandler(GetAddressesEvent event, Emitter<DeliveryAddressesState> emit) async {
    try {
      emit(LoadingAddressesState());

      List<DeliveryAddress> userAddresses = await AddressRepository.getUserAddresses(event.userId);

      emit(SuccessfulLoadedAddressesState(userAddresses));
    }
    catch (error) {
      emit(FailedAddressesState(error.toString()));
    }
  }

  Future<void> _addAddresseHandler(AddAddressEvent event, Emitter<DeliveryAddressesState> emit) async {
    try {
      emit(LoadingAddressesState());

      AddressRepository.addUserAddress(event.userId, event.address);

      emit(SuccessfulAddedAddressesState());
    }
    catch (error) {
      emit(FailedAddressesState(error.toString()));
    }
  }

  Future<void> _deleteAddressesHandler(DeleteAddressEvent event, Emitter<DeliveryAddressesState> emit) async {
    try {
      emit(LoadingAddressesState());

      AddressRepository.deleteUserAddress(event.addressId);

      emit(SuccessfulDeletedAddressesState());
    }
    catch (error) {
      emit(FailedAddressesState(error.toString()));
    }
  }
}