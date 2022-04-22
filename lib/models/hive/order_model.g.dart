// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 0;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel()
      ..restaurantId = fields[0] as String
      ..restaurantName = fields[1] as String
      ..restaurantBranch = fields[2] as String
      ..userId = fields[3] as String
      ..orderingTime = fields[4] as DateTime
      ..orderListMap = (fields[5] as List).cast<DishOrderHiveModel>()
      ..totalPrice = fields[6] as double;
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.restaurantId)
      ..writeByte(1)
      ..write(obj.restaurantName)
      ..writeByte(2)
      ..write(obj.restaurantBranch)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.orderingTime)
      ..writeByte(5)
      ..write(obj.orderListMap)
      ..writeByte(6)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
