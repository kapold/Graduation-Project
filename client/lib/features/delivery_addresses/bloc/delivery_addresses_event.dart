import 'package:client/models/delivery_address.dart';

abstract class DeliveryAddressesEvent {}

class GetAddressesEvent extends DeliveryAddressesEvent {
  final int userId;

  GetAddressesEvent({
    required this.userId,
  });
}

class AddAddressEvent extends DeliveryAddressesEvent {
  final int userId;
  final DeliveryAddress address;

  AddAddressEvent({
    required this.userId,
    required this.address,
  });
}

class DeleteAddressEvent extends DeliveryAddressesEvent {
  final int addressId;

  DeleteAddressEvent({
    required this.addressId,
  });
}
