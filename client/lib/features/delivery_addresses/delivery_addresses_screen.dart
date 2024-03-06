import 'package:client/features/delivery_addresses/bloc/delivery_addresses_bloc.dart';
import 'package:client/features/delivery_addresses/bloc/delivery_addresses_event.dart';
import 'package:client/features/delivery_addresses/bloc/delivery_addresses_state.dart';
import 'package:client/styles/ts.dart';
import 'package:client/utils/profile_data.dart';
import 'package:client/utils/snacks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/delivery_address.dart';
import '../../styles/app_colors.dart';
import '../../widgets/app_bar_style.dart';
import '../../widgets/button_style.dart';
import '../../widgets/input_decoration.dart';

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
      Snacks.failed(context, 'Заполните поле с адресом!');
      return;
    }

    DeliveryAddress deliveryAddress = DeliveryAddress(
        id: 0, userId: ProfileData.user.id, address: _addressController.text);
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
            appBar: AppBars.getCommonAppBar('Адреса доставки', context),
            body: Padding(
              padding: const EdgeInsets.only(top: 16),
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
                            decoration: InputDecorations.getOrangeDecoration(
                                'Адрес доставки',
                                'Введите новый адрес',
                                Icons.location_on_outlined),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _addAddressBtn();
                          },
                          style: ButtonStyles.getSquaredOutlinedRedButtonStyle(
                              86, 14),
                          child: Text(
                            'Добавить адрес',
                            style: TS.getOpenSans(
                                20, FontWeight.w500, AppColors.deepOrange),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Адреса доставки',
                          style:
                              TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                        ),
                        const SizedBox(height: 10),
                        ProfileData.deliveryAddresses.isEmpty
                            ? Center(
                                child: Text(
                                  'Добавьте пару своих адресов!',
                                  style: TS.getOpenSans(
                                      20, FontWeight.w300, AppColors.black),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: ProfileData.deliveryAddresses.length,
                                itemExtent: 100,
                                itemBuilder: (context, index) {
                                  DeliveryAddress address =
                                      ProfileData.deliveryAddresses[index];
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
            ));
      },
      listener: (context, state) {},
    );
  }
}
