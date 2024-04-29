import 'package:client/features/cart/bloc/cart_bloc.dart';
import 'package:client/features/menu_item/menu_item_screen.dart';
import 'package:client/models/composition.dart';
import 'package:client/models/product.dart';
import 'package:client/models/topping.dart';
import 'package:client/styles/app_colors.dart';
import 'package:client/styles/ts.dart';
import 'package:client/widgets/loader.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static Widget getMenuItem(BuildContext externalContext, Product product, CartBloc cartBloc) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          externalContext,
          MaterialPageRoute(builder: (context) => MenuItemScreen(product: product, cartBloc: cartBloc)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'productImage#${product.id}',
              child: Image.network(
                product.imageUrl,
                width: 140,
                height: 140,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Loaders.getAdaptiveLoader(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240,
                  child: Hero(
                    tag: 'productName#${product.id}',
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TS.getOpenSans(18, FontWeight.w600, AppColors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 240,
                  child: Text(
                    product.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TS.getOpenSans(14, FontWeight.w500, AppColors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      externalContext,
                      MaterialPageRoute(
                          builder: (context) => MenuItemScreen(product: product, cartBloc: cartBloc)),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.whiteOrange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'от ${product.price} руб.',
                      style: TS.getOpenSans(
                          16, FontWeight.w700, AppColors.deepOrange),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget getToppingItem(Topping topping) {
    if (topping.isSelected) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                topping.name,
                style: TS.getOpenSans(16, FontWeight.w500, AppColors.black),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteOrange,
                    ),
                    child: Text(
                      '${topping.price} р.',
                      style: TS.getOpenSans(14, FontWeight.w500, AppColors.deepOrange),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/icons/checked.png',
                    scale: 3,
                    color: AppColors.deepOrange,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                topping.name,
                style: TS.getOpenSans(16, FontWeight.w500, AppColors.black),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteOrange,
                    ),
                    child: Text(
                      '${topping.price} р.',
                      style: TS.getOpenSans(14, FontWeight.w500, AppColors.deepOrange),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/icons/unckecked.png',
                    scale: 3,
                    color: AppColors.grey,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  static Widget getCompositionItem(Composition composition) {
    if (composition.isSelected) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                composition.name.toLowerCase(),
                style: TS.getOpenSans(16, FontWeight.w500, AppColors.black),
              ),
              Image.asset(
                'assets/icons/remove.png',
                scale: 3,
                color: AppColors.deepOrange,
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                composition.name.toLowerCase(),
                style: TS.getOpenSans(16, FontWeight.w500, AppColors.black),
              ),
              Image.asset(
                'assets/icons/unckecked.png',
                scale: 3,
                color: AppColors.grey,
              ),
            ],
          ),
        ),
      );
    }
  }
}
