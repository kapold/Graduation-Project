import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_ap/blocs/menu/menu_event.dart';
import 'package:graduation_ap/blocs/menu/menu_state.dart';
import 'package:graduation_ap/models/product.dart';
import 'package:graduation_ap/styles/ts.dart';
import 'package:graduation_ap/ui/admin_panel/screens/add_menu_item/menu_item_screen.dart';
import 'package:graduation_ap/ui/admin_panel/screens/change_menu_item/menu_item_screen.dart';
import 'package:graduation_ap/utils/snacks.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../blocs/menu/menu_bloc.dart';
import '../../../../blocs/orders/orders_bloc.dart';
import '../../../../styles/app_colors.dart';

class MenuScreen extends StatefulWidget {
  final MenuBloc menuBloc;
  final OrdersBloc ordersBloc;

  const MenuScreen({
    super.key,
    required this.menuBloc,
    required this.ordersBloc,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    widget.menuBloc.add(GetAllMenuEvent());
  }

  void _deleteProducts(int productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Подтверждение',
            style: TS.getOpenSans(20, FontWeight.w600, AppColors.black),
          ),
          content: Text(
            'Вы уверены, что хотите удалить этот продукт?',
            style: TS.getOpenSans(16, FontWeight.w500, AppColors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Отмена',
                style: TS.getOpenSans(14, FontWeight.w500, AppColors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Удалить',
                style: TS.getOpenSans(14, FontWeight.w500, AppColors.darkerRed),
              ),
              onPressed: () {
                widget.menuBloc.add(DeleteMenuItemEvent(productId));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getMenuItem(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                product.imageUrl,
                width: 150,
                height: 150,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: AppColors.deepOrange,
                        size: 60,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Icon(
                    Icons.broken_image_outlined,
                    color: Colors.deepOrange,
                    size: 60,
                  );
                },
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style:
                    TS.getOpenSans(20, FontWeight.w600, AppColors.black),
                  ),
                  SizedBox(
                    width: 600,
                    child: Text(
                      product.description,
                      style: TS.getOpenSans(
                          16, FontWeight.w500, AppColors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Tooltip(
                message: 'Изменить продукт',
                preferBelow: false,
                verticalOffset: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.update_outlined,
                    color: AppColors.deepOrange,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangeMenuItemScreen(menuBloc: widget.menuBloc, product: product,),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Tooltip(
                message: 'Удалить продукт',
                preferBelow: false,
                verticalOffset: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.delete_outline_outlined,
                    color: AppColors.darkerRed,
                  ),
                  onPressed: () {
                    _deleteProducts(product.id);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      bloc: widget.menuBloc,
      builder: (context, state) {
        if (state is SuccessfulLoadedMenu) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.products.length,
              itemExtent: 200,
              itemBuilder: (context, index) {
                return _getMenuItem(state.products[index]);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AddMenuItemScreen(menuBloc: widget.menuBloc),
                  ),
                );
              },
              backgroundColor: AppColors.deepOrange,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Tooltip(
                message: 'Добавить продукт',
                preferBelow: false,
                verticalOffset: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.deepOrange,
              size: 60,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      AddMenuItemScreen(menuBloc: widget.menuBloc),
                ),
              );
            },
            backgroundColor: AppColors.deepOrange,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Tooltip(
              message: 'Добавить продукт',
              preferBelow: false,
              verticalOffset: 40,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is FailedState) {
          Snacks.failed(context, 'Ошибка получения меню');
        }
        if (state is SuccessfulDeletedMenuItem) {
          widget.menuBloc.add(GetAllMenuEvent());
        }
      },
    );
  }
}
