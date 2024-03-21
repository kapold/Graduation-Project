import 'package:client/features/cart/bloc/cart_bloc.dart';
import 'package:client/features/cart/bloc/cart_event.dart';
import 'package:client/styles/ts.dart';
import 'package:client/utils/snacks.dart';
import 'package:client/widgets/cart_item.dart';
import 'package:client/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/app_colors.dart';
import 'bloc/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: _cartBloc,
      builder: (context, state) {
        if (state is LoadingCartState) {
          _cartBloc.add(GetCartEvent());
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
                          child: Image.asset('assets/images/add_cart.png'),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Ой, пусто!',
                          style: TS.getOpenSans(24, FontWeight.w700, AppColors.black),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Ваша корзина пуста, откройте «Меню» и выберите понравившийся товар.',
                            textAlign: TextAlign.center,
                            style: TS.getOpenSans(18, FontWeight.w300, AppColors.black),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.orderItems.length,
                        itemExtent: 100,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CartItems.getCartItem(state.orderItems[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
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
          Snacks.success(context, 'Заказ успешно оформлен');
        }
        if (state is FailedOrderedState) {
          Snacks.failed(context, 'Ошибка оформления заказа');
        }
      },
    );
  }
}
