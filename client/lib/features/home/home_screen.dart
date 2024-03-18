import 'package:client/features/cart/cart_screen.dart';
import 'package:client/features/menu/menu_screen.dart';
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

  @override
  void initState() {
    super.initState();
    _getUserData();
    pages = [
      MenuScreen(context),
      ProfileScreen(context),
      OrdersScreen(context),
      const CartScreen()
    ];
  }

  Future<void> _getUserData() async {
    String token = await LocalStorage.getToken();
    Response<dynamic> parsedToken = await UserRepository.auth(token);
    ProfileData.user = await UserRepository.getUserById(parsedToken.data['user_id']);
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
                icon: ImageIcon(AssetImage('assets/icons/menu_icon.png')),
                label: 'Меню',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/profile_icon.png')),
                label: 'Профиль',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/orders_icon.png')),
                label: 'Заказы',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/cart_icon.png')),
                label: 'Корзина',
              )
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
