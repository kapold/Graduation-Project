import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_ap/blocs/menu/menu_event.dart';
import 'package:graduation_ap/models/product.dart';
import 'package:graduation_ap/utils/logs.dart';
import 'package:graduation_ap/utils/snacks.dart';
import 'package:graduation_ap/widgets/app_bar_style.dart';
import 'package:graduation_ap/widgets/input_decorations.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../blocs/menu/menu_bloc.dart';
import '../../../../blocs/menu/menu_state.dart';
import '../../../../styles/app_colors.dart';
import '../../../../styles/ts.dart';

class ChangeMenuItemScreen extends StatefulWidget {
  final MenuBloc menuBloc;
  final Product product;

  const ChangeMenuItemScreen({
    super.key,
    required this.menuBloc,
    required this.product,
  });

  @override
  State<ChangeMenuItemScreen> createState() => _ChangeMenuItemScreenState();
}

class _ChangeMenuItemScreenState extends State<ChangeMenuItemScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _caloriesController;
  late TextEditingController _proteinController;
  late TextEditingController _fatsController;
  late TextEditingController _carbohydratesController;
  late TextEditingController _weightController;
  late String _imageUrl = '';

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(text: widget.product.description);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _caloriesController = TextEditingController(text: widget.product.calories.toString());
    _proteinController = TextEditingController(text: widget.product.protein.toString());
    _fatsController = TextEditingController(text: widget.product.fats.toString());
    _carbohydratesController = TextEditingController(text: widget.product.carbohydrates.toString());
    _weightController = TextEditingController(text: widget.product.weight.toString());
    _imageUrl = widget.product.imageUrl;
    super.initState();
  }

  Future<void> _pickFile() async {
    final mediaData = await ImagePickerWeb.getImageInfo;
    if (mediaData != null) {
      String fileName = mediaData.fileName!;
      var fileBytes = mediaData.data;

      try {
        String filePath = 'images/$fileName';
        var ref = storage.ref().child(filePath);
        var uploadTask = ref.putData(fileBytes!);
        await uploadTask.whenComplete(() async {
          var url = await ref.getDownloadURL();
          setState(() {
            _imageUrl = url;
          });
          Logs.infoLog('Image URL: $_imageUrl');
        });
      } catch (e) {
        Logs.traceLog(e.toString());
      }
    }
  }

  void _changeProduct() {
    String name = _nameController.text,
        description = _descriptionController.text,
        price = _priceController.text,
        calories = _caloriesController.text,
        protein = _proteinController.text,
        fats = _fatsController.text,
        carbohydrates = _carbohydratesController.text,
        weight = _weightController.text;

    if (name.isEmpty ||
        description.isEmpty ||
        price.isEmpty ||
        calories.isEmpty ||
        protein.isEmpty ||
        fats.isEmpty ||
        carbohydrates.isEmpty ||
        weight.isEmpty ||
        _imageUrl.isEmpty) {
      Snacks.alert(context, 'Заполните всё!');
      return;
    }

    try {
      double priceNum = double.parse(price),
          caloriesNum = double.parse(calories),
          proteinNum = double.parse(protein),
          fatsNum = double.parse(fats),
          carbohydratesNum = double.parse(carbohydrates);
      int weightNum = int.parse(weight);

      widget.menuBloc.add(
        ChangeMenuItemEvent(
          Product(
            id: widget.product.id,
            name: name,
            description: description,
            price: priceNum,
            calories: caloriesNum,
            protein: proteinNum,
            carbohydrates: carbohydratesNum,
            fats: fatsNum,
            weight: weightNum,
            imageUrl: _imageUrl,
            isAvailable: widget.product.isAvailable,
          ),
        ),
      );
    } catch (e) {
      Snacks.alert(context, 'Введите числа правильно, через точку');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      bloc: widget.menuBloc,
      builder: (context, state) {
        if (state is ProcessState) {
          return Scaffold(
            appBar: AppBars.getCommonAppBar('Изменение продукта', context),
            body: Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: AppColors.deepOrange,
                size: 60,
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBars.getCommonAppBar('Изменение продукта', context),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 20),
            child: ListView(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecorations.getOrangeDecoration(
                    'Название',
                    'Введите название',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: InputDecorations.getOrangeDecoration(
                    'Состав',
                    'Введите состав',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  decoration: InputDecorations.getOrangeDecoration(
                    'Цена',
                    'Введите цену',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _caloriesController,
                  decoration: InputDecorations.getOrangeDecoration(
                    'Калории',
                    'Введите калории',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _proteinController,
                  decoration: InputDecorations.getOrangeDecoration(
                    'Белки',
                    'Введите белки',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _fatsController,
                  decoration: InputDecorations.getOrangeDecoration(
                    'Жиры',
                    'Введите жиры',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _carbohydratesController,
                  decoration: InputDecorations.getOrangeDecoration(
                      'Углеводы', 'Введите углеводы'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _weightController,
                  decoration: InputDecorations.getOrangeDecoration(
                    'Вес',
                    'Введите вес',
                  ),
                ),
                const SizedBox(height: 10),
                _imageUrl.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _pickFile();
                        },
                        child: Image.network(
                          _imageUrl,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _pickFile();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepOrange,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120, vertical: 20),
                          side: const BorderSide(
                              color: AppColors.deepOrange, width: 1),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          textStyle: TS.getPoppins(
                              20, FontWeight.w500, AppColors.black),
                        ),
                        child: Text(
                          'Выбрать изображение',
                          style: TS.getOpenSans(
                              20, FontWeight.w500, AppColors.white),
                        ),
                      ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    _changeProduct();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepOrange,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 20),
                    side:
                        const BorderSide(color: AppColors.deepOrange, width: 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    textStyle:
                        TS.getPoppins(20, FontWeight.w500, AppColors.black),
                  ),
                  child: Text(
                    'Изменить продукт',
                    style: TS.getOpenSans(20, FontWeight.w500, AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessfulChangedMenuItem) {
          Snacks.success(context, 'Продукт успешно изменен');
          widget.menuBloc.add(GetAllMenuEvent());
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _fatsController.dispose();
    _carbohydratesController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
