import 'package:client/styles/app_colors.dart';
import 'package:client/styles/ts.dart';
import 'package:client/widgets/app_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/profile_data.dart';
import '../../utils/snacks.dart';
import '../../widgets/button_style.dart';
import '../../widgets/input_decoration.dart';
import '../settings/bloc/profile_bloc.dart';
import '../settings/bloc/profile_event.dart';
import '../settings/bloc/profile_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _profileBloc = ProfileBloc();
  final TextEditingController _phoneNumberController = TextEditingController(),
      _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneNumberController.text = ProfileData.user.phoneNumber;
    _nameController.text = ProfileData.user.name;
  }

  void _saveUserBtn() {
    if (_nameController.text.isEmpty) {
      Snacks.alert(context, 'Имя должно быть заполненым!');
      return;
    }

    ProfileData.user.name = _nameController.text;
    _profileBloc.add(
        UpdateUserEvent(id: ProfileData.user.id, name: ProfileData.user.name));
  }

  void _deleteUserBtn() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: const Text('Удалить аккаунт'),
          titleTextStyle: TS.getOpenSans(22, FontWeight.w600, AppColors.black),
          content: const Text(
              'Вы уверены, что хотите удалить аккаунт? Это действие нельзя отменить.'),
          contentTextStyle: TS.getOpenSans(14, FontWeight.w500, Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _profileBloc.add(DeleteUserEvent(id: ProfileData.user.id));
              },
              child: Text(
                'Удалить',
                style: TS.getOpenSans(14, FontWeight.w500, AppColors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Отмена',
                style: TS.getOpenSans(14, FontWeight.w500, AppColors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _logoutUserBtn() {
    _profileBloc.add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _profileBloc,
      builder: (context, state) {
        if (state is SavingProfileState) {
          return Scaffold(
            appBar: AppBars.getCommonAppBar('Информация о профиле', context),
            body: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _nameController,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecorations.getOrangeDecoration(
                              'Имя', '', Icons.account_circle_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _phoneNumberController,
                          enabled: false,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecorations.getOrangeDecoration(
                              'Номер телефона', '', Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CircularProgressIndicator.adaptive(
                          backgroundColor: AppColors.deepOrange),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _deleteUserBtn();
                        },
                        style: ButtonStyles.getSquaredOutlinedRedButtonStyle(
                            84, 14),
                        child: Text(
                          'Удалить аккаунт',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.red),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _logoutUserBtn();
                        },
                        style: ButtonStyles.getSquaredOutlinedRedButtonStyle(
                            134, 14),
                        child: Text(
                          'Выйти',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.deepOrange),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is DeletingProfileState) {
          return Scaffold(
            appBar: AppBars.getCommonAppBar('Информация о профиле', context),
            body: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _nameController,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecorations.getOrangeDecoration(
                              'Имя', '', Icons.account_circle_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _phoneNumberController,
                          enabled: false,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecorations.getOrangeDecoration(
                              'Номер телефона', '', Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _saveUserBtn();
                        },
                        style: ButtonStyles.getSquaredOrangeButtonStyle(56, 14),
                        child: Text(
                          'Сохранить изменения',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CircularProgressIndicator.adaptive(
                          backgroundColor: AppColors.deepOrange),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _logoutUserBtn();
                        },
                        style: ButtonStyles.getSquaredOutlinedRedButtonStyle(
                            134, 14),
                        child: Text(
                          'Выйти',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.deepOrange),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is LogoutProfileState) {
          return Scaffold(
            appBar: AppBars.getCommonAppBar('Информация о профиле', context),
            body: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _nameController,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecorations.getOrangeDecoration(
                              'Имя', '', Icons.account_circle_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _phoneNumberController,
                          enabled: false,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecorations.getOrangeDecoration(
                              'Номер телефона', '', Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _saveUserBtn();
                        },
                        style: ButtonStyles.getSquaredOrangeButtonStyle(56, 14),
                        child: Text(
                          'Сохранить изменения',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _deleteUserBtn();
                        },
                        style: ButtonStyles.getSquaredOutlinedRedButtonStyle(
                            84, 14),
                        child: Text(
                          'Удалить аккаунт',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.red),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CircularProgressIndicator.adaptive(
                          backgroundColor: AppColors.deepOrange),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBars.getCommonAppBar('Информация о профиле', context),
            body: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _nameController,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecorations.getOrangeDecoration(
                              'Имя', '', Icons.account_circle_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _phoneNumberController,
                          enabled: false,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecorations.getOrangeDecoration(
                              'Номер телефона', '', Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _saveUserBtn();
                        },
                        style: ButtonStyles.getSquaredOrangeButtonStyle(56, 14),
                        child: Text(
                          'Сохранить изменения',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _deleteUserBtn();
                        },
                        style: ButtonStyles.getSquaredOutlinedRedButtonStyle(
                            84, 14),
                        child: Text(
                          'Удалить аккаунт',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.red),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _logoutUserBtn();
                        },
                        style: ButtonStyles.getSquaredOutlinedRedButtonStyle(
                            134, 14),
                        child: Text(
                          'Выйти',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.deepOrange),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      listener: (context, state) async {
        if (state is SavingProfileState) {
          Snacks.success(context, 'Профиль обновлен!');
        } else if (state is DeletingProfileState) {
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              '/welcome', (Route<dynamic> route) => true);
          Snacks.success(context, 'Аккаунт удален!');
        } else if (state is LogoutProfileState) {
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              '/welcome', (Route<dynamic> route) => true);
        }
      },
    );
  }
}
