import 'package:zartek_machine_test/models/hive/order_model.dart';

abstract class ILocalCart {
  Future addOrder(String restaurantId, OrderModel model) async {}

  // Future addDish(OrderModel model, CategoryDishes dish) async {}
  //
  // Future addQuantity(OrderModel model, String dishId) async {}

  Future removeOrder(String restaurantId) async {}

  // Future removeDish() async {}
  //
  // Future removeQuantity() async {}

  Future saveOrder(OrderModel order) async {}
}
