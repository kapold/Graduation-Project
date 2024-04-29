import 'package:flutter/material.dart';
import 'package:graduation_ap/styles/app_colors.dart';
import 'package:graduation_ap/styles/ts.dart';
import 'package:graduation_ap/ui/admin_panel/screens/menu/menu_screen.dart';
import 'package:graduation_ap/ui/admin_panel/screens/orders/orders_screen.dart';

import '../../blocs/menu/menu_bloc.dart';
import '../../blocs/orders/orders_bloc.dart';
import '../auth/auth_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen>
    with SingleTickerProviderStateMixin {
  final _menuBloc = MenuBloc();
  final _ordersBloc = OrdersBloc();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Админ панель',
          style: TS.getOpenSans(20, FontWeight.w500, AppColors.black),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.orange,
          labelColor: AppColors.deepOrange,
          labelStyle: TS.getOpenSans(16, FontWeight.w600, AppColors.deepOrange),
          tabs: const [
            Tab(text: 'Редактор меню'),
            Tab(text: 'Список заказов'),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_outlined,
              color: AppColors.darkerRed,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const AuthScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            tooltip: 'Выйти',
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MenuScreen(menuBloc: _menuBloc, ordersBloc: _ordersBloc),
          OrdersScreen(menuBloc: _menuBloc, ordersBloc: _ordersBloc),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
