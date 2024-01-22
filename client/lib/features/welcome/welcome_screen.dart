import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/button_style_widget.dart';
import '../../widgets/text_style_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                          'Pizzas',
                          style: TextStyle(
                              fontFamily: 'Poiret',
                              fontWeight: FontWeight.bold,
                              fontSize: 56,
                              color: Colors.deepOrange
                          )
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Lottie.asset(
                          'assets/animations/welcome_anima.json',
                          width: 400
                      )
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ButtonStyles.getCutedOrangeButtonStyle(),
                      child: const Text('Sign In')
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                      style: ButtonStyles.getCutedWhiteButtonStyle(),
                      child: const Text('Sign Up')
                  )
                ]
            )
          )
        )
    );
  }
}
