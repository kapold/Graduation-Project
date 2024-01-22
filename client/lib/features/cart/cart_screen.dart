import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: Image.asset('assets/images/add_cart.png')
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Oh, empty!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                        'Your cart is empty, open the «Menu» and select the product you like.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300
                        )
                    )
                  )
                ]
              )
            )
        )
    );
  }
}
