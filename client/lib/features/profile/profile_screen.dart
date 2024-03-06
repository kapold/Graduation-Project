import 'package:client/features/settings/settings_screen.dart';
import 'package:client/styles/app_colors.dart';
import 'package:client/styles/ts.dart';
import 'package:client/widgets/container.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen(this.externalContext, {super.key});

  BuildContext externalContext;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(externalContext);
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState(this.externalContext);

  BuildContext externalContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Настройки',
                        style:
                        TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            externalContext,
                            MaterialPageRoute(
                                builder: (context) => const SettingsScreen()),
                          );
                        },
                        child: const Icon(Icons.settings_outlined, size: 32),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(),
                ),
                const SizedBox(height: 10),
                AppWidgets.getProfileButtonsBlock(externalContext),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
