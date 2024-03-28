import 'package:client/features/delivery_addresses/bloc/delivery_addresses_bloc.dart';
import 'package:client/features/delivery_addresses/bloc/delivery_addresses_event.dart';
import 'package:client/features/delivery_addresses/bloc/delivery_addresses_state.dart';
import 'package:client/styles/ts.dart';
import 'package:client/utils/profile_data.dart';
import 'package:client/utils/snacks.dart';
import 'package:client/widgets/loader.dart';
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
  List<DeliveryAddress> _deliveryAddresses = [];
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _deliveryAddressesBloc.add(GetAddressesEvent(userId: AppData.user.id));
  }

  void _addAddressBtn() {
    String address = _addressController.text;
    if (address.isEmpty) {
      Snacks.failed(context, 'Заполните поле с адресом!');
      return;
    }
    _deliveryAddressesBloc.add(AddAddressEvent(
        userId: AppData.user.id, address: _addressController.text));
    _addressController.text = '';
    _deliveryAddressesBloc.add(GetAddressesEvent(userId: AppData.user.id));
  }

  void _deleteAddressBtn(int addressId) {
    _deliveryAddressesBloc.add(DeleteAddressEvent(addressId: addressId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryAddressesBloc, DeliveryAddressesState>(
      bloc: _deliveryAddressesBloc,
      builder: (context, state) {
        if (state is LoadingAddressesState) {
          return Scaffold(
            appBar: AppBars.getCommonAppBar('Адреса доставки', context),
            body: Center(
              child: Loaders.getDotsTriangle(60),
            ),
          );
        }
        if (state is SuccessfulLoadedAddressesState ||
            state is SuccessfulAddedAddressesState ||
            state is SuccessfulDeletedAddressesState) {
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
                        _deliveryAddresses.isEmpty
                            ? Center(
                                child: Text(
                                  'Добавьте пару своих адресов!',
                                  style: TS.getOpenSans(
                                      20, FontWeight.w300, AppColors.black),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _deliveryAddresses.length,
                                itemBuilder: (context, index) {
                                  DeliveryAddress address =
                                      _deliveryAddresses[index];
                                  return Dismissible(
                                    key: Key(address.address),
                                    background:
                                        Container(color: AppColors.darkerRed),
                                    secondaryBackground: Container(
                                      color: AppColors.darkerRed,
                                      alignment: Alignment.centerRight,
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 16),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      _deleteAddressBtn(address.id);
                                      _deliveryAddresses.remove(address);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/circle.png',
                                              color: AppColors.deepOrange,
                                              scale: 2.8,
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                address.address,
                                                style: TS.getOpenSans(18, FontWeight.w500, AppColors.black),
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
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
                      Center(
                        child: Text(
                          'Добавьте пару своих адресов!',
                          style: TS.getOpenSans(
                              20, FontWeight.w300, AppColors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessfulLoadedAddressesState) {
          _deliveryAddresses = state.deliveryAddresses;
        }
        if (state is FailedAddressesState) {
          Snacks.failed(context, 'Ошибка добавления адреса');
        }
        if (state is SuccessfulAddedAddressesState) {
          Snacks.success(context, 'Адрес добавлен успешно');
          _deliveryAddressesBloc
              .add(GetAddressesEvent(userId: AppData.user.id));
        }
        if (state is SuccessfulDeletedAddressesState) {
          Snacks.success(context, 'Адрес удален успешно');
        }
      },
    );
  }
}
