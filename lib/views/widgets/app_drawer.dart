import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/auth_controller.dart';
import 'package:zartek_machine_test/controllers/profile_controller.dart';
import 'package:zartek_machine_test/main.dart';
import 'package:zartek_machine_test/services/hive/hive_services.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/views/widgets/circular_profile_avatar.dart';
import 'package:zartek_machine_test/views/widgets/drawer_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final OwnerProfileController userController = Get.find<OwnerProfileController>();
    return SizedBox(
      width: 350.hdp(),
      child: Drawer(
        backgroundColor: AppTheme.appColors.appPrimaryColorWhite,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                  32.vdp(),
                )),
                color: AppTheme.appColors.appPrimaryColorGreen,
              ),
              // width: double.infinity,
              height: 275.vdp(),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Consumer<ProfileController>(builder: (context, controller, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProfileAvatar(imageSize: 82.vdp(), imagePath: controller.userModel?.imageUrl ?? ""),
                            Text(
                              controller.userModel?.name ?? "User",
                              style: AppTheme.textThemes.headline3.copyWith(
                                color: AppTheme.appColors.appPrimaryColorWhite,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Center(
                                child: Text(
                                  "ID: ${controller.userModel!.userId.substring(0, 8)}●●●●●●",
                                  style: AppTheme.textThemes.headline1.copyWith(
                                    color: AppTheme.appColors.appPrimaryColorWhite,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        );
                      })),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  DrawerTile(
                    onTap: () async {
                      await Provider.of<Auth>(context, listen: false).logOut();
                      await HiveService.getOrderBox().clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const InitialScreen()),
                        (route) => false,
                      );
                    },
                    tileName: "Log out",
                    tileIcon: Icon(
                      Icons.logout,
                      color: AppTheme.appColors.greyIconColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
