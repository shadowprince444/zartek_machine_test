import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';

class AppCustomButton extends StatelessWidget {
  final Color bgColor, textColor;
  final String title;
  final Function() onTap;

  const AppCustomButton({
    Key? key,
    required this.bgColor,
    required this.textColor,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8.vdp(),
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
            24.vdp(),
          ),
        ),
        width: double.infinity,
        height: 48.vdp(),
        child: Center(
          child: Text(
            title,
            style: AppTheme.textThemes.headline2.copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
