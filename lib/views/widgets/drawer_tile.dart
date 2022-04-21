import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';

class DrawerTile extends StatelessWidget {
  final String tileName;
  final String? iconName;
  final Widget? tileIcon;
  final Function() onTap;

  const DrawerTile({
    Key? key,
    this.iconName,
    required this.onTap,
    required this.tileName,
    this.tileIcon,
  })  : assert(
          iconName == null && tileIcon != null || iconName != null && tileIcon == null,
          "you need to give the svg icon's path or a widget to show in the DrawerTileWidget",
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.appColors.appPrimaryColorWhite,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.hdp()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HSpace(30),
              SizedBox(
                height: 30.vdp(),
                width: 30.hdp(),
                child: tileIcon ??
                    SvgPicture.asset(
                      iconName!,
                      color: AppTheme.appColors.greyIconColor,
                    ),
              ),
              HSpace(12),
              Expanded(
                  child: Text(
                tileName,
                style: AppTheme.textThemes.headline2,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
