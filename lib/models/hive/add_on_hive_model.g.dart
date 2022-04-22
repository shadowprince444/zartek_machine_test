// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_on_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddOnHiveModelAdapter extends TypeAdapter<AddOnHiveModel> {
  @override
  final int typeId = 2;

  @override
  AddOnHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddOnHiveModel()
      ..addOnId = fields[0] as String
      ..dishId = fields[1] as String
      ..addOnName = fields[2] as String
      ..addOnCalories = fields[3] as double
      ..addOnPrice = fields[4] as double
      ..addOnType = fields[5] as int
      ..quantity = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, AddOnHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.addOnId)
      ..writeByte(1)
      ..write(obj.dishId)
      ..writeByte(2)
      ..write(obj.addOnName)
      ..writeByte(3)
      ..write(obj.addOnCalories)
      ..writeByte(4)
      ..write(obj.addOnPrice)
      ..writeByte(5)
      ..write(obj.addOnType)
      ..writeByte(6)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddOnHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
