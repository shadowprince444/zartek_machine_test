import 'package:flutter/material.dart';
import 'package:zartek_machine_test/models/menu_model.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/views/screens/home/widgets/dish_item_widget.dart';

class TableMenuTabBarViewWidget extends StatelessWidget {
  const TableMenuTabBarViewWidget({
    Key? key,
    required this.tableMenuItemIndex,
    required this.tableMenuItem,
  }) : super(key: key);
  final TableMenuList tableMenuItem;

  final int tableMenuItemIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: tableMenuItem.categoryDishes.length,
        separatorBuilder: (context, index) => ColoredBox(
              color: AppTheme.appColors.darkGreyBottomSheet,
              child: SizedBox(
                height: .25.vdp(),
                width: double.infinity,
              ),
            ),
        itemBuilder: (context, dishIndex) {
          final dish = tableMenuItem.categoryDishes[dishIndex];

          return DishItemWidget(
            dishIndex: dishIndex,
            tableMenuItemIndex: tableMenuItemIndex,
            dish: dish,
          );
        });
  }
}
