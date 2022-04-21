import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/auth_controller.dart';
import 'package:zartek_machine_test/controllers/menu_controller.dart';
import 'package:zartek_machine_test/controllers/profile_controller.dart';
import 'package:zartek_machine_test/controllers/sign_in_controller.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
import 'package:zartek_machine_test/views/screens/home/home_screen.dart';
import 'package:zartek_machine_test/views/screens/log_in/widgets/log_in_button.dart';
import 'package:zartek_machine_test/views/screens/profile_screen.dart';

class SignInSuccessWidget extends StatelessWidget {
  final Widget child;

  const SignInSuccessWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        child,
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Icon(
          Icons.verified_user_sharp,
          color: AppTheme.appColors.notificationGreen,
          size: 80.vdp(),
        ),
        const VSpace(8),
        Text(
          "User verified Successfully",
          style: AppTheme.textThemes.headline1.copyWith(
            color: AppTheme.appColors.darkGreenTextColor,
          ),
        ),
        const VSpace(8),
        LogInButton(
          logoImage: 'assets/images/user_verified_logo.png',
          backGroundColor: AppTheme.appColors.cF7F7F7,
          textColor: Colors.white,
          iconBackGroundColor: Colors.transparent,
          title: "Let's Go",
          onTap: () async {
            final profileController = Provider.of<ProfileController>(
              context,
              listen: false,
            );
            print(Provider.of<Auth>(context, listen: false).userId);
            await profileController.getUserProfile(Provider.of<SignInController>(context, listen: false).userIdForLogIn).then((InitialScreenStatus value) async {
              if (value == InitialScreenStatus.firstLogIn) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProfileScreen(),
                  ),
                  (route) => false,
                );
                Provider.of<SignInController>(context, listen: false).resetState();
              } else {
                var menuProviderController = Provider.of<MenuProviderController>(context, listen: false);
                await menuProviderController.getAllRestaurantList();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
                Provider.of<SignInController>(context, listen: false).resetState();
              }
            });
          },
        ),
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
      ],
    );
  }
}
