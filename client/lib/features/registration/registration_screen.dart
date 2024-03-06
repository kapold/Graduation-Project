import 'package:client/styles/app_colors.dart';
import 'package:client/styles/ts.dart';
import 'package:client/utils/snacks.dart';
import 'package:client/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/app_bar_style.dart';
import '../../widgets/button_style.dart';
import '../../widgets/input_decoration.dart';
import 'bloc/registration_bloc.dart';
import 'bloc/registration_event.dart';
import 'bloc/registration_state.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registrationBloc = RegistrationBloc();
  final TextEditingController _phoneNumberController = TextEditingController(),
      _passwordController = TextEditingController(),
      _repeatPasswordController = TextEditingController(),
      _nameController = TextEditingController();

  void _onRegistrationBtn() {
    String phoneNumber = _phoneNumberController.text,
        password = _passwordController.text,
        repeatPassword = _repeatPasswordController.text,
        name = _nameController.text;

    if (password != repeatPassword) {
      Snacks.failed(context, 'Пароли не совпадают!');
      return;
    }
    if (password.length < 8 || password.length > 16) {
      Snacks.failed(context, 'Длина пароля должна быть 8-16 символов!');
      return;
    }

    _registrationBloc.add(ProcessRegistrationEvent(
        phoneNumber: phoneNumber,
        password: password,
        name: name,
        isAdmin: false,
        isStaff: false
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState> (
        bloc: _registrationBloc,
        builder: (context, state) {
          if (state is CommonRegistrationState || state is FailedRegistrationState) {
            return Scaffold(
                appBar: AppBars.getCommonAppBar('Регистрация', context),
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
                                      controller: _phoneNumberController,
                                      cursorColor: AppColors.deepOrange,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: InputDecorations.getOrangeDecoration('Номер телефона', '+375xxxxxxxxx', Icons.phone)
                                  )),
                              const SizedBox(height: 20),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: TextField(
                                      controller: _nameController,
                                      cursorColor: AppColors.deepOrange,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: InputDecorations.getOrangeDecoration('Имя', '', Icons.account_circle_outlined)
                                  )),
                              const SizedBox(height: 20),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: TextField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      cursorColor: AppColors.deepOrange,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: InputDecorations.getOrangeDecoration('Пароль', '', Icons.password_outlined, )
                                  )),
                              const SizedBox(height: 20),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: TextField(
                                      controller: _repeatPasswordController,
                                      obscureText: true,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: InputDecorations.getOrangeDecoration('Повтор пароля', '', Icons.password_outlined)
                                  )),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                  onPressed: () {
                                    _onRegistrationBtn();
                                  },
                                  style: ButtonStyles.getCommonOrangeButtonStyle(60, 16),
                                  child: Text(
                                    'Зарегистрироваться',
                                    style: TS.getOpenSans(20, FontWeight.w500, AppColors.white),
                                  ),
                              )
                            ]
                        )
                    )
                )
            );
          }
          else if (state is RegistrationProcessState) {
            return Scaffold(
                appBar: AppBars.getCommonAppBar('Регистрация', context),
                body: Loaders.getDotsTriangle(60)
            );
          }
          else if (state is SuccessfulRegistrationState) {
            return Scaffold(
                appBar: AppBars.getCommonAppBar('Регистрация', context),
                body: const Center(child: Text('Регистрация успешно выполнена'))
            );
          }
          else {
            return const Scaffold(
                body: Center(child: Text('Произошла ошибка'))
            );
          }
        },
        listener: (context, state) {
          if (state is SuccessfulRegistrationState) {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            Snacks.success(context, 'Регистрация успешно выполнена!');
          }
          else if (state is FailedRegistrationState) {
            Snacks.failed(context, state.errorMessage);
          }
        }
    );
  }
}
