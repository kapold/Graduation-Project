abstract class DeliveryAddressesState {}

class CommonAddressesState extends DeliveryAddressesState {}

class AddingAddressState extends DeliveryAddressesState {}

class DeletingAddressState extends DeliveryAddressesState {}

class FetchingAddressesState extends DeliveryAddressesState {}

class SuccessfulAddressesState extends DeliveryAddressesState {}

class FailedAddressesState extends DeliveryAddressesState {
  final String errorMessage;

  FailedAddressesState(this.errorMessage);
}
