import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:zartek_machine_test/models/hive/add_on_hive_model.dart';
import 'package:zartek_machine_test/models/hive/dish_order_hive_model.dart';
import 'package:zartek_machine_test/models/hive/order_model.dart';
import 'package:zartek_machine_test/models/menu_model.dart';
import 'package:zartek_machine_test/models/restaurant_drop_down_model.dart';
import 'package:zartek_machine_test/repository/local_cart_repo.dart';
import 'package:zartek_machine_test/repository/restaurant_repo.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';

class MenuProviderController extends ChangeNotifier {
  final _restaurantRepo = RestaurantRepo();
  final _localCartRepo = LocalCartRepo();

  List<RestaurantMenuModel> availableRestaurantList = [];
  RestaurantDropDownModel? selectedRestaurant;
  int selectedTableMenuIndex = -1;

  onRestaurantSelected(RestaurantDropDownModel model) {
    if (selectedRestaurant?.restaurantId != model.restaurantId) {
      selectedRestaurant = model;
      notifyListeners();
    }
  }

  OrderModel buildOrder(String userId, String menuCategoryId, String dishId) {
    return OrderModel()
      ..restaurantId = selectedRestaurant!.restaurantId
      ..restaurantName = selectedRestaurant!.restaurantName
      ..userId = userId
      ..orderingTime = DateTime.now()
      ..restaurantBranch = selectedRestaurant!.restaurantName
      ..orderListMap = [
        getDishByDishIdAndCategoryIndex(
          menuCategoryId,
          dishId,
        ).dishOrderHiveModelFromDishModel(
          availableRestaurantList
              .where(
                (element) => element.restaurantId == selectedRestaurant!.restaurantId,
              )
              .first
              .tableMenuList
              .firstWhere((element) => menuCategoryId == element.menuCategoryId)
              .menuCategoryId,
        ),
      ]
      ..totalPrice = getDishByDishIdAndCategoryIndex(menuCategoryId, dishId).dishPrice ?? 0.0;
  }

  CategoryDishes getDishByDishIdAndCategoryIndex(String menuCategoryId, String dishId) => availableRestaurantList
      .firstWhere((element) => element.restaurantId == selectedRestaurant!.restaurantId)
      .tableMenuList
      .firstWhere((element) => element.menuCategoryId == menuCategoryId)
      .categoryDishes
      .firstWhere((element) => element.dishId == dishId);

  onTabSelected(int index) {
    if (selectedTableMenuIndex != index) {
      selectedTableMenuIndex = index;
      notifyListeners();
    }
  }

  RestaurantMenuModel getSelectedRestaurantMenuModel() {
    return availableRestaurantList.firstWhere((element) => element.restaurantId == selectedRestaurant?.restaurantId);
  }

  getAllRestaurantList() async {
    final response = await _restaurantRepo.getRestaurantMenu();
    if (response.status == ApiResponseStatus.completed) {
      availableRestaurantList = response.data ?? [];
      selectedRestaurant = availableRestaurantList.isNotEmpty
          ? RestaurantDropDownModel(
              restaurantId: availableRestaurantList.first.restaurantId,
              restaurantName: availableRestaurantList.first.restaurantName,
            )
          : null;
      notifyListeners();
    }
  }

  // Local Cart Methods

  onTapAdd(Box<OrderModel> box, CategoryDishes dish, String menuCategoryId, String userId) async {
    OrderModel? order = box.get(
      selectedRestaurant?.restaurantId ?? "",
    );
    if (order != null) {
      var tempList = order.orderListMap.where((element) => element.dishId == dish.dishId);
      DishOrderHiveModel? dishOrderModel = tempList.isNotEmpty ? tempList.first : null;
      if (dishOrderModel != null) {
        await addDishQuantity(order, dishOrderModel);
      } else {
        await addDish(
            order,
            dish,
            availableRestaurantList
                .where((element) => element.restaurantId == selectedRestaurant!.restaurantId)
                .first
                .tableMenuList
                .firstWhere((element) => element.menuCategoryId == menuCategoryId)
                .menuCategoryId);
      }
    } else {
      await addOrderModel(
        dish.dishId,
        menuCategoryId,
        userId,
      );
    }
    box.get(selectedRestaurant?.restaurantId ?? "")!.calculateTotalCost();
  }

  onTapRemove(Box<OrderModel> box, CategoryDishes dish) async {
    OrderModel? order = box.get(
      selectedRestaurant?.restaurantId ?? "",
    );
    if (order != null) {
      var tempList = order.orderListMap.where((element) => element.dishId == dish.dishId);
      DishOrderHiveModel? dishOrderModel = tempList.isNotEmpty ? tempList.first : null;
      if (dishOrderModel != null) {
        await removeDishQuantity(order, dishOrderModel.dishId);
        order.calculateTotalCost();
      } else {
        return;
      }
    }
    return;
  }

  Future addOrderModel(String dishId, String menuCategoryId, String userId) async {
    await _localCartRepo.addOrder(selectedRestaurant?.restaurantId ?? "", buildOrder(userId, menuCategoryId, dishId));
  }

  Future addDish(OrderModel model, CategoryDishes dish, String menuCategoryId) async {
    model.orderListMap.add(dish.dishOrderHiveModelFromDishModel(menuCategoryId));
    model.calculateTotalCost();
    await model.save();
  }

  Future addAddOn(OrderModel model, String dishId, Addons addOn) async {
    var addOnHiveModel = AddOnHiveModel()
      ..dishId = addOn.dishId
      ..addOnPrice = addOn.dishPrice
      ..addOnCalories = addOn.dishCalories
      ..addOnId = addOn.dishId
      ..addOnType = addOn.dishType
      ..addOnName = addOn.dishName
      ..quantity = 1;
    model.orderListMap.firstWhere((element) => element.dishId == dishId).addOns.add(addOnHiveModel);
    model.calculateTotalCost();

    await model.save();
  }

  Future removeAddOn(OrderModel model, String dishId, String addOnId) async {
    model.orderListMap.firstWhere((element) => dishId == element.dishId).addOns.removeWhere((element) => element.dishId == addOnId);
    model.calculateTotalCost();

    await model.save();
  }

  Future addDishQuantity(OrderModel model, DishOrderHiveModel dish) async {
    dish.quantity++;
    model.calculateTotalCost();
    await model.save();
  }

  Future removeDish(OrderModel model, DishOrderHiveModel dish) async {
    model.orderListMap.remove(dish);
    if (model.orderListMap.isEmpty) {
      removeOrder(model);
    } else {
      model.calculateTotalCost();
      await model.save();
    }
  }

  Future removeOrder(OrderModel model) async {
    await model.delete();
  }

  Future removeDishQuantity(OrderModel model, String dishId) async {
    var dish = model.orderListMap.firstWhere((element) => element.dishId == dishId);
    dish.quantity--;
    if (dish.quantity == 0) {
      await removeDish(model, dish);
    } else {
      model.calculateTotalCost();
      await model.save();
    }
  }
}
