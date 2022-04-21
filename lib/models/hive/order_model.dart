import 'package:hive/hive.dart';
import 'package:zartek_machine_test/models/hive/add_on_hive_model.dart';
import 'package:zartek_machine_test/models/hive/dish_order_hive_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 0)
class OrderModel extends HiveObject {
  @HiveField(0)
  late String restaurantId;

  @HiveField(1)
  late String restaurantName;

  @HiveField(2)
  late String restaurantBranch;

  @HiveField(3)
  late String userId;

  @HiveField(4)
  late DateTime orderingTime;

  @HiveField(5)
  late List<DishOrderHiveModel> orderListMap;

  @HiveField(6)
  late double totalPrice;

  calculateTotalCost() {
    totalPrice = 0;
    for (DishOrderHiveModel dish in orderListMap) {
      for (AddOnHiveModel addOn in dish.addOns) {
        totalPrice += addOn.addOnPrice;
      }
      totalPrice += dish.dishPrice * dish.quantity;
    }
    return totalPrice;
  }

  calculateTotalNumberOfItems() {
    int numberOfItems = 0;
    for (DishOrderHiveModel dish in orderListMap) {
      numberOfItems += dish.quantity;
    }
    return numberOfItems.floor();
  }

  getAddedDishCount() => orderListMap.length;
}
