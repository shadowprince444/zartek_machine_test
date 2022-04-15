import 'package:flutter/cupertino.dart';
import 'package:zartek_machine_test/models/menu_model.dart';
import 'package:zartek_machine_test/repository/restaurant_repo.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';

class MenuProviderController extends ChangeNotifier {
  final _restaurantRepo = RestaurantRepo();

  List<RestaurantMenuModel> availableRestaurantList = [];

  getAllRestaurantList() async {
    final response = await _restaurantRepo.getRestaurantMenu();
    if (response.status == ApiResponseStatus.completed) {
      availableRestaurantList = response.data ?? [];
      notifyListeners();
    }
  }
}
