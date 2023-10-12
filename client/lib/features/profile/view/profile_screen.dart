import 'package:client/utils/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/snacks.dart';
import '../../../widgets/button_style_widget.dart';
import '../../../widgets/input_decoration_widget.dart';
import '../../../widgets/text_style_widget.dart';
import '../profile_feature.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController phoneNumberController = TextEditingController(),
      nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = ProfileData.user.phoneNumber;
    nameController.text = ProfileData.user.name;
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = ProfileBloc();
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
                                    'Profile Settings',
                                    style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                                ),
                                const SizedBox(height: 40),
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
                                const SizedBox(height: 100),
                                ElevatedButton(
                                    onPressed: () {
                                      profileBloc.add(DeleteUserEvent(
                                          id: ProfileData.user.id
                                      ));
                                    },
                                    style: ButtonStyles.getOutlinedRedButtonStyle(60, 8),
                                    child: const Text('Delete Account')
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      profileBloc.add(LogoutEvent());
                                    },
                                    style: ButtonStyles.getOutlinedOrangeButtonStyle(100, 8),
                                    child: const Text('Logout')
                                )
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
                                    'Profile Settings',
                                    style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                                ),
                                const SizedBox(height: 40),
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
                                      profileBloc.add(UpdateUserEvent(
                                          id: ProfileData.user.id,
                                          name: ProfileData.user.name
                                      ));
                                    },
                                    style: ButtonStyles.getCommonOrangeButtonStyle(110, 8),
                                    child: const Text('Save')
                                ),
                                const SizedBox(height: 100),
                                const CircularProgressIndicator.adaptive(backgroundColor: Colors.deepOrange),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      profileBloc.add(LogoutEvent());
                                    },
                                    style: ButtonStyles.getOutlinedOrangeButtonStyle(100, 8),
                                    child: const Text('Logout')
                                )
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
                                    'Profile Settings',
                                    style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                                ),
                                const SizedBox(height: 40),
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
                                      profileBloc.add(UpdateUserEvent(
                                          id: ProfileData.user.id,
                                          name: ProfileData.user.name
                                      ));
                                    },
                                    style: ButtonStyles.getCommonOrangeButtonStyle(110, 8),
                                    child: const Text('Save')
                                ),
                                const SizedBox(height: 100),
                                ElevatedButton(
                                    onPressed: () {
                                      profileBloc.add(DeleteUserEvent(
                                          id: ProfileData.user.id
                                      ));
                                    },
                                    style: ButtonStyles.getOutlinedRedButtonStyle(60, 8),
                                    child: const Text('Delete Account')
                                ),
                                const SizedBox(height: 10),
                                const CircularProgressIndicator.adaptive(backgroundColor: Colors.deepOrange)
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
                                    'Profile Settings',
                                    style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 24)
                                ),
                                const SizedBox(height: 40),
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
                                      if (nameController.text.isEmpty) {
                                        Snacks.alert(context, 'Name must be not empty');
                                        return;
                                      }

                                      ProfileData.user.name = nameController.text;
                                      profileBloc.add(UpdateUserEvent(
                                          id: ProfileData.user.id,
                                          name: ProfileData.user.name
                                      ));
                                    },
                                    style: ButtonStyles.getCommonOrangeButtonStyle(110, 8),
                                    child: const Text('Save')
                                ),
                                const SizedBox(height: 100),
                                ElevatedButton(
                                    onPressed: () {
                                      profileBloc.add(DeleteUserEvent(
                                          id: ProfileData.user.id
                                      ));
                                    },
                                    style: ButtonStyles.getOutlinedRedButtonStyle(60, 8),
                                    child: const Text('Delete Account')
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      profileBloc.add(LogoutEvent());
                                    },
                                    style: ButtonStyles.getOutlinedOrangeButtonStyle(100, 8),
                                    child: const Text('Logout')
                                )
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
