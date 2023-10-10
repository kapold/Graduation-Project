import 'package:client/features/login/login_feature.dart';
import 'package:client/repositories/user_repository.dart';
import 'package:client/utils/local_storage.dart';
import 'package:client/utils/logs.dart';
import 'package:client/utils/snacks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

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
    final loginBloc = LoginBloc();
    return BlocConsumer<LoginBloc, LoginState> (
      bloc: loginBloc,
      builder: (context, state) {
        if (state is CommonLoginState || state is FailedLoginState) {
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
                                if (password.length < 8 || password.length > 16) {
                                  Logs.warningLog('Password Is Not Valid', 'NotValidInfo');
                                  return;
                                }

                                loginBloc.add(ProcessLoginEvent(
                                  phoneNumber: phoneNumber,
                                  password: password
                                ));
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
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.deepOrange
                  )
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
        else {
          return const Scaffold(
            body: Center(
              child: Text('Error occured')
            )
          );
        }
      },
      listener: (context, state) async {
        if (state is SuccessfulLoginState) {
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
          Snacks.success(context, 'Successfully logged!');
        }
        else if (state is FailedLoginState) {
          Snacks.failed(context, 'Login failed!');
        }
      }
    );
  }
}
