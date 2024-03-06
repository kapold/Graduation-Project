import 'package:client/styles/ts.dart';
import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
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
  }
}
