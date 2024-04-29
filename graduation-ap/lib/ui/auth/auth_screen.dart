import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_ap/styles/app_colors.dart';
import 'package:graduation_ap/styles/ts.dart';
import 'package:graduation_ap/utils/app_data.dart';
import 'package:graduation_ap/utils/logs.dart';
import 'package:graduation_ap/utils/snacks.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../admin_panel/admin_panel_screen.dart';
import '../delivery_panel/delivery_panel_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authBloc = AuthBloc();
  late TextEditingController _accessKeyController;

  @override
  void initState() {
    _accessKeyController = TextEditingController();
    _authBloc.add(AuthUserEvent('2602'));
    super.initState();
  }

  void _authBtn() {
    String accessKey = _accessKeyController.text;
    if (accessKey.isEmpty) {
      Snacks.alert(context, 'Введите ключ доступа!');
      return;
    }

    _authBloc.add(AuthUserEvent(accessKey));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      builder: (context, state) {
        if (state is ProcessAuthState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Pizzas \nAdmin Panel',
                    textAlign: TextAlign.center,
                    style: TS.getOpenSans(
                        32, FontWeight.w500, AppColors.deepOrange),
                  ),
                  const SizedBox(height: 40),
                  LoadingAnimationWidget.threeArchedCircle(
                    color: AppColors.deepOrange,
                    size: 60,
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pizzas \nAdmin Panel',
                  textAlign: TextAlign.center,
                  style:
                      TS.getOpenSans(32, FontWeight.w500, AppColors.deepOrange),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _accessKeyController,
                    decoration: const InputDecoration(
                      labelText: 'Ключ доступа',
                      border: OutlineInputBorder(),
                      hintText: 'Введите ключ доступа',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _authBtn();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepOrange,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 20),
                    side:
                        const BorderSide(color: AppColors.deepOrange, width: 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    textStyle:
                        TS.getPoppins(20, FontWeight.w500, AppColors.black),
                  ),
                  child: Text(
                    'Войти',
                    style: TS.getOpenSans(20, FontWeight.w500, AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is FailedState) {
          Snacks.failed(context, 'Ошибка при попытке входа');
          Logs.traceLog(state.errorMessage);
        } else if (state is SuccessfulAuthState) {
          if (state.user.role == 'admin') {
            AppData.currentUser = state.user;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const AdminPanelScreen(),
              ),
              (Route<dynamic> route) => false,
            );
          } else if (state.user.role == 'deliveryman') {
            AppData.currentUser = state.user;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const DeliveryPanelScreen(),
              ),
              (Route<dynamic> route) => false,
            );
          } else {
            Snacks.failed(context, 'Доступ обычным пользователям запрещен!');
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _accessKeyController.dispose();
    super.dispose();
  }
}
