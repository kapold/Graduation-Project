import 'package:flutter/material.dart';

import '../../../widgets/app_bar_style_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.getCommonAppBar('Registration'),
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
