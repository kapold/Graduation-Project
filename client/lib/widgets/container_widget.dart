import 'package:client/widgets/text_style_widget.dart';
import 'package:flutter/material.dart';

import '../utils/profile_data.dart';
import 'button_style_widget.dart';

class AppWidgets {
  static Container getUnderbuttonText(String text, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.deepOrange,
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
            style: const TextStyle(color: Colors.white),
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
                  'Bonus coins',
                  style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 18),
                ),
                Text(
                  '${ProfileData.user.coins} ©',
                  style: TextStyles.getTextStyle('Poppins', FontWeight.w700, 18),
                ),
              ],
            ),
          ),
          AppWidgets.getUnderbuttonText('Collect and spend on free pizza!', 340, 24),
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
                  'Delivery addresses',
                  style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 18),
                ),
                Image.asset('assets/icons/address.png',),
              ],
            ),
          ),
          AppWidgets.getUnderbuttonText('Tap to add addresses to delivery.', 340, 24),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyles.getOrangeOutlinedBox(24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order history',
                  style: TextStyles.getTextStyle('Poppins', FontWeight.w500, 18),
                ),
                Image.asset('assets/icons/history.png',),
              ],
            ),
          ),
          AppWidgets.getUnderbuttonText('History for reorder your pizza.', 340, 24),
        ],
      ),
    );
  }
}