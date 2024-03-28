import 'package:client/features/cart/bloc/cart_bloc.dart';
import 'package:client/features/cart/cart_screen.dart';
import 'package:client/features/menu/menu_screen.dart';
import 'package:client/features/orders/bloc/order_bloc.dart';
import 'package:client/features/profile/profile_screen.dart';
import 'package:client/repositories/user_repository.dart';
import 'package:client/utils/local_storage.dart';
import 'package:client/utils/profile_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../orders/orders_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> pages;
  final CartBloc cartBloc = CartBloc();
  final OrderBloc orderBloc = OrderBloc();

  @override
  void initState() {
    super.initState();
    _getUserData();
    pages = [
      MenuScreen(context, cartBloc),
      ProfileScreen(context),
      OrdersScreen(context, orderBloc),
      CartScreen(context, cartBloc, orderBloc),
    ];
  }

  Future<void> _getUserData() async {
    String token = await LocalStorage.getToken();
    Response<dynamic> parsedToken = await UserRepository.auth(token);
    AppData.user = await UserRepository.getUserById(parsedToken.data['user_id']);

    // List<OrderItem> cartItems = await LocalDb().getAllOrderItems();
    // Logs.infoLog('All Order Items:');
    // for(var item in cartItems) {
    //   Logs.infoLog('Item: ${item.toString()}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            iconSize: 30,
            height: 60,
            backgroundColor: AppColors.white,
            activeColor: AppColors.deepOrange,
            inactiveColor: AppColors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/menu-icon.png')),
                label: 'Меню',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/profile-icon.png')),
                label: 'Профиль',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/orders-icon.png')),
                label: 'Заказы',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/cart-icon.png')),
                label: 'Корзина',
              ),
            ]
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (context) {
                return pages[index];
              }
            );
          }
        )
    );
  }
}
