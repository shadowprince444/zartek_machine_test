import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/auth_controller.dart';
import 'package:zartek_machine_test/controllers/menu_controller.dart';
import 'package:zartek_machine_test/models/hive/order_model.dart';
import 'package:zartek_machine_test/models/menu_model.dart';
import 'package:zartek_machine_test/services/hive/hive_services.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/views/widgets/counter_widget.dart';

class DishItemWidget extends StatelessWidget {
  const DishItemWidget({
    Key? key,
    required this.dishIndex,
    required this.tableMenuItemIndex,
    required this.dish,
  }) : super(key: key);

  final CategoryDishes dish;
  final int tableMenuItemIndex;
  final int dishIndex;

  @override
  Widget build(BuildContext context) {
    final menuProviderController = Provider.of<MenuProviderController>(context, listen: false);
    return SizedBox(
      // height: 200.vdp(),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(
          8.vdp(),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24.hdp(),
              child: Container(
                padding: EdgeInsets.all(
                  6.vdp(),
                ),
                child: Image.asset(
                  dish.dishType == 2 ? "assets/images/veg_icon.png" : "assets/images/non_veg_icon.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.dishName,
                  style: AppTheme.textThemes.headline1,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 20.vdp(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "INR ${dish.dishPrice}",
                        style: AppTheme.textThemes.subtitle2.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        " ${dish.dishCalories} calories",
                        style: AppTheme.textThemes.subtitle2.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.vdp(),
                  ),
                  child: Text(
                    dish.dishDescription,
                    maxLines: 4,
                    style: AppTheme.textThemes.bodyText1.copyWith(
                      color: AppTheme.appColors.greyTextColor,
                    ),
                  ),
                ),
                // Consumer<MenuProviderController>(
                //   builder: (context,menuProviderController,_) {
                //     return
                ValueListenableBuilder<Box<OrderModel>>(
                    valueListenable: HiveService.getOrderBox().listenable(),
                    builder: (context, box, _) {
                      int count = 0;
                      final isOrderPresentInCart =
                          box.get(menuProviderController.selectedRestaurant?.restaurantId)?.orderListMap.where((element) => element.dishId == dish.dishId).isNotEmpty ?? false;
                      if (isOrderPresentInCart) {
                        count = box.get(menuProviderController.selectedRestaurant!.restaurantId)!.orderListMap.firstWhere((element) => element.dishId == dish.dishId).quantity;
                      }
                      return CounterWidget(
                        onTapAdd: () async {
                          final menuCategoryId = menuProviderController.availableRestaurantList
                              .where((element) => menuProviderController.selectedRestaurant!.restaurantId == element.restaurantId)
                              .first
                              .tableMenuList[tableMenuItemIndex]
                              .menuCategoryId;
                          await menuProviderController.onTapAdd(box, dish, menuCategoryId, Provider.of<Auth>(context, listen: false).userId);
                          // final orderBox = HiveService.getOrderBox();
                          // OrderModel? order = box.get(
                          //   menuProviderController.selectedRestaurant?.restaurantId ?? "",
                          // );
                          // if (order != null) {
                          //   var tempList = order.orderListMap.where((element) => element.dishId == dish.dishId);
                          //   DishOrderHiveModel? dishOrderModel = tempList.isNotEmpty ? tempList.first : null;
                          //   if (dishOrderModel != null) {
                          //     dishOrderModel.quantity++;
                          //     order.calculateTotalCost();
                          //   } else {
                          //     order.orderListMap.add(
                          //       dish.dishOrderHiveModelFromDishModel(),
                          //     );
                          //   }
                          // } else {
                          //   order = menuProviderController.buildOrder(Provider.of<Auth>(context, listen: false).userId, tableMenuItemIndex, dish.dishId);
                          //   box.put(menuProviderController.selectedRestaurant?.restaurantId ?? "dummyId", order!);
                          // }
                          // order?.save();
                        },
                        onTapRemove: () async {
                          await menuProviderController.onTapRemove(box, dish);
                          // OrderModel? order = box.get(
                          //   menuProviderController.selectedRestaurant?.restaurantId ?? "",
                          // );
                          // if (order != null) {
                          //   var tempList = order.orderListMap.where((element) => element.dishId == dish.dishId);
                          //   DishOrderHiveModel? dishOrderModel = tempList.isNotEmpty ? tempList.first : null;
                          //   if (dishOrderModel != null) {
                          //     if (dishOrderModel.quantity > 1) {
                          //       dishOrderModel.quantity--;
                          //     } else {
                          //       order.orderListMap.remove(dishOrderModel);
                          //     }
                          //     order.calculateTotalCost();
                          //   }
                          //   order?.save();
                          // }
                        },
                        count: count,
                        //   );
                        // }
                      );
                    }),
              ],
            )),
            SizedBox(
                width: 72.hdp(),
                height: 72.hdp(),
                child: Image.network(
                  dish.dishImage,
                  // loadingBuilder: () {},
                  errorBuilder: (context, e, _) => Icon(
                    Icons.broken_image,
                    color: AppTheme.appColors.darkGreyBottomSheet,
                    size: 62.vdp(),
                  ),
                )

                //     CachedNetworkImage(
                //   imageUrl: dish.dishImage,
                //   errorWidget: (context, url, error) => Icon(
                //     Icons.broken_image,
                //     color: AppTheme.appColors.darkGreyBottomSheet,
                //     size: 62.vdp(),
                //   ),
                //   progressIndicatorBuilder: (context, url, downloadProgress) {
                //     return CircularProgressIndicator(color: Colors.grey, value: downloadProgress.progress);
                //   },
                //   imageBuilder: (context, imageProvider) {
                //     return Container(
                //       width: 72.hdp(),
                //       height: 72.hdp(),
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //           image: imageProvider,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     );
                //   },
                // ),
                //
                )
          ],
        ),
      ),
    );
  }
}
