import 'package:zartek_machine_test/interfaces/i_local_cart.dart';
import 'package:zartek_machine_test/models/hive/order_model.dart';
import 'package:zartek_machine_test/services/hive/hive_services.dart';

class LocalCartRepo implements ILocalCart {
  final _orderModelBox = HiveService.getOrderBox();

  // @override
  // Future<bool> addDish(OrderModel model, CategoryDishes dish) async {
  //   try {
  //     model.orderListMap.add(
  //       dish.dishOrderHiveModelFromDishModel(),
  //     );
  //     await model.save();
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  @override
  Future addOrder(String restaurantId, OrderModel model) async {
    try {
      _orderModelBox.put(restaurantId, model);
    } catch (e) {
      print(e);
    }
  }

  // @override
  // Future<bool> addQuantity(OrderModel model, String dishId) async {
  //   try {
  //     model.orderListMap.firstWhere((element) => element.dishId == dishId).quantity++;
  //     await model.save();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // @override
  // Future removeDish() {
  //   // TODO: implement removeDish
  //   throw UnimplementedError();
  // }

  @override
  Future<bool> removeOrder(String restaurantId) async {
    try {
      await _orderModelBox.delete(restaurantId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future saveOrder(OrderModel order) async {
    order.save();
  }

// @override
// Future removeQuantity() {
//   // TODO: implement removeQuantity
//   throw UnimplementedError();
// }
}
