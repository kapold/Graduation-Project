import 'package:client/features/login/login_feature.dart';
import 'package:client/features/registration/registration_feature.dart';
import 'package:client/features/welcome/view/welcome_screen.dart';
import 'package:client/styles/app_theme.dart';
import 'package:client/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  String initialRoute = '/home';
  ThemeData themeData = (await LocalStorage.getTheme() == 'light')
      ? AppTheme.getLightTheme()
      : AppTheme.getDarkTheme();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(create: (_) => LoginBloc())
    ],
    child: PizzaApp(initialRoute, themeData)
  ));
}

class PizzaApp extends StatelessWidget {
  final String initialRoute;
  final ThemeData themeData;

  const PizzaApp(this.initialRoute, this.themeData, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: initialRoute,
        routes: {
          '/home': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/registration': (context) => const RegistrationScreen()
        },
        theme: themeData,
        debugShowCheckedModeBanner: false
    );
  }
}
