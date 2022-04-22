// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_order_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DishOrderHiveModelAdapter extends TypeAdapter<DishOrderHiveModel> {
  @override
  final int typeId = 1;

  @override
  DishOrderHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DishOrderHiveModel()
      ..dishId = fields[0] as String
      ..dishName = fields[1] as String
      ..dishImageUrl = fields[2] as String
      ..dishType = fields[3] as int
      ..dishPrice = fields[4] as double
      ..dishCalories = fields[5] as double
      ..addOns = (fields[6] as List).cast<AddOnHiveModel>()
      ..quantity = fields[7] as int
      ..menuCategoryId = fields[8] as String;
  }

  @override
  void write(BinaryWriter writer, DishOrderHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.dishId)
      ..writeByte(1)
      ..write(obj.dishName)
      ..writeByte(2)
      ..write(obj.dishImageUrl)
      ..writeByte(3)
      ..write(obj.dishType)
      ..writeByte(4)
      ..write(obj.dishPrice)
      ..writeByte(5)
      ..write(obj.dishCalories)
      ..writeByte(6)
      ..write(obj.addOns)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.menuCategoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishOrderHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
