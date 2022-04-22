import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.appColors.greyIconColor,
      child: SizedBox(
        height: .5.vdp(),
        width: double.infinity,
      ),
    );
  }
}
