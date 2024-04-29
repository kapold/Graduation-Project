// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderItemAdapter extends TypeAdapter<OrderItem> {
  @override
  final int typeId = 0;

  @override
  OrderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderItem(
      id: fields[0] as String,
      orderId: fields[1] as int?,
      productId: fields[2] as int,
      size: fields[3] as String,
      dough: fields[4] as String,
      toppings: (fields[5] as List).cast<String>(),
      removedCompositions: (fields[6] as List).cast<String>(),
      quantity: fields[7] as int,
      price: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, OrderItem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.productId)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.dough)
      ..writeByte(5)
      ..write(obj.toppings)
      ..writeByte(6)
      ..write(obj.removedCompositions)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
