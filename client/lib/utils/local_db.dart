import 'package:client/utils/logs.dart';
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

  Future<bool> isAdded(int productId) async {
    final box = await _openBox();
    final orderItems = box.values.toList();
    return orderItems.any((item) => item.productId == productId);
  }

  Future<void> deleteAllOrderItems() async {
    final box = await _openBox();
    await box.clear();
  }

  Future<void> addOrderItem(OrderItem orderItem) async {
    final box = await _openBox();
    await box.add(orderItem);
  }

  Future<void> deleteOrderItem(int id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  Future<void> updateOrderItem(int id, OrderItem updatedOrderItem) async {
    final box = await _openBox();
    await box.put(id, updatedOrderItem);
  }
}