import 'package:client/models/topping.dart';
import 'package:client/styles/app_colors.dart';
import 'package:client/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../models/product.dart';
import '../../styles/ts.dart';
import '../../widgets/app_bar_style.dart';
import '../../widgets/menu_item.dart';

class MenuItemScreen extends StatefulWidget {
  final Product product;

  const MenuItemScreen({Key? key, required this.product}) : super(key: key);

  @override
  _MenuItemScreenState createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  late Product _productInfo;
  late String _confInfo = '';
  final List<String> _pizzaSizes = ['Маленькая', 'Средняя', 'Большая'];
  final List<String> _doughSizes = ['Традиционное', 'Тонкое'];
  final List<Topping> _toppings = [
    Topping(id: 1, name: 'Сырный бортик', price: 5.49),
    Topping(id: 2, name: 'Моцарелла', price: 3.49),
    Topping(id: 3, name: 'Цыпленок', price: 2.99),
    Topping(id: 4, name: 'Ветчина', price: 2.99),
    Topping(id: 5, name: 'Шампиньоны', price: 2.49),
    Topping(id: 6, name: 'Томаты', price: 2.99),
    Topping(id: 7, name: 'Брынза', price: 2.99),
    Topping(id: 8, name: 'Ананасы', price: 2.99),
    Topping(id: 9, name: 'Бекон', price: 3.49),
  ];
  int _pizzaSizeIndex = 0, _doughSizeIndex = 0;

  @override
  void initState() {
    super.initState();
    _productInfo = Product(
      id: widget.product.id,
      name: widget.product.name,
      imageUrl: widget.product.imageUrl,
      description: widget.product.description,
      calories: widget.product.calories,
      protein: widget.product.protein,
      fats: widget.product.fats,
      carbohydrates: widget.product.carbohydrates,
      weight: widget.product.weight,
      price: widget.product.price,
      isAvailable: widget.product.isAvailable,
    );
    _confInfo = 'Маленькая 25 см, традиционное тесто, ${_productInfo.weight} г';
  }

  void _addToCart() {
    Navigator.pop(context);
  }

  void _updatePageInfo() {
    _productInfo.price = widget.product.price;

    String size = _pizzaSizes[_pizzaSizeIndex];
    String dough = _doughSizes[_doughSizeIndex];
    String sizeNumber = '';
    if (size == 'Маленькая') {
      _productInfo.price = widget.product.price;
      _productInfo.weight = widget.product.weight;
    }
    else if (size == 'Средняя') {
      _productInfo.price = widget.product.price + 9.00;
      _productInfo.weight = widget.product.weight + 200;
    }
    else if (size == 'Большая') {
      _productInfo.price = widget.product.price + 15.00;
      _productInfo.weight = widget.product.weight + 400;
    }

    switch (size) {
      case 'Маленькая':
        sizeNumber = '25 см';
        break;
      case 'Средняя':
        sizeNumber = '30 см';
        break;
      case 'Большая':
        sizeNumber = '35 см';
        break;
    }

    for(var topping in _toppings) {
      if (topping.isSelected) {
        _productInfo.price = _productInfo.price + topping.price;
      }
    }

    _confInfo = '$size $sizeNumber, $dough тесто, ${_productInfo.weight} г';
    Logs.infoLog(_productInfo.toString());
    setState(() {});
  }

  void _showAdditionalInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TS.getOpenSans(22, FontWeight.w600, AppColors.black),
                ),
                Text(
                  'Пищевая ценность (на 100г)',
                  style: TS.getOpenSans(14, FontWeight.w500, AppColors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Калории',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    ),
                    Text(
                      '${widget.product.calories} ккал',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Белки',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    ),
                    Text(
                      '${widget.product.protein} г',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Жиры',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    ),
                    Text(
                      '${widget.product.fats} г',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Углеводы',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    ),
                    Text(
                      '${widget.product.carbohydrates} г',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Вес',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    ),
                    Text(
                      '${_productInfo.weight} г',
                      style:
                          TS.getOpenSans(14, FontWeight.w500, AppColors.black),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectTopping(Topping topping) {
    topping.isSelected = !topping.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.getCommonAppBar(widget.product.name, context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Image.network(widget.product.imageUrl),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: TS.getOpenSans(
                                24, FontWeight.w700, AppColors.black),
                          ),
                          IconButton(
                            onPressed: _showAdditionalInfo,
                            icon: const Icon(Icons.info_outline_rounded),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 500,
                        child: Text(
                          _confInfo,
                          style: TS.getOpenSans(
                              16, FontWeight.w600, AppColors.grey),
                        ),
                      ),
                      Text(
                        widget.product.description,
                        style: TS.getOpenSans(
                            16, FontWeight.w500, AppColors.black),
                      ),
                      const SizedBox(height: 20),
                      ToggleSwitch(
                        minWidth: MediaQuery.of(context).size.width - 322,
                        activeBgColor: const [AppColors.deepOrange],
                        initialLabelIndex: _pizzaSizeIndex,
                        totalSwitches: _pizzaSizes.length,
                        labels: _pizzaSizes,
                        onToggle: (index) {
                          _pizzaSizeIndex = index!;
                          _updatePageInfo();
                        },
                      ),
                      const SizedBox(height: 8),
                      ToggleSwitch(
                        minWidth: MediaQuery.of(context).size.width - 258,
                        activeBgColor: const [AppColors.deepOrange],
                        initialLabelIndex: _doughSizeIndex,
                        totalSwitches: _doughSizes.length,
                        labels: _doughSizes,
                        onToggle: (index) {
                          _doughSizeIndex = index!;
                          _updatePageInfo();
                        },
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _toppings.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _selectTopping(_toppings[index]);
                              _updatePageInfo();
                            },
                            child: MenuItems.getToppingItem(_toppings[index]),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ElevatedButton(
                onPressed: _addToCart,
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.deepOrange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                ),
                child: Text(
                  'Добавить за ${_productInfo.price.toStringAsFixed(2)} руб.',
                  style: TS.getOpenSans(20, FontWeight.w600, AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
