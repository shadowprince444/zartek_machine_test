import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({/*this.orientation,*/ required this.deviceScreenType, required this.screenSize, required this.localWidgetSize});

  @override
  String toString() {
    return 'DeviceScreenType : $deviceScreenType\nScreenSize : $screenSize\nLocalWidgetSize : $localWidgetSize';
  }
}
