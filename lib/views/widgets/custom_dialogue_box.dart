import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';

import 'custom_side_rounded_rectangular_button.dart';

class CustomDialogueBox extends StatelessWidget {
  final Widget icon, title, subtitle;
  final List<CustomSideRoundedRectangularButton> buttonList;

  const CustomDialogueBox({
    Key? key,
    required this.buttonList,
    required this.icon,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent.withOpacity(.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            // height: 304.vdp(),
            width: 320.hdp(),
            child: Material(
              borderRadius: BorderRadius.circular(AppTheme.dialogBorderRadius),
              color: AppTheme.appColors.appPrimaryColorWhite,
              child: Column(
                children: [
                  const VSpace(25),
                  icon,
                  const VSpace(20),
                  title,
                  Padding(padding: EdgeInsets.symmetric(horizontal: 14.hdp(), vertical: 14.vdp()), child: subtitle),
                  SizedBox(
                    height: 56.vdp(),
                    child: Row(
                      children: buttonList.map((e) => Expanded(child: e)).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
