import 'package:client/features/cart/bloc/cart_bloc.dart';
import 'package:client/features/delivery_addresses/delivery_addresses_screen.dart';
import 'package:client/features/menu/bloc/menu_bloc.dart';
import 'package:client/features/order_history/order_history_screen.dart';
import 'package:client/features/orders/bloc/order_bloc.dart';
import 'package:client/features/settings/settings_screen.dart';
import 'package:client/features/welcome/welcome_screen.dart';
import 'package:client/repositories/user_repository.dart';
import 'package:client/styles/app_theme.dart';
import 'package:client/utils/local_db.dart';
import 'package:client/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/home_screen.dart';
import 'features/login/bloc/login_bloc.dart';
import 'features/login/login_screen.dart';
import 'features/settings/bloc/profile_bloc.dart';
import 'features/registration/bloc/registration_bloc.dart';
import 'features/registration/registration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalDb().init();
  ThemeData themeData = (await LocalStorage.getTheme() == 'light')
      ? AppTheme.getLightTheme()
      : AppTheme.getDarkTheme();

  String initialRoute = '/welcome';
  UserRepository.auth(await LocalStorage.getToken()).then((response) {
    if (response.statusCode == 200) {
      initialRoute = '/home';
    } else if (response.statusCode == 500) {
      LocalStorage.clearToken();
    }

    runApp(MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
      BlocProvider<RegistrationBloc>(create: (_) => RegistrationBloc()),
      BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),
      BlocProvider<MenuBloc>(create: (_) => MenuBloc()),
      BlocProvider<CartBloc>(create: (_) => CartBloc()),
      BlocProvider<OrderBloc>(create: (_) => OrderBloc()),
    ], child: PizzaApp(initialRoute, themeData)));
  }).onError((error, stackTrace) {
    runApp(MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
      BlocProvider<RegistrationBloc>(create: (_) => RegistrationBloc()),
      BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),
      BlocProvider<MenuBloc>(create: (_) => MenuBloc()),
      BlocProvider<CartBloc>(create: (_) => CartBloc()),
      BlocProvider<OrderBloc>(create: (_) => OrderBloc()),
    ], child: PizzaApp(initialRoute, themeData)));
  });
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
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
        '/addresses': (context) => const DeliveryAddressesScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/order-history': (context) => const OrderHistoryScreen(),
      },
      theme: themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
