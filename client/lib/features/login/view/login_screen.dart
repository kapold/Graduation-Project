import 'package:client/features/login/login_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/validator.dart';
import '../../../widgets/app_bar_style_widget.dart';
import '../../../widgets/button_style_widget.dart';
import '../../../widgets/input_decoration_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState> (
      builder: (context, state) {
        if (state is CommonLoginState) {
          return Scaffold(
              appBar: AppBars.getCommonAppBar('Login', context),
              body: Center(
                  child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Lottie.asset(
                                    'assets/animations/login_anima.json',
                                    width: 300
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: TextField(
                                  controller: phoneNumberController,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecorations.getOrangeDecoration('Phone Number', 'Enter phone number', Icons.phone)
                            )),
                            const SizedBox(height: 20),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecorations.getOrangeDecoration('Password', 'Enter password', Icons.password_outlined)
                                )),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                String phoneNumber = phoneNumberController.text, password = passwordController.text;
                                String formattedPhoneNumber = Validator.formatBelarusPhoneNumber(phoneNumber);
                                phoneNumberController.text = formattedPhoneNumber;

                                if (formattedPhoneNumber.length != 19) {
                                  print('Phone Number Is Not Valid');
                                  return;
                                }
                                if (password.length < 8 || password.length > 16) {
                                  print('Password Is Not Valid');
                                  return;
                                }
                                // emit...
                              },
                              style: ButtonStyles.getCommonOrangeButtonStyle(100, 16),
                              child: const Text('Sign In')
                            )
                          ]
                      )
                  )
              )
          );
        }
        else if (state is LoginProcessState) {
          return Scaffold(
              appBar: AppBars.getCommonAppBar('Login', context),
              body: const Center(
                  child: Text('Login Process state')
              )
          );
        }
        else if (state is SuccessfulLoginState) {
          return Scaffold(
              appBar: AppBars.getCommonAppBar('Login', context),
              body: const Center(
                  child: Text('Successful Login state')
              )
          );
        }
        else if (state is FailedLoginState) {
          return Scaffold(
              appBar: AppBars.getCommonAppBar('Login', context),
              body: const Center(
                  child: Text('Failed Login state')
              )
          );
        }
        else {
          return const Scaffold(
            body: Center(
              child: Text('Error occured')
            )
          );
        }
      },
      listener: (context, state) {}
    );
  }
}
