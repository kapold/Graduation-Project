import 'package:client/features/cart/view/cart_screen.dart';
import 'package:client/features/menu/view/menu_screen.dart';
import 'package:client/features/profile/view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../orders/view/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    const MenuScreen(),
    const ProfileScreen(),
    const OrdersScreen(),
    const CartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            iconSize: 24,
            backgroundColor: Colors.white,
            activeColor: Colors.deepOrange,
            inactiveColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/menu_icon.png')),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/profile_icon.png')),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/orders_icon.png')),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/cart_icon.png')),
                label: 'Cart',
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
