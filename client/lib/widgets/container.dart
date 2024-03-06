import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/ts.dart';
import '../utils/profile_data.dart';
import 'button_style.dart';

class AppWidgets {
  static Container getUnderbuttonText(String text, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.deepOrange,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 22),
          Text(
            text,
            style: TS.getOpenSans(12, FontWeight.w500, AppColors.white),
          )
        ],
      ),
    );
  }

  static Padding getProfileButtonsBlock(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyles.getOrangeOutlinedBox(24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бонусные баллы',
                  style: TS.getOpenSans(18, FontWeight.w600, AppColors.black),
                ),
                Text(
                  '${ProfileData.user.coins} ©',
                  style: TS.getOpenSans(18, FontWeight.w600, AppColors.black),
                ),
              ],
            ),
          ),
          AppWidgets.getUnderbuttonText('Собирайте и тратьте на бесплатную пиццу!', 370, 24),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addresses');
            },
            style: ButtonStyles.getOrangeOutlinedBox(24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Адреса доставки',
                  style: TS.getOpenSans(18, FontWeight.w600, AppColors.black),
                ),
                Image.asset('assets/icons/address.png',),
              ],
            ),
          ),
          AppWidgets.getUnderbuttonText('Нажмите, чтобы добавить адреса для доставки', 370, 24),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyles.getOrangeOutlinedBox(24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'История заказов',
                  style: TS.getOpenSans(18, FontWeight.w600, AppColors.black),
                ),
                Image.asset('assets/icons/history.png',),
              ],
            ),
          ),
          AppWidgets.getUnderbuttonText('История для повторного заказа', 370, 24),
        ],
      ),
    );
  }
}