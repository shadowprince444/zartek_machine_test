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

  // AddOnHiveModel(
  //   this.quantity,
  //   this.dishId,
  //   this.addOnName,
  //   this.addOnType,
  //   this.addOnId,
  //   this.addOnCalories,
  //   this.addOnPrice,
  // );

  // Map<String, dynamic> toJson() {
  //   return {
  //     "addOnId": addOnId,
  //     "dishId": dishId,
  //     "addOnName": addOnName,
  //     "addOnCalories": addOnCalories,
  //     "addOnPrice": addOnPrice,
  //     "addOnType": addOnType,
  //     "quantity": quantity,
  //   };
  // }
  //
  // AddOnHiveModel.fromJson(Map<String, dynamic> json) {
  //   addOnId = json['addOnId'];
  //   dishId = json['dishId'];
  //   addOnName = json['addOnName'];
  //   addOnCalories = json['addOnCalories'];
  //   addOnPrice = json['addOnPrice'];
  //   addOnType = json['addOnType'];
  //   quantity = json['quantity'];
  // }
}
