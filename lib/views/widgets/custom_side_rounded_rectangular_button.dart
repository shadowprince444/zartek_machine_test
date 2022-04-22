import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';

class CustomSideRoundedRectangularButton extends StatelessWidget {
  final Color containerColor;
  final double topLeftRadius, topRightRadius, bottomRightRadius, bottomLeftRadius;
  final Widget childWidget;
  final Function()? onTap;

  const CustomSideRoundedRectangularButton({
    Key? key,
    required this.childWidget,
    this.onTap,
    this.containerColor = Colors.white,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(
            color: AppTheme.appColors.appGrey,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius),
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            topRight: Radius.circular(topRightRadius),
          ),
        ),
        child: Center(
          child: childWidget,
        ),
      ),
    );
  }
}
