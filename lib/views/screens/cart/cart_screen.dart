import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/auth_controller.dart';
import 'package:zartek_machine_test/controllers/menu_controller.dart';
import 'package:zartek_machine_test/models/hive/dish_order_hive_model.dart';
import 'package:zartek_machine_test/models/hive/order_model.dart';
import 'package:zartek_machine_test/models/menu_model.dart';
import 'package:zartek_machine_test/services/hive/hive_services.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/responsive_safe_area.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
import 'package:zartek_machine_test/views/widgets/app_custom_button.dart';
import 'package:zartek_machine_test/views/widgets/counter_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuController = Provider.of<MenuProviderController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Summary",
          style: AppTheme.textThemes.headline2.copyWith(color: AppTheme.appColors.greyTextColor),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: AppTheme.appColors.appPrimaryColorWhite,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppTheme.appColors.appPrimaryColorWhite,
        ),
        child: ResponsiveSafeArea(
          builder: (context, size) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.hdp(),
            ),
            child: ValueListenableBuilder<Box<OrderModel>>(
              valueListenable: HiveService.getOrderBox().listenable(),
              builder: (context, box, _) {
                int count = 0;

                final isOrderPresentInCart = box.get(menuController.selectedRestaurant?.restaurantId)?.orderListMap.isNotEmpty ?? false;
                if (isOrderPresentInCart) {
                  var orderModel = box.get(menuController.selectedRestaurant!.restaurantId);
                  count = orderModel!.getAddedDishCount();

                  return Column(
                    children: [
                      const VSpace(32),
                      Expanded(
                          child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          6.vdp(),
                        )),
                        elevation: 8.vdp(),
                        child: Padding(
                          padding: EdgeInsets.all(
                            4.vdp(),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    8.vdp(),
                                  ),
                                  color: AppTheme.appColors.appPrimaryColorGreen,
                                ),
                                height: 56.vdp(),
                                child: Center(
                                  child: Text(
                                    "$count Dishes - ${orderModel.calculateTotalNumberOfItems()} Items",
                                    style: AppTheme.textThemes.headline2.copyWith(
                                      color: AppTheme.appColors.appPrimaryColorWhite,
                                    ),
                                  ),
                                ),
                              ),
                              const VSpace(4),
                              Expanded(
                                  child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: orderModel.orderListMap.length,
                                        itemBuilder: (context, index) {
                                          var dish = orderModel.orderListMap[index];
                                          return SizedBox(
                                            // height: 200.vdp(),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 16.vdp()),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          dish.dishName,
                                                          style: AppTheme.textThemes.headline1,
                                                          maxLines: 4,
                                                        ),
                                                        const VSpace(8),
                                                        Text(
                                                          "INR ${dish.dishPrice}",
                                                          style: AppTheme.textThemes.bodyText1.copyWith(fontWeight: FontWeight.w600),
                                                        ),
                                                        const VSpace(8),
                                                        Text(
                                                          "${dish.dishCalories} calories",
                                                          style: AppTheme.textThemes.bodyText1.copyWith(fontWeight: FontWeight.w600),
                                                        ),
                                                        const VSpace(24),
                                                      ],
                                                    ),
                                                  ),
                                                  ValueListenableBuilder<Box<OrderModel>>(
                                                      valueListenable: HiveService.getOrderBox().listenable(),
                                                      builder: (context, box, _) {
                                                        int count = 0;
                                                        final isOrderPresentInCart = box
                                                                .get(menuController.selectedRestaurant?.restaurantId)
                                                                ?.orderListMap
                                                                .where((element) => element.dishId == dish.dishId)
                                                                .isNotEmpty ??
                                                            false;
                                                        if (isOrderPresentInCart) {
                                                          count = orderModel!.orderListMap.firstWhere((element) => element.dishId == dish.dishId).quantity;
                                                        }
                                                        return CounterWidget(
                                                          onTapAdd: () async {
                                                            final categoryDishModel = getCategoryDishModel(menuController, dish);

                                                            await menuController.onTapAdd(
                                                                box, categoryDishModel, dish.menuCategoryId, Provider.of<Auth>(context, listen: false).userId);
                                                          },
                                                          onTapRemove: () async {
                                                            final categoryDishModel = getCategoryDishModel(menuController, dish);
                                                            await menuController.onTapRemove(box, categoryDishModel);
                                                          },
                                                          count: count,
                                                        );
                                                      }),
                                                  SizedBox(
                                                    width: 80.vdp(),
                                                    child: Text(
                                                      "INR ${(dish.dishPrice * dish.quantity).toStringAsFixed(2)}",
                                                      textAlign: TextAlign.center,
                                                      style: AppTheme.textThemes.headline1.copyWith(fontWeight: FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) => Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.vdp(),
                                            horizontal: 16.vdp(),
                                          ),
                                          child: ColoredBox(
                                            color: AppTheme.appColors.greyIconColor,
                                            child: SizedBox(
                                              height: .5.vdp(),
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                      ))),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.vdp(),
                                  horizontal: 16.vdp(),
                                ),
                                child: ColoredBox(
                                  color: AppTheme.appColors.greyIconColor,
                                  child: SizedBox(
                                    height: .5.vdp(),
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.vdp(),
                                  horizontal: 16.vdp(),
                                ),
                                child: SizedBox(
                                  height: 56.vdp(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Amount",
                                        style: AppTheme.textThemes.headline2.copyWith(
                                          color: AppTheme.appColors.blackTextColor,
                                        ),
                                      ),
                                      Text(
                                        "INR ${orderModel.totalPrice}",
                                        style: AppTheme.textThemes.headline1.copyWith(
                                          color: AppTheme.appColors.darkGreenTextColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      AppCustomButton(
                        bgColor: AppTheme.appColors.appPrimaryColorGreen,
                        title: "Place Order",
                        textColor: Colors.white,
                        onTap: () async {
                          await orderModel.delete();
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("No Orders Present in the cart"),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  CategoryDishes getCategoryDishModel(MenuProviderController menuController, DishOrderHiveModel dish) {
    return menuController.availableRestaurantList
        .firstWhere(
          (element) => element.restaurantId == menuController.selectedRestaurant!.restaurantId,
        )
        .tableMenuList
        .firstWhere(
          (element) => element.menuCategoryId == dish.menuCategoryId,
        )
        .categoryDishes
        .firstWhere(
          (element) => element.dishId == dish.dishId,
        );
  }
}
