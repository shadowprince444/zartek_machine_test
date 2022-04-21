import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/auth_controller.dart';
import 'package:zartek_machine_test/controllers/profile_controller.dart';
import 'package:zartek_machine_test/utils/app_utils.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/responsive_safe_area.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
import 'package:zartek_machine_test/views/screens/home/home_screen.dart';
import 'package:zartek_machine_test/views/widgets/app_custom_button.dart';
import 'package:zartek_machine_test/views/widgets/circular_profile_avatar.dart';

class AddProfileScreen extends StatelessWidget {
  const AddProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context, listen: false);

    SizeConfig().init(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
        child: ResponsiveSafeArea(builder: (BuildContext context, Size size) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.hdp(),
              ),
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  SizedBox(
                    height: 150.vdp(),
                    child: Image.asset(
                      "assets/images/firebase_logo.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const VSpace(32),
                  Consumer<ProfileController>(builder: (context, controller, _) {
                    return ProfileAvatar(
                      imageSize: 120.vdp(),
                      imagePath: controller.imageUrl,
                      isEditable: true,
                      onTapAddPhoto: () async {
                        final image = await AppUtils.selectAndCropImage();
                        if (image != null) {
                          await controller.uploadUserImage(image);
                        }
                      },
                    );
                  }),
                  const VSpace(8),
                  Text(
                    "Add profile image",
                    style: AppTheme.textThemes.bodyText1,
                  ),
                  const VSpace(16),
                  TextFormField(
                    onChanged: (s) => profileController.onNameFieldChanged(s),
                    style: AppTheme.textThemes.bodyText2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                      ),
                      // labelText: "Na",
                      // labelStyle: TextStyle(
                      //   // backgroundColor: Colors.transparent,
                      //   color: AppTheme.appColors.hintTextColor,
                      // ),
                      // suffixIcon: suffixIcon,
                      counterText: "",
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Please enter your name",
                      hintStyle: AppTheme.textThemes.bodyText1.copyWith(
                        color: AppTheme.appColors.hintTextColor,
                      ),
                      contentPadding: EdgeInsets.only(
                        top: 0.vdp(),
                        left: 20.hdp(),
                        right: 20.hdp(),
                        bottom: 0.hdp(),
                      ),
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: AppTheme.appColors.appPrimaryColorRed, width: 1.0),
                      //   borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                      // ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  AppCustomButton(
                    bgColor: AppTheme.appColors.appPrimaryColorGreen,
                    textColor: Colors.white,
                    title: "Submit",
                    onTap: () async {
                      bool isComplete = await profileController.addUserData(Provider.of<Auth>(context, listen: false).userId);
                      if (isComplete) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
