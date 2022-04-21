import 'package:zartek_machine_test/interfaces/i_restaurant.dart';
import 'package:zartek_machine_test/models/api_response_model.dart';
import 'package:zartek_machine_test/models/menu_model.dart';
import 'package:zartek_machine_test/services/dio_client/dio_client.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/constants.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';

class RestaurantRepo implements IRestaurant {
  final _dioClient = DioClient();

  @override
  Future<ApiResponse<List<RestaurantMenuModel>>> getRestaurantMenu() async {
    try {
      final res = await _dioClient.request(
        uri: Uri.parse(ApiUrls.getRestaurantMenuListURI),
        method: APIMethod.get,
      );
      var tempList = <RestaurantMenuModel>[];
      for (Map<String, dynamic> restaurantData in res.data) {
        tempList.add(RestaurantMenuModel.fromJson(restaurantData));
      }
      return ApiResponse<List<RestaurantMenuModel>>.completed(tempList);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
