import 'package:client/features/cart/bloc/cart_bloc.dart';
import 'package:client/features/menu/bloc/menu_bloc.dart';
import 'package:client/features/menu/bloc/menu_event.dart';
import 'package:client/features/menu/bloc/menu_state.dart';
import 'package:client/models/product.dart';
import 'package:client/styles/app_colors.dart';
import 'package:client/utils/logs.dart';
import 'package:client/utils/profile_data.dart';
import 'package:client/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/ts.dart';
import '../../widgets/loader.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen(this.externalContext, this.cartBloc, {super.key});

  BuildContext externalContext;
  CartBloc cartBloc;

  @override
  State<MenuScreen> createState() =>
      _MenuScreenState(externalContext, cartBloc);
}

class _MenuScreenState extends State<MenuScreen> {
  _MenuScreenState(this.externalContext, this.cartBloc);

  BuildContext externalContext;
  CartBloc cartBloc;

  final MenuBloc _menuBloc = MenuBloc();
  List<Product> _menuProducts = [], _searchList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      _menuBloc.add(SearchProductsEvent(_menuProducts, _searchController.text));
    } else {
      _menuBloc.add(GetMenuEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      bloc: _menuBloc,
      builder: (context, state) {
        if (state is LoadingMenuState) {
          _menuBloc.add(GetMenuEvent());
          return Scaffold(
            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _searchController,
                          style: TS.getOpenSans(
                              18, FontWeight.w500, AppColors.black),
                          cursorColor: AppColors.deepOrange,
                          decoration: const InputDecoration(
                            hintText: 'Поиск',
                            prefixIcon:
                                Icon(Icons.search, color: AppColors.deepOrange),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.deepOrange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.deepOrange, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 300),
                      Loaders.getDotsTriangle(60)
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (state is SuccessfulLoadedState || state is SearchResultState) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _searchController,
                      style:
                          TS.getOpenSans(18, FontWeight.w500, AppColors.black),
                      cursorColor: AppColors.deepOrange,
                      decoration: const InputDecoration(
                        hintText: 'Поиск',
                        prefixIcon:
                            Icon(Icons.search, color: AppColors.deepOrange),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.deepOrange),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.deepOrange, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  _searchList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _searchList.length,
                            itemExtent: 180,
                            itemBuilder: (context, index) {
                              return MenuItems.getMenuItem(externalContext,
                                  _searchList[index], cartBloc);
                            },
                          ),
                        )
                      : Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/no-search-found.png',
                                scale: 4,
                                color: AppColors.deepOrange,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Пицца не найдена',
                                style: TS.getOpenSans(24, FontWeight.w500,
                                    AppColors.black),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        }
        if (state is FailedLoadedState) {
          return Scaffold(
            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _searchController,
                          style: TS.getOpenSans(
                              18, FontWeight.w500, AppColors.black),
                          cursorColor: AppColors.deepOrange,
                          decoration: const InputDecoration(
                            hintText: 'Поиск',
                            prefixIcon:
                                Icon(Icons.search, color: AppColors.deepOrange),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.deepOrange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.deepOrange, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Ошибка загрузки меню')
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _searchController,
                          style: TS.getOpenSans(
                              18, FontWeight.w500, AppColors.black),
                          cursorColor: AppColors.deepOrange,
                          decoration: const InputDecoration(
                            hintText: 'Поиск',
                            prefixIcon:
                                Icon(Icons.search, color: AppColors.deepOrange),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.deepOrange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.deepOrange, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: _searchList.length,
                          itemExtent: 300,
                          itemBuilder: (context, index) {
                            return Text('$index');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is SuccessfulLoadedState) {
          _menuProducts = state.products;
          _searchList = state.products;

          AppData.products = state.products;
        } else if (state is SearchResultState) {
          _searchList = state.products;
        } else if (state is FailedLoadedState) {
          Logs.warningLog("FailedLoadedState", state.errorMessage);
        }
      },
    );
  }
}
