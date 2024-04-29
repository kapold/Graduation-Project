import 'package:client/features/cart/bloc/cart_bloc.dart';
import 'package:client/features/cart/bloc/cart_event.dart';
import 'package:client/features/orders/bloc/order_bloc.dart';
import 'package:client/features/orders/bloc/order_event.dart';
import 'package:client/models/order.dart';
import 'package:client/repositories/address_repository.dart';
import 'package:client/styles/ts.dart';
import 'package:client/utils/local_db.dart';
import 'package:client/utils/profile_data.dart';
import 'package:client/utils/snacks.dart';
import 'package:client/widgets/cart_item.dart';
import 'package:client/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../models/delivery_address.dart';
import '../../models/order_item.dart';
import '../../styles/app_colors.dart';
import 'bloc/cart_state.dart';

class CartScreen extends StatefulWidget {
  CartScreen(this.externalContext, this.cartBloc, this.orderBloc, {super.key});

  BuildContext externalContext;
  CartBloc cartBloc;
  OrderBloc orderBloc;

  @override
  State<CartScreen> createState() => _CartScreenState(externalContext, cartBloc, orderBloc);
}

class _CartScreenState extends State<CartScreen> {
  _CartScreenState(this.externalContext, this.cartBloc, this.orderBloc);

  BuildContext externalContext;
  CartBloc cartBloc;
  OrderBloc orderBloc;

  final List<String> _paymentTypes = ['Наличными', 'Картой'];
  List<DeliveryAddress> _deliveryAddresses = [];
  int _selectedAddressIndex = 0, _selectedPaymentIndex = 0;

  void _showAddressesDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 64,
            scrollController: FixedExtentScrollController(
              initialItem: _selectedAddressIndex,
            ),
            onSelectedItemChanged: (int index) {
              setState(() {
                _selectedAddressIndex = index;
              });
            },
            children:
            List<Widget>.generate(_deliveryAddresses.length, (int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Center(child: Text(_deliveryAddresses[index].toString())),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _addOrder(List<OrderItem> orderItems) {
    Navigator.pop(context);
    cartBloc.add(OrderCartEvent(
      AppData.user.id,
      _paymentTypes[_selectedPaymentIndex] == 'Наличными' ? 'in cash' : 'by card',
      CartItems.getTotalPrice(orderItems),
      orderItems,
    ));
  }

  void _showOrderInfo(List<OrderItem> orderItems) {
    AddressRepository.getUserAddresses(AppData.user.id).then((addresses) {
      if (addresses.isNotEmpty) {
        _deliveryAddresses = addresses;
      } else {
        _deliveryAddresses = [];
      }

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Container(
                height: 490,
                width: MediaQuery.of(context).size.width,
                color: AppColors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Закрыть',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.deepOrange),
                        ),
                      ),
                      const Divider(
                        color: AppColors.lightGrey,
                        thickness: 1,
                      ),
                      _deliveryAddresses.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 7),
                                Text(
                                  'Добавьте адрес доставки для продолжения оформления заказа!',
                                  textAlign: TextAlign.center,
                                  style: TS.getOpenSans(
                                      20, FontWeight.w500, AppColors.lightGrey),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(externalContext, '/addresses');
                                  },
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        const Size(double.infinity, 50)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.deepOrange),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                  ),
                                  child: Text(
                                    'Добавить адрес',
                                    style: TS.getOpenSans(
                                        20, FontWeight.w600, AppColors.white),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Адрес доставки',
                                  style: TS.getOpenSans(22, FontWeight.w700, AppColors.black),
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  child: GestureDetector(
                                    onTap: () => _showAddressesDialog(context),
                                    child: Container(
                                        height: 60,
                                        width: MediaQuery.of(context).size.width,
                                        color: AppColors.lightGrey,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  _deliveryAddresses[_selectedAddressIndex].toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TS.getOpenSans(
                                                      20,
                                                      FontWeight.w700,
                                                      AppColors.white),
                                                ),
                                              ),
                                              const SizedBox(width: 40),
                                              const Icon(
                                                Icons.arrow_forward_ios_outlined,
                                                color: AppColors.white,
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Способ оплаты',
                                  style: TS.getOpenSans(22, FontWeight.w700, AppColors.black),
                                ),
                                const SizedBox(height: 10),
                                ToggleSwitch(
                                  minWidth: MediaQuery.of(context).size.width - 246,
                                  minHeight: 50,
                                  fontSize: 18,
                                  activeBgColor: const [AppColors.deepOrange],
                                  activeFgColor: AppColors.white,
                                  inactiveBgColor: AppColors.grey,
                                  initialLabelIndex: _selectedPaymentIndex,
                                  totalSwitches: _paymentTypes.length,
                                  labels: _paymentTypes,
                                  onToggle: (index) {
                                    _selectedPaymentIndex = index!;
                                  },
                                ),
                                const SizedBox(height: 60),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Время выполнения',
                                      style: TS.getOpenSans(20, FontWeight.w500, AppColors.black),
                                    ),
                                    Text(
                                      '~15 мин',
                                      style: TS.getOpenSans(20, FontWeight.w500, AppColors.deepOrange),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Сумма заказа',
                                      style: TS.getOpenSans(20, FontWeight.w500, AppColors.black),
                                    ),
                                    Text(
                                      '${CartItems.getTotalPrice(orderItems).toStringAsFixed(2)} руб',
                                      style: TS.getOpenSans(20, FontWeight.w500, AppColors.deepOrange),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    _addOrder(orderItems);
                                  },
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        Size(MediaQuery.of(context).size.width, 50)),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        AppColors.deepOrange),
                                    shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all<double>(0),
                                  ),
                                  child: Text(
                                    'Сделать заказ',
                                    style: TS.getOpenSans(
                                        20, FontWeight.w600, AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                )),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        if (state is LoadingCartState) {
          cartBloc.add(GetCartEvent());
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Loaders.getAdaptiveLoader(),
              ),
            ),
          );
        }
        if (state is SuccessfulLoadedState) {
          if (state.orderItems.isEmpty) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset('assets/images/add-cart.png'),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Ой, пусто!',
                          style: TS.getOpenSans(
                              24, FontWeight.w700, AppColors.black),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Ваша корзина пуста, откройте «Меню» и выберите понравившийся товар.',
                            textAlign: TextAlign.center,
                            style: TS.getOpenSans(
                                18, FontWeight.w300, AppColors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.orderItems.length,
                        itemBuilder: (context, index) {
                          return CartItems.getCartItem(state.orderItems[index], cartBloc);
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Divider(
                              color: AppColors.grey,
                              thickness: 0.3,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          _showOrderInfo(state.orderItems);
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.deepOrange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(0),
                        ),
                        child: Text(
                          'Оформить за ${CartItems.getTotalPrice(state.orderItems).toStringAsFixed(2)} руб',
                          style: TS.getOpenSans(
                              20, FontWeight.w600, AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        if (state is OrderingCartState) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Loaders.getAdaptiveLoader(),
              ),
            ),
          );
        }
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Text(
                'Произошла ошибка',
                style: TS.getOpenSans(20, FontWeight.w500, AppColors.black),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessfulOrderedState) {
          LocalDb().deleteAllOrderItems().then((_) {
            cartBloc.add(GetCartEvent());
            orderBloc.add(GetOrdersEvent(AppData.user.id));
            Snacks.success(context, 'Заказ успешно оформлен');
          });
        }
        if (state is FailedOrderedState) {
          Snacks.failed(context, 'Ошибка оформления заказа');
        }
      },
    );
  }
}
