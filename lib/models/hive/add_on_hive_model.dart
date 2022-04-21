import 'package:hive/hive.dart';

part 'add_on_hive_model.g.dart';

@HiveType(typeId: 2)
class AddOnHiveModel extends HiveObject {
  @HiveField(0)
  late String addOnId;
  @HiveField(1)
  late String dishId;
  @HiveField(2)
  late String addOnName;
  @HiveField(3)
  late double addOnCalories;
  @HiveField(4)
  late double addOnPrice;
  @HiveField(5)
  late int addOnType;
  @HiveField(6)
  late int quantity;
}
