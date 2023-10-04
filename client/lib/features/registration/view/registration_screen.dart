import 'package:client/features/registration/registration_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/app_bar_style_widget.dart';
import '../../../widgets/button_style_widget.dart';
import '../../../widgets/input_decoration_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController phoneNumberController = TextEditingController(),
      passwordController = TextEditingController(),
      repeatPasswordController = TextEditingController(),
      nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState> (
        builder: (context, state) {
          if (state is CommonRegistrationState) {
            return Scaffold(
                appBar: AppBars.getCommonAppBar('Registration', context),
                body: Center(
                    child: SingleChildScrollView(
                        child: Column(
                            children: [
                              Lottie.asset(
                                  'assets/animations/registration_anima.json',
                                  width: 200
                              ),
                              const SizedBox(height: 20),
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
                                      controller: nameController,
                                      obscureText: true,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: InputDecorations.getOrangeDecoration('Name', 'Enter name', Icons.account_circle_outlined)
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
                              const SizedBox(height: 20),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: TextField(
                                      controller: repeatPasswordController,
                                      obscureText: true,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: InputDecorations.getOrangeDecoration('Repeat Password', 'Repeat password', Icons.password_outlined)
                                  )),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ButtonStyles.getCommonOrangeButtonStyle(100, 16),
                                  child: const Text('Sign Up')
                              )
                            ]
                        )
                    )
                )
            );
          }
          else if (state is RegistrationProcessState) {
            return Scaffold(
                appBar: AppBars.getCommonAppBar('Registration', context),
                body: const Center(
                    child: Text('Registration Process state')
                )
            );
          }
          else if (state is SuccessfulRegistrationState) {
            return Scaffold(
                appBar: AppBars.getCommonAppBar('Registration', context),
                body: const Center(
                    child: Text('Successful Registration state')
                )
            );
          }
          else if (state is FailedRegistrationState) {
            return Scaffold(
                appBar: AppBars.getCommonAppBar('Registration', context),
                body: const Center(
                    child: Text('Failed Registration state')
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
