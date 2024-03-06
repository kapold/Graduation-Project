import 'package:client/features/menu_item/menu_item_screen.dart';
import 'package:client/models/product.dart';
import 'package:client/styles/app_colors.dart';
import 'package:client/styles/ts.dart';
import 'package:client/widgets/loader.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static Widget getMenuItem(BuildContext externalContext, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          externalContext,
          MaterialPageRoute(builder: (context) => MenuItemScreen(product: product)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
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
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240,
                  child: Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TS.getOpenSans(18, FontWeight.w600, AppColors.black),
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
                          builder: (context) => MenuItemScreen(product: product)),
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

  static Widget getItemScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [

        ],
      ),
    );
  }
}
