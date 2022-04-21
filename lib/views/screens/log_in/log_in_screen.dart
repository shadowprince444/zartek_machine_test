import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/sign_in_controller.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/widgets/responsive_safe_area.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
import 'package:zartek_machine_test/views/screens/log_in/widgets/initial_log_in_widget.dart';
import 'package:zartek_machine_test/views/screens/log_in/widgets/phone_auth_log_in_widget.dart';
import 'package:zartek_machine_test/views/screens/log_in/widgets/sign_in_success_widget.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
        child: ResponsiveSafeArea(
          builder: (BuildContext context, Size size) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.hdp(),
                ),
                child: Consumer<SignInController>(
                    child: SizedBox(
                      height: 150.vdp(),
                      child: Image.asset(
                        "assets/images/firebase_logo.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    builder: (context, signInController, child) {
                      if (signInController.signInStatus == SignInStatus.none) {
                        return InitialLogInWidget(
                          child: child ?? const VSpace(250),
                        );
                      } else if (signInController.signInStatus == SignInStatus.phone) {
                        return PhoneAuthLogInWidget(
                          child: child ?? const VSpace(250),
                        );
                      } else {
                        return SignInSuccessWidget(
                          child: child ?? const VSpace(250),
                        );
                      }
                      // else {
                      //   return AddProfileWidget(
                      //     child: child ?? const VSpace(250),
                      //   );
                      // }
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}
