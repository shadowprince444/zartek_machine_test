import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/menu_controller.dart';
import 'package:zartek_machine_test/models/hive/dish_order_hive_model.dart';
import 'package:zartek_machine_test/models/hive/order_model.dart';
import 'package:zartek_machine_test/models/menu_model.dart';
import 'package:zartek_machine_test/services/hive/hive_services.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
import 'package:zartek_machine_test/views/widgets/separator_widget.dart';

class AddOnCategoryDialogueBox extends StatelessWidget {
  const AddOnCategoryDialogueBox({
    Key? key,
    required this.dishOrderHiveModel,
    required this.addOnCatList,
    required this.orderModel,
  }) : super(key: key);
  final OrderModel orderModel;
  final List<AddonCat> addOnCatList;
  final DishOrderHiveModel dishOrderHiveModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent.withOpacity(.2),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
            color: AppTheme.appColors.appPrimaryColorWhite,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          ),
          height: 700.vdp(),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 16.hdp(),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 16.hdp(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.vdp(),
                ),
                child: Text(
                  "Add add-ons",
                  style: AppTheme.textThemes.headline3,
                ),
              ),
              const VSpace(16),
              Expanded(
                child: ValueListenableBuilder<Box<OrderModel>>(
                    valueListenable: HiveService.getOrderBox().listenable(),
                    builder: (context, box, _) {
                      return ListView.separated(
                        itemCount: addOnCatList.length,
                        itemBuilder: (context, index) {
                          var addOnnCat = addOnCatList[index];

                          return ListView.builder(
                              itemCount: addOnnCat.addons.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, addOnIndex) {
                                var addOn = addOnnCat.addons[addOnIndex];

                                bool isAddOnSelected = orderModel.orderListMap
                                        .firstWhere((element) => element.dishId == dishOrderHiveModel.dishId)
                                        .addOns
                                        .firstWhereOrNull((element) => element.dishId == addOn.dishId) !=
                                    null;
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            final menuController = Provider.of<MenuProviderController>(context, listen: false);
                                            if (isAddOnSelected) {
                                              menuController.removeAddOn(orderModel, dishOrderHiveModel.dishId, addOnCatList[index].addons[addOnIndex].dishId);
                                            } else {
                                              menuController.addAddOn(orderModel, dishOrderHiveModel.dishId, addOnCatList[index].addons[addOnIndex]);
                                            }
                                          },
                                          child: SizedBox(
                                            height: 20.vdp(),
                                            width: 20.vdp(),
                                            child: Icon(
                                              Icons.check_box,
                                              color: isAddOnSelected ? AppTheme.appColors.notificationGreen : AppTheme.appColors.greyIconColor,
                                              size: 20.vdp(),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            addOn.dishName,
                                            style: AppTheme.textThemes.headline1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60.hdp(),
                                          child: Text(
                                            "INR ${addOn.dishPrice}",
                                            style: AppTheme.textThemes.subtitle2.copyWith(
                                              color: AppTheme.appColors.notificationGreen,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const HSpace(30),
                                        Expanded(
                                          child: Text(
                                            addOn.dishDescription,
                                            style: AppTheme.textThemes.bodyText1,
                                            maxLines: 4,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              });
                        },
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.vdp(),
                          ),
                          child: const SeparatorWidget(),
                        ),
                      );
                    }),
              )
            ],
          ),
        )
      ]),
    );
  }
}
