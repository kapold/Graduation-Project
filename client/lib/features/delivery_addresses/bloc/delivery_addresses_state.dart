import '../../../models/delivery_address.dart';

abstract class DeliveryAddressesState {}

class LoadingAddressesState extends DeliveryAddressesState {}

class SuccessfulAddedAddressesState extends DeliveryAddressesState {}

class SuccessfulDeletedAddressesState extends DeliveryAddressesState {}

class SuccessfulLoadedAddressesState extends DeliveryAddressesState {
  final List<DeliveryAddress> deliveryAddresses;

  SuccessfulLoadedAddressesState(this.deliveryAddresses);
}

class FailedAddressesState extends DeliveryAddressesState {
  final String errorMessage;

  FailedAddressesState(this.errorMessage);
}
