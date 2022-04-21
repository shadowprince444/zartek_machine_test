import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:zartek_machine_test/controllers/auth_controller.dart';
import 'package:zartek_machine_test/controllers/sign_in_controller.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
import 'package:zartek_machine_test/views/screens/log_in/widgets/log_in_button.dart';
import 'package:zartek_machine_test/views/widgets/custom_phone_text_field.dart';

class PhoneAuthLogInWidget extends StatefulWidget {
  final Widget child;

  const PhoneAuthLogInWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<PhoneAuthLogInWidget> createState() => _PhoneAuthLogInWidgetState();
}

class _PhoneAuthLogInWidgetState extends State<PhoneAuthLogInWidget> {
  bool isReload = false;

  @override
  Widget build(BuildContext context) {
    SignInController signInController = Provider.of<SignInController>(context, listen: false);
    return Column(
      children: [
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        widget.child,
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        PhoneInputWithCountryCodeWidget(
          showTrailingIcon: true,
          initialSelection: signInController.countryCodeList.first,
          onCountryCodeChanged: (code) => signInController.onChangeCountryCode(code),
          onPhoneFieldChanged: (number) => signInController.onPhoneNumberChanged(number),
          onCompleteTimer: () {
            setState(() {
              isReload = true;
            });
          },
          onTapResend: () {
            setState(() {
              isReload = true;
            });
            signInController.onTapResend();
          },
          countryFilter: signInController.countryCodeList,
          isReload: isReload,
        ),
        const VSpace(8),
        Consumer<SignInController>(builder: (context, authController, _) {
          if (authController.phoneAuthState == PhoneAuthState.autoRetrievalTimeOut) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 56.hdp()),
                  child: PinFieldAutoFill(
                    onCodeChanged: (otp) async {
                      final response = await authController.otpChecker(otp);
                      if (response != null) {
                        String token = await response.user!.getIdToken();
                        Provider.of<Auth>(context, listen: false).store(token, response.user!.uid);
                      }
                    },
                    codeLength: 6,
                    decoration: UnderlineDecoration(
                      colorBuilder: FixedColorBuilder(AppTheme.appColors.greyd8d8d8),
                      textStyle: AppTheme.textThemes.headline3,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return LogInButton(
              logoImage: 'assets/images/phone.png',
              backGroundColor: Colors.lightGreen,
              textColor: Colors.white,
              iconBackGroundColor: Colors.lightGreen,
              title: 'Request OTP',
              onTap: () async {
                await signInController.onSendOtpTapped();
                // if (authController.phoneAuthState == PhoneAuthState.verified) {}
              },
            );
          }
        }),
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
      ],
    );
  }
}
