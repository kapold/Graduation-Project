import 'package:client/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Order {
  int id;
  int userId;
  String status;
  String paymentType;
  double totalPrice;
  DateTime createdAt;

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.paymentType,
    required this.totalPrice,
    required this.createdAt,
  });

  String get createdAtFormatted {
    final DateFormat formatter = DateFormat('dd.MM.yyyy, HH:mm');
    return formatter.format(createdAt);
  }

  String get statusFormatted {
    switch (status) {
      case 'processing':
        return 'Готовится';
      case 'completed':
        return 'Приготовлен';
      case 'cancelled':
        return 'Отменен';
      case 'in delivery':
        return 'В доставке';
      case 'deliveried':
        return 'Доставлен';
      default:
        return 'Неизвестный статус';
    }
  }

  String get paymentFormatted {
    switch (paymentType) {
      case 'in cash':
        return 'Наличными';
      case 'by card':
        return 'Картой';
      default:
        return 'Неизвестный тип оплаты';
    }
  }

  Color get statusColor {
    switch (status) {
      case 'processing':
        return AppColors.orange;
      case 'completed':
        return AppColors.green;
      case 'cancelled':
        return AppColors.red;
      case 'in delivery':
        return AppColors.deepOrange;
      case 'deliveried':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        userId: json['userId'],
        status: json['status'],
        paymentType: json['paymentType'],
        totalPrice: json['totalPrice'] is String ? double.parse(json['totalPrice']) : json['totalPrice'].toDouble(),
        createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'paymentType': paymentType,
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}