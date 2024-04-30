import 'package:client/styles/ts.dart';
import 'package:client/utils/logs.dart';
import 'package:client/utils/snacks.dart';
import 'package:client/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../styles/app_colors.dart';
import '../../widgets/app_bar_style.dart';
import '../../widgets/button_style.dart';
import '../../widgets/input_decoration.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();
  final TextEditingController _phoneNumberController = TextEditingController(),
      _passwordController = TextEditingController();
  final bool _passwordHidden = true;

  void _onLoginBtn() {
    String phoneNumber = _phoneNumberController.text, password = _passwordController.text;
    if (password.length < 8 || password.length > 16) {
      Snacks.failed(context, 'Пароль должен быть 8-16 символов!');
      Logs.warningLog('Password Is Not Valid', 'NotValidInfo');
      return;
    }

    _loginBloc.add(ProcessLoginEvent(
        phoneNumber: phoneNumber,
        password: password
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (context, state) {
        if (state is CommonLoginState || state is FailedLoginState) {
          return Scaffold(
              appBar: AppBars.getCommonAppBar('Вход', context),
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
                                  controller: _phoneNumberController,
                                  style: const TextStyle(fontSize: 18),
                                  cursorColor: AppColors.deepOrange,
                                  decoration: InputDecorations.getOrangeDecoration('Номер телефона', '', Icons.phone)
                            )),
                            const SizedBox(height: 20),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    cursorColor: AppColors.deepOrange,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecorations.getOrangeDecoration('Пароль', '', Icons.password_outlined)
                                )),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                _onLoginBtn();
                              },
                              style: ButtonStyles.getCommonOrangeButtonStyle(100, 16),
                              child: Text(
                                'Войти',
                                style: TS.getOpenSans(20, FontWeight.w500, AppColors.white),
                              )
                            )
                          ]
                      )
                  )
              )
          );
        }
        else if (state is LoginProcessState) {
          return Scaffold(
              appBar: AppBars.getCommonAppBar('Вход', context),
              body: Loaders.getDotsTriangle(60)
          );
        }
        else if (state is SuccessfulLoginState) {
          return Scaffold(
              appBar: AppBars.getCommonAppBar('Вход', context),
              body: const Center(child: Text('Вход выполнен успешно'))
          );
        }
        else {
          return const Scaffold(
            body: Center(child: Text('Произошла ошибка'))
          );
        }
      },
      listener: (context, state) async {
        if (state is SuccessfulLoginState) {
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
        }
        else if (state is FailedLoginState) {
          Snacks.failed(context, state.errorMessage);
          Logs.traceLog(state.errorMessage);
        }
      }
    );
  }
}
