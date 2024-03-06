import 'package:client/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../styles/ts.dart';
import '../../widgets/button_style.dart';

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
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                          'Pizzas',
                          style: TS.getPoiret(56, FontWeight.w700, AppColors.deepOrange),
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
                      style: ButtonStyles.getCutedOrangeButtonStyle(120, 20),
                      child: Text(
                        'Вход',
                        style: TS.getOpenSans(20, FontWeight.w600, AppColors.white),
                      ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                      style: ButtonStyles.getCutedWhiteButtonStyle(80, 20),
                    child: Text(
                      'Регистрация',
                      style: TS.getOpenSans(20, FontWeight.w600, AppColors.deepOrange),
                    ),
                  )
                ]
            )
          )
        )
    );
  }
}
