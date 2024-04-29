import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_ap/firebase_options.dart';
import 'package:graduation_ap/styles/app_colors.dart';
import 'package:graduation_ap/ui/auth/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  runApp(const PizzaApApp());
}

class PizzaApApp extends StatelessWidget {
  const PizzaApApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthScreen(),
      theme: ThemeData(
        primaryColor: AppColors.darkerRed,
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
