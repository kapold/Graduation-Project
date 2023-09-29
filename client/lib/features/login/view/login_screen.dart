import 'package:flutter/material.dart';

import '../../../widgets/app_bar_style_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.getCommonAppBar('Login'),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
                    children: [

                    ]
                )
            )
        )
    );
  }
}
