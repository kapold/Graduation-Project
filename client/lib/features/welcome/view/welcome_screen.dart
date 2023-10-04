import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/button_style_widget.dart';
import '../../../widgets/text_style_widget.dart';

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
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Lottie.asset(
                        'assets/animations/welcome_anima.json',
                        width: 400
                    )
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        const Text(
                          'Welcome, pizza lover!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: Colors.deepOrange
                          )
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Whether you're craving a classic Margherita, a meaty feast, or a veggie delight, we've got you covered.",
                          textAlign: TextAlign.justify,
                          style: TextStyles.getTextStyle('Poppins', FontWeight.w300, 16)
                        )
                      ]
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
