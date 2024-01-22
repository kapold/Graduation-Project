import 'package:client/utils/logs.dart';
import 'package:client/utils/snacks.dart';
import 'package:client/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/app_bar_style_widget.dart';
import '../../widgets/button_style_widget.dart';
import '../../widgets/input_decoration_widget.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginBloc = LoginBloc();
  TextEditingController phoneNumberController = TextEditingController(),
      passwordController = TextEditingController();
  bool passwordHidden = true;

  void _onLoginBtn() {
    String phoneNumber = phoneNumberController.text, password = passwordController.text;
    if (password.length < 8 || password.length > 16) {
      Logs.warningLog('Password Is Not Valid', 'NotValidInfo');
      return;
    }

    loginBloc.add(ProcessLoginEvent(
        phoneNumber: phoneNumber,
        password: password
    ));
  }

  @override
  Widget build(BuildContext context) {
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
                                  cursorColor: Colors.deepOrangeAccent,
                                  decoration: InputDecorations.getOrangeDecoration('Phone Number', 'Enter phone number', Icons.phone)
                            )),
                            const SizedBox(height: 20),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    cursorColor: Colors.deepOrangeAccent,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecorations.getOrangeDecoration('Password', 'Enter password', Icons.password_outlined)
                                )),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                _onLoginBtn();
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
              body: Loaders.getDotsTriangle()
          );
        }
        else if (state is SuccessfulLoginState) {
          return Scaffold(
              appBar: AppBars.getCommonAppBar('Login', context),
              body: const Center(child: Text('Successful Login state'))
          );
        }
        else {
          return const Scaffold(
            body: Center(child: Text('Error occured'))
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
