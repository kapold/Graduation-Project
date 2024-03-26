import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/order_item.dart';

class LocalDb {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(OrderItemAdapter());
  }

  Future<Box<OrderItem>> _openBox() async {
    if (!Hive.isBoxOpen('order_items')) {
      await Hive.openBox<OrderItem>('order_items');
    }
    return Hive.box<OrderItem>('order_items');
  }

  Future<List<OrderItem>> getAllOrderItems() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> deleteAllOrderItems() async {
    final box = await _openBox();
    await box.clear();
  }

  Future<void> addOrderItem(OrderItem orderItem) async {
    final box = await _openBox();
    final orderItems = box.values.toList();

    final isAdded = orderItems.any((item) => item == orderItem);
    if (!isAdded) {
      await box.add(orderItem);
    }
  }

  Future<void> deleteOrderItem(OrderItem orderItem) async {
    final box = await _openBox();
    final existingOrderItems = box.values.toList();
    final index = existingOrderItems.indexWhere((item) => item.id == orderItem.id);

    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  Future<void> updateOrderItem(OrderItem updatedOrderItem) async {
    final box = await _openBox();
    final existingOrderItems = box.values.toList();
    final index = existingOrderItems.indexWhere((item) => item.id == updatedOrderItem.id);

    if (index != -1) {
      final existingOrderItem = existingOrderItems[index];
      existingOrderItem.quantity = updatedOrderItem.quantity;
      await box.putAt(index, existingOrderItem);
    }
  }
}