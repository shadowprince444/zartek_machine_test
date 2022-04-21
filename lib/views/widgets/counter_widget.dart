import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    required this.count,
    required this.onTapAdd,
    required this.onTapRemove,
    Key? key,
  }) : super(key: key);
  final Function() onTapAdd, onTapRemove;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.vdp(),
      ),
      decoration: BoxDecoration(
        color: AppTheme.appColors.appPrimaryColorGreen,
        borderRadius: BorderRadius.circular(
          16.vdp(),
        ),
      ),
      width: 100.hdp(),
      height: 32.vdp(),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTapRemove,
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: 20.vdp(),
                  color: AppTheme.appColors.appPrimaryColorWhite,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "$count",
              textAlign: TextAlign.center,
              style: AppTheme.textThemes.headline1.copyWith(
                color: AppTheme.appColors.appPrimaryColorWhite,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTapAdd,
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 20.vdp(),
                  color: AppTheme.appColors.appPrimaryColorWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
