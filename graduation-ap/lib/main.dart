import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_ap/firebase_options.dart';
import 'package:graduation_ap/styles/app_colors.dart';
import 'package:graduation_ap/ui/auth/auth_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:graduation_ap/utils/statics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.web,
    );
    Statics.baseUri = 'http://localhost:3000';
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
    Statics.baseUri = 'http://10.0.2.2:3000';
  }

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
