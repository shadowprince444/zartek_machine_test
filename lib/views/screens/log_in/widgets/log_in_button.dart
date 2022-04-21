import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';

class LogInButton extends StatelessWidget {
  final String logoImage, title;
  final Color backGroundColor, textColor, iconBackGroundColor;
  final Function() onTap;

  const LogInButton({
    Key? key,
    required this.logoImage,
    required this.title,
    required this.backGroundColor,
    required this.textColor,
    required this.onTap,
    required this.iconBackGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 8.vdp(),
        ),
        height: 56.vdp(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              30.vdp(),
            ),
            color: backGroundColor),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const HSpace(24),
              Container(
                height: 40.vdp(),
                width: 40.vdp(),
                padding: EdgeInsets.all(
                  10.vdp(),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBackGroundColor,
                ),
                child: Image.asset(
                  logoImage,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              SizedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
