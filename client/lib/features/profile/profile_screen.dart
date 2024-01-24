import 'package:client/utils/profile_data.dart';
import 'package:client/widgets/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/snacks.dart';
import '../../widgets/button_style_widget.dart';
import '../../widgets/input_decoration_widget.dart';
import '../../widgets/text_style_widget.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen(this.externalContext, {super.key});

  BuildContext externalContext;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(externalContext);
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState(this.externalContext);
  BuildContext externalContext;

  final profileBloc = ProfileBloc();
  TextEditingController phoneNumberController = TextEditingController(),
      nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = ProfileData.user.phoneNumber;
    nameController.text = ProfileData.user.name;
  }

  void _saveUserBtn() {
    if (nameController.text.isEmpty) {
      Snacks.alert(context, 'Name must be not empty');
      return;
    }

    ProfileData.user.name = nameController.text;
    profileBloc.add(UpdateUserEvent(
        id: ProfileData.user.id,
        name: ProfileData.user.name
    ));
  }

  void _updateUserBtn() {
    profileBloc.add(UpdateUserEvent(
        id: ProfileData.user.id,
        name: ProfileData.user.name
    ));
  }

  void _deleteUserBtn() {
    profileBloc.add(DeleteUserEvent(
        id: ProfileData.user.id
    ));
  }

  void _logoutUserBtn() {
    profileBloc.add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: profileBloc,
      builder: (context, state) {
        if (state is SavingProfileState) {
          return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                          child: Column(
                              children: [
                                Text(
                                    'Settings',
                                    style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextField(
                                        controller: nameController,
                                        style: const TextStyle(fontSize: 18),
                                        decoration: InputDecorations.getOrangeDecoration('Name', 'Enter name to change', Icons.account_circle_outlined)
                                    )),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextField(
                                        controller: phoneNumberController,
                                        enabled: false,
                                        style: const TextStyle(fontSize: 18),
                                        decoration: InputDecorations.getOrangeDecoration('Phone Number', 'Enter phone number to change', Icons.phone)
                                    )),
                                const SizedBox(height: 20),
                                const CircularProgressIndicator.adaptive(backgroundColor: Colors.deepOrange),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      _deleteUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOutlinedRedButtonStyle(90, 12),
                                    child: const Text('Delete Account')
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      _logoutUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOutlinedRedButtonStyle(134, 12),
                                    child: const Text('Logout')
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(),
                                ),
                                const SizedBox(height: 10),
                                AppWidgets.getProfileButtonsBlock(externalContext),
                              ]
                          )
                      )
                  )
              )
          );
        }
        else if (state is DeletingProfileState) {
          return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                          child: Column(
                              children: [
                                Text(
                                    'Settings',
                                    style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextField(
                                        controller: nameController,
                                        style: const TextStyle(fontSize: 18),
                                        decoration: InputDecorations.getOrangeDecoration('Name', 'Enter name to change', Icons.account_circle_outlined)
                                    )),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextField(
                                        controller: phoneNumberController,
                                        enabled: false,
                                        style: const TextStyle(fontSize: 18),
                                        decoration: InputDecorations.getOrangeDecoration('Phone Number', 'Enter phone number to change', Icons.phone)
                                    )),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () {
                                      _saveUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOrangeButtonStyle(94, 12),
                                    child: const Text('Save changes')
                                ),
                                const SizedBox(height: 10),
                                const CircularProgressIndicator.adaptive(backgroundColor: Colors.deepOrange),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      _logoutUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOutlinedRedButtonStyle(134, 12),
                                    child: const Text('Logout')
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(),
                                ),
                                const SizedBox(height: 10),
                                AppWidgets.getProfileButtonsBlock(externalContext),
                              ]
                          )
                      )
                  )
              )
          );
        }
        else if (state is LogoutProfileState) {
          return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                          child: Column(
                              children: [
                                Text(
                                    'Settings',
                                    style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextField(
                                        controller: nameController,
                                        style: const TextStyle(fontSize: 18),
                                        decoration: InputDecorations.getOrangeDecoration('Name', 'Enter name to change', Icons.account_circle_outlined)
                                    )),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextField(
                                        controller: phoneNumberController,
                                        enabled: false,
                                        style: const TextStyle(fontSize: 18),
                                        decoration: InputDecorations.getOrangeDecoration('Phone Number', 'Enter phone number to change', Icons.phone)
                                    )),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () {
                                      _saveUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOrangeButtonStyle(94, 12),
                                    child: const Text('Save changes')
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      _deleteUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOutlinedRedButtonStyle(90, 12),
                                    child: const Text('Delete Account')
                                ),
                                const SizedBox(height: 10),
                                const CircularProgressIndicator.adaptive(backgroundColor: Colors.deepOrange),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(),
                                ),
                                const SizedBox(height: 10),
                                AppWidgets.getProfileButtonsBlock(externalContext),
                              ]
                          )
                      )
                  )
              )
          );
        }
        else {
          return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                          child: Column(
                              children: [
                                Text(
                                    'Settings',
                                    style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextField(
                                        controller: nameController,
                                        style: const TextStyle(fontSize: 18),
                                        decoration: InputDecorations.getOrangeDecoration('Name', 'Enter name to change', Icons.account_circle_outlined)
                                    )),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextField(
                                        controller: phoneNumberController,
                                        enabled: false,
                                        style: const TextStyle(fontSize: 18),
                                        decoration: InputDecorations.getOrangeDecoration('Phone Number', 'Enter phone number to change', Icons.phone)
                                    )),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () {
                                      _saveUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOrangeButtonStyle(94, 12),
                                    child: const Text('Save changes')
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      _deleteUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOutlinedRedButtonStyle(90, 12),
                                    child: const Text('Delete Account')
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      _logoutUserBtn();
                                    },
                                    style: ButtonStyles.getSquaredOutlinedRedButtonStyle(134, 12),
                                    child: const Text('Logout')
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Divider(),
                                ),
                                const SizedBox(height: 10),
                                AppWidgets.getProfileButtonsBlock(externalContext),
                              ]
                          )
                      )
                  )
              )
          );
        }
      },
      listener: (context, state) async {
        if (state is SavingProfileState) {
          Snacks.success(context, 'Profile updated!');
        }
        else if (state is DeletingProfileState) {
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => true);
          Snacks.success(context, 'Account deleted!');
        }
        else if (state is LogoutProfileState) {
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => true);
          Snacks.success(context, 'Logout successfully!');
        }
      },
    );
  }
}
