import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';

///required package https://pub.dev/packages/country_pickers/install
///Custom widget created by using 2 packages

class PhoneInputWithCountryCodeWidget extends StatelessWidget {
  final void Function(CountryCode)? onCountryCodeChanged;
  final void Function(String)? onPhoneFieldChanged;
  final bool showTrailingIcon;
  final bool isReload;
  final String? initialSelection;
  final TextEditingController? phoneFieldController;
  final Function()? onStartTimer;
  final Function()? onTapResend;
  final Function()? onCompleteTimer;
  final List<String>? countryFilter;

  const PhoneInputWithCountryCodeWidget({
    Key? key,
    this.showTrailingIcon = false,
    this.onCountryCodeChanged,
    this.onPhoneFieldChanged,
    this.initialSelection,
    this.phoneFieldController,
    this.onStartTimer,
    this.onCompleteTimer,
    required this.isReload,
    this.onTapResend,
    this.countryFilter = const ['+249', '+91'],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(
          color: AppTheme.appColors.hintTextColor,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: 101.hdp(),
              child: CountryCodePicker(
                onChanged: onCountryCodeChanged,
                countryFilter: countryFilter,
                dialogSize: Size(320.hdp(), 700.vdp()),
                flagWidth: 24.hdp(),
                searchDecoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                ),
                initialSelection: initialSelection,
                alignLeft: true,
                padding: EdgeInsets.zero,
              )),
          SizedBox(
            height: 45.vdp(),
            child: VerticalDivider(
              width: 0,
              thickness: 1.hdp(),
            ),
          ),
          Expanded(
            flex: 8,
            child: TextField(
              controller: phoneFieldController,
              onChanged: onPhoneFieldChanged,
              cursorColor: AppTheme.appColors.appPrimaryColorRed,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10.hdp(), right: 10.hdp()),
                hintStyle: AppTheme.textThemes.bodyText1.copyWith(
                  color: AppTheme.appColors.hintTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp(),
                ),
                hintText: "Mobile Number",
              ),
            ),
          ),
          Visibility(
            visible: showTrailingIcon,
            child: Expanded(
              flex: 2,
              child: Row(
                children: [
                  SizedBox(
                    height: 45.vdp(),
                    child: VerticalDivider(
                      thickness: 2.hdp(),
                      indent: 8.vdp(),
                      endIndent: 8.vdp(),
                    ),
                  ),
                  isReload
                      ? GestureDetector(
                          onTap: onTapResend,
                          child: Container(
                            width: 23.vdp(),
                            height: 23.vdp(),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.appColors.greyC4C4C4),
                            child: Icon(
                              Icons.replay,
                              size: 16.sp(),
                              color: AppTheme.appColors.appPrimaryColorRed,
                            ),
                          ),
                        )
                      : CircularCountDownTimer(
                          isReverse: true,
                          isReverseAnimation: true,
                          width: 23.hdp(),
                          strokeWidth: 2.vdp(),
                          backgroundColor: AppTheme.appColors.greyC4C4C4,
                          ringColor: AppTheme.appColors.appPrimaryColorWhite,
                          fillColor: AppTheme.appColors.greya0a0a0,
                          textStyle: AppTheme.textThemes.subtitle1.copyWith(fontWeight: FontWeight.w700, color: AppTheme.appColors.appPrimaryColorWhite),
                          initialDuration: 0,
                          duration: 90,
                          textFormat: "ss",
                          height: 23.vdp(),
                          onStart: onStartTimer,
                          onComplete: onCompleteTimer,
                        ),
                ],
              ),
            ),
          ),
          HSpace(8),
        ],
      ),
    );
  }
}
