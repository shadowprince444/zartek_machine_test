import 'package:hive/hive.dart';
import 'package:zartek_machine_test/models/hive/add_on_hive_model.dart';

part 'dish_order_hive_model.g.dart';

@HiveType(typeId: 1)
class DishOrderHiveModel extends HiveObject {
  @HiveField(0)
  late String dishId;
  @HiveField(1)
  late String dishName;
  @HiveField(2)
  late String dishImageUrl;
  @HiveField(3)
  late int dishType;
  @HiveField(4)
  late double dishPrice;
  @HiveField(5)
  late double dishCalories;
  @HiveField(6)
  late List<AddOnHiveModel> addOns;

  @HiveField(7)
  late int quantity;
  @HiveField(8)
  late String menuCategoryId;

// Map<String, dynamic> toJson() {
//   return {
//     "dishId": dishId,
//     "dishName": dishName,
//     "dishImageUrl": dishImageUrl,
//     "dishType": dishType,
//     "dishPrice": dishPrice,
//     "dishCalories": dishCalories,
//     "addOns": addOns.map((e) => e.toJson()).toList(),
//   };
// }
// DishOrderHiveModel(this.);

// DishOrderHiveModel.fromJson(Map<String, dynamic> json) {
//   dishId = json['dishId'];
//   dishName = json['dishName'];
//   dishImageUrl = json['dishImageUrl'];
//   dishType = json['dishType'];
//   dishPrice = json['dishPrice'];
//   dishCalories = json['dishCalories'];
//   addOns = json['addOns'].map((e) => Addons.fromJson(e)).toList();
// }
}
