import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController searchController = TextEditingController();

  void onSearchSubmitted(String searchText) {

  }

  @override
  Widget build(BuildContext context) {
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
                      textController: searchController,
                      onSuffixTap: () {
                        setState(() {
                          searchController.clear();
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
  }
}
