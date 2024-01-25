import 'package:client/features/delivery_addresses/bloc/delivery_addresses_bloc.dart';
import 'package:client/features/delivery_addresses/bloc/delivery_addresses_event.dart';
import 'package:client/features/delivery_addresses/bloc/delivery_addresses_state.dart';
import 'package:client/utils/profile_data.dart';
import 'package:client/utils/snacks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/delivery_address.dart';
import '../../widgets/app_bar_style_widget.dart';
import '../../widgets/button_style_widget.dart';
import '../../widgets/input_decoration_widget.dart';
import '../../widgets/text_style_widget.dart';

class DeliveryAddressesScreen extends StatefulWidget {
  const DeliveryAddressesScreen({super.key});

  @override
  State<DeliveryAddressesScreen> createState() =>
      _DeliveryAddressesScreenState();
}

class _DeliveryAddressesScreenState extends State<DeliveryAddressesScreen> {
  final _deliveryAddressesBloc = DeliveryAddressesBloc();
  final TextEditingController _addressController = TextEditingController();

  void _addAddressBtn() {
    String address = _addressController.text;
    if (address.isEmpty) {
      Snacks.failed(context, 'Add address name!');
      return;
    }

    DeliveryAddress deliveryAddress = DeliveryAddress(
      id: 0,
      userId: ProfileData.user.id,
      address: _addressController.text
    );
    _deliveryAddressesBloc.add(AddAddressEvent(address: deliveryAddress));
  }

  void _deleteAddress(int addressId) {
    _deliveryAddressesBloc.add(DeleteAddressEvent(addressId: addressId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryAddressesBloc, DeliveryAddressesState>(
      bloc: _deliveryAddressesBloc,
      builder: (context, state) {
        return Scaffold(
            appBar: AppBars.getCommonAppBar('Delivery Addresses', context),
            body: Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Align(
                alignment: Alignment.topCenter,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextField(
                                controller: _addressController,
                                style: const TextStyle(fontSize: 18),
                                decoration: InputDecorations.getOrangeDecoration('Delivery address', 'Enter new address to add', Icons.location_on_outlined)
                            )),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              _addAddressBtn();
                            },
                            style: ButtonStyles.getSquaredOutlinedRedButtonStyle(102, 12),
                            child: const Text('Add address')
                        ),
                        const SizedBox(height: 20),
                        Text(
                            'Delivery addresses',
                            style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                        ),
                        const SizedBox(height: 10),
                        ProfileData.deliveryAddresses.isEmpty
                          ? const Center(child: Text('Add a couple of addresses!'))
                          : ListView.builder(
                            shrinkWrap: true,
                            itemCount: ProfileData.deliveryAddresses.length,
                            itemExtent: 100,
                            itemBuilder: (context, index) {
                              DeliveryAddress address = ProfileData.deliveryAddresses[index];
                              return ListTile(
                                title: Text('$index. ${address.address}'),
                              );
                            },
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
        );
      },
      listener: (context, state) {},
    );
  }
}
