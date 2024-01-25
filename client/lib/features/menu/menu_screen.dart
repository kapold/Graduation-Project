import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:client/features/menu/bloc/menu_bloc.dart';
import 'package:client/features/menu/bloc/menu_event.dart';
import 'package:client/features/menu/bloc/menu_state.dart';
import 'package:client/models/product.dart';
import 'package:client/utils/logs.dart';
import 'package:client/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen(this.externalContext, {super.key});

  BuildContext externalContext;

  @override
  State<MenuScreen> createState() => _MenuScreenState(externalContext);
}

class _MenuScreenState extends State<MenuScreen> {
  _MenuScreenState(this.externalContext);
  BuildContext externalContext;

  final MenuBloc _menuBloc = MenuBloc();
  List<Product> _menuProducts = [];
  final TextEditingController _searchController = TextEditingController();

  void onSearchSubmitted(String searchText) {
    Logs.infoLog('onSearchSubmitted: $searchText');
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
                  child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: AnimSearchBar(
                              width: 400,
                              rtl: true,
                              boxShadow: false,
                              textController: _searchController,
                              onSuffixTap: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                              onSubmitted: (value) => onSearchSubmitted(value),
                            )
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                            child: Center(
                                child: Loaders.getDotsTriangle()
                            )
                        )
                      ]
                  )
              )
          );
        }
        if (state is SuccessfulLoadedState) {
          return Scaffold(
              body: SafeArea(
                  child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: AnimSearchBar(
                              width: 400,
                              rtl: true,
                              boxShadow: false,
                              textController: _searchController,
                              onSuffixTap: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                              onSubmitted: (value) => onSearchSubmitted(value),
                            )
                        ),
                        _menuProducts.isEmpty
                          ? const Expanded(child: Center(child: Text('No products in menu')))
                          : Expanded(
                              child: ListView.builder(
                                itemBuilder: (c, i) => Card(child: Center(child: Text(_menuProducts[i].name))),
                                itemExtent: 100.0,
                                itemCount: _menuProducts.length,
                              )
                          )
                      ]
                  )
              )
          );
        }
        if (state is FailedLoadedState) {
          return Scaffold(
              body: SafeArea(
                  child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: AnimSearchBar(
                              width: 400,
                              rtl: true,
                              boxShadow: false,
                              textController: _searchController,
                              onSuffixTap: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                              onSubmitted: (value) => onSearchSubmitted(value),
                            )
                        ),
                        const SizedBox(height: 10),
                        const Expanded(
                            child: Center(
                                child: Text('Failed to load menu')
                            )
                        )
                      ]
                  )
              )
          );
        }
        return Scaffold(
            body: SafeArea(
                child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AnimSearchBar(
                            width: 400,
                            rtl: true,
                            boxShadow: false,
                            textController: _searchController,
                            onSuffixTap: () {
                              setState(() {
                                _searchController.clear();
                              });
                            },
                            onSubmitted: (value) => onSearchSubmitted(value),
                          )
                      ),
                      const SizedBox(height: 10),
                      const Expanded(
                          child: Center(
                              child: Text('No products in menu')
                          )
                      )
                    ]
                )
            )
        );
      },
      listener: (context, state) {
        if (state is SuccessfulLoadedState) {
          _menuProducts = state.products;
        }
      },
    );
  }
}
