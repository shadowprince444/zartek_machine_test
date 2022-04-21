import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/menu_controller.dart';
import 'package:zartek_machine_test/models/hive/order_model.dart';
import 'package:zartek_machine_test/models/menu_model.dart';
import 'package:zartek_machine_test/models/restaurant_drop_down_model.dart';
import 'package:zartek_machine_test/services/hive/hive_services.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/responsive_safe_area.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
import 'package:zartek_machine_test/views/screens/cart/cart_screen.dart';
import 'package:zartek_machine_test/views/screens/home/widgets/table_tab_bar_view_widget.dart';
import 'package:zartek_machine_test/views/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    var menuProviderController = Provider.of<MenuProviderController>(context, listen: false);
    menuProviderController.getAllRestaurantList();

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppTheme.appColors.appPrimaryColorWhite,
      ),
      child: Consumer<MenuProviderController>(builder: (context, menuController, _) {
        if (menuController.availableRestaurantList.isNotEmpty) {
          var selectedRestaurantModel = menuController.getSelectedRestaurantMenuModel();
          return DefaultTabController(
            length: menuController.availableRestaurantList.first.tableMenuList.length,
            child: Scaffold(
              key: _scaffoldKey,
              drawer: const AppDrawer(),
              backgroundColor: AppTheme.appColors.appPrimaryColorWhite,
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: AppTheme.appColors.appPrimaryColorWhite,
                ),
                child: ResponsiveSafeArea(
                  builder: (BuildContext context, Size size) {
                    return SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80.vdp(),
                            width: double.infinity,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    size: 20.vdp(),
                                    color: AppTheme.appColors.greyIconColor,
                                  ),
                                ),
                                Expanded(child: buildDropdownButtonFormField(menuController)),
                                const HSpace(4),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CartScreen(),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 30.vdp(),
                                    width: 30.vdp(),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.shopping_cart_sharp,
                                            size: 25.vdp(),
                                            color: AppTheme.appColors.greyIconColor,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            height: 15.vdp(),
                                            width: 15.vdp(),
                                            child: ValueListenableBuilder<Box<OrderModel>>(
                                                valueListenable: HiveService.getOrderBox().listenable(),
                                                builder: (context, box, _) {
                                                  int count = 0;

                                                  final isOrderPresentInCart = box.get(menuController.selectedRestaurant?.restaurantId)?.orderListMap.isNotEmpty ?? false;
                                                  if (isOrderPresentInCart) {
                                                    count = box.get(menuController.selectedRestaurant!.restaurantId)!.getAddedDishCount();

                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppTheme.appColors.appPrimaryColorRed,
                                                      ),
                                                      padding: EdgeInsets.all(
                                                        1.vdp(),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        "$count",
                                                        style: AppTheme.textThemes.subtitle1.copyWith(
                                                          color: AppTheme.appColors.appPrimaryColorWhite,
                                                        ),
                                                      )),
                                                    );
                                                  } else {
                                                    return const VSpace(0);
                                                  }
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const HSpace(4),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.vdp(),
                            width: double.infinity,
                            child: TabBar(
                              onTap: (index) {},
                              physics: const AlwaysScrollableScrollPhysics(),
                              indicatorSize: TabBarIndicatorSize.tab,
                              isScrollable: true,
                              indicatorColor: AppTheme.appColors.appPrimaryColorRed,
                              unselectedLabelColor: AppTheme.appColors.darkGreyBottomSheet,
                              unselectedLabelStyle: AppTheme.textThemes.headline1.copyWith(color: AppTheme.appColors.greyTextColor),
                              labelStyle: AppTheme.textThemes.headline1.copyWith(color: AppTheme.appColors.appPrimaryColorRed),
                              labelColor: AppTheme.appColors.appPrimaryColorRed,
                              tabs: List.generate(
                                selectedRestaurantModel.tableMenuList.length,
                                (index) => buildTab(
                                  selectedRestaurantModel.tableMenuList[index],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: List.generate(
                                selectedRestaurantModel.tableMenuList.length,
                                (tableMenuItemIndex) {
                                  final tableMenuItem = selectedRestaurantModel.tableMenuList[tableMenuItemIndex];
                                  return TableMenuTabBarViewWidget(
                                    tableMenuItem: tableMenuItem,
                                    tableMenuItemIndex: tableMenuItemIndex,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildInkWell(context),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Tab buildTab(TableMenuList tableMenuList) => Tab(
        child: Text(
          tableMenuList.menuCategory,
        ),
      );

  DropdownButtonFormField<RestaurantDropDownModel> buildDropdownButtonFormField(MenuProviderController menuController) {
    return DropdownButtonFormField<RestaurantDropDownModel>(
      icon: Padding(
        padding: EdgeInsets.only(right: 16.hdp(), top: 5.vdp()),
        child: const Icon(
          Icons.keyboard_arrow_down,
        ),
      ),
      decoration: InputDecoration(
        hintText: "Choose your Restaurant",
        hintStyle: AppTheme.textThemes.bodyText1.copyWith(
          color: AppTheme.appColors.hintTextColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        ),
        contentPadding: EdgeInsets.only(
          top: 0.vdp(),
          left: 20.hdp(),
          right: 0.hdp(),
          bottom: 0.hdp(),
        ),
      ),
      items: menuController.availableRestaurantList.map((e) {
        return DropdownMenuItem<RestaurantDropDownModel>(
            value: RestaurantDropDownModel(restaurantId: e.restaurantId, restaurantName: e.restaurantName),
            child: Text(
              e.restaurantName,
              style: AppTheme.textThemes.bodyText2,
            ));
      }).toList(),
      onChanged: (i) {
        if (i != null) {
          menuController.onRestaurantSelected(i);
        }
      },
    );
  }

  InkWell buildInkWell(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: SizedBox(
        height: 250.vdp(),
        child: Image.asset(
          "assets/images/firebase_logo.png",
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
