import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/auth_controller.dart';
import 'package:zartek_machine_test/controllers/sign_in_controller.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
import 'package:zartek_machine_test/views/screens/log_in/widgets/log_in_button.dart';

class InitialLogInWidget extends StatelessWidget {
  final Widget child;

  const InitialLogInWidget({
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
        LogInButton(
          logoImage: 'assets/images/google_logo.png',
          backGroundColor: Colors.blueAccent,
          textColor: Colors.white,
          iconBackGroundColor: Colors.white,
          title: 'Google',
          onTap: () async {
            final response = await Provider.of<SignInController>(context, listen: false).googleSignIn();
            if (response != null) {
              String token = await response.getIdToken();
              Provider.of<Auth>(context, listen: false).store(token, response.uid);
            }
          },
        ),
        const VSpace(8),
        LogInButton(
          logoImage: 'assets/images/phone.png',
          backGroundColor: Colors.lightGreen,
          textColor: Colors.white,
          iconBackGroundColor: Colors.lightGreen,
          title: 'Phone',
          onTap: () {
            Provider.of<SignInController>(
              context,
              listen: false,
            ).changeLogInMethod(SignInStatus.phone);
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
