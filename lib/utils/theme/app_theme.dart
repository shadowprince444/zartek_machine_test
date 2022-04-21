import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';

class AppTheme {
  static _AppColors appColors = _AppColors();
  static _AppTextThemes textThemes = _AppTextThemes(primaryTextColor: appColors.primaryTextColor);
  static _AppShapes appShapes = _AppShapes();

  static double get borderRadius => appShapes.borderRadius;

  static double get dialogBorderRadius => appShapes.dialogBorderRadius;
  static Shadow appLogoTextShadow = const Shadow(color: Colors.black, blurRadius: 4.0, offset: Offset(0, 4));
}

//region AppColors
class _AppColors {
  //region App Primary Color
  Color appPrimaryColorRed = const Color(0xFFE12026);
  Color appPrimaryColorGreen = const Color(0xFF1a3f14);
  Color appPrimaryColorWhite = const Color(0xFFFFFFFF);
  Color pageBackground = const Color(0xFFF8F8F8);
  Color appPinkColor = const Color(0xFFFFE9E9);
  Color appBlackColor = const Color(0xFF2E353A);
  Color c0x0d000000 = const Color(0x0D000000);
  Color appGrey = const Color(0xFFEEEEEE);
  Color textFieldBorder = const Color(0xFFADADAD);
  Color cF7F7F7 = const Color(0xFFF7F7F7);
  Color cA7A7A7 = const Color(0xFFA7A7A7);
  Color pendingStatusColor = const Color(0xFFF6B103);

  Color appLightRedColor = const Color(0xFFCCA4A0);
  Color paleGreen = const Color(0xFFFBFBFB);
  Color lightGreenColor = const Color(0xFFD8FFEC);
  Color darkGreyBottomSheet = const Color(0xFF9B9B9B);

  Color mediumGreenColor = const Color(0xFF4CE5B1);

  //endregion

  //region Text Colors
  Color primaryTextColor = const Color(0xFF242E42);
  Color secondaryTextColor = const Color(0xFF444444);
  Color blackTextColor = const Color(0xFF4B4B4B);
  Color disabledTextColor = const Color(0xFFCFCFCF);
  Color hintTextColor = const Color(0xFFCFCFCF);
  Color greyTextColor = const Color(0xFF8E8E8E);
  Color greySubTextColor = const Color(0xFF8A8A8F);
  Color darkGreenTextColor = const Color(0xFF16A862);
  Color grey1 = const Color(0xFFF7F7F7);
  Color mediumGrey = const Color(0xFFF1F1F1);
  Color efeff4 = const Color(0xFFEFEFF4);
  Color lightGreyText = const Color(0xFFC8C7CC);
  Color notificationGreen = const Color(0xFF4CE5B1);
  Color notificationRed = const Color(0xFFF52D56);
  Color notificationIcon = const Color(0xFFDADADA);
  Color greyIconColor = const Color(0xFFBEBEBE);
  Color cb8b8b8 = const Color(0xFFB8B8B8);
  Color yellowStatus = const Color(0xFFF6B103);
  Color c5B5B5B = const Color(0xFF5B5B5B);
  Color greyd8d8d8 = const Color(0xFFD8D8D8);
  Color greya0a0a0 = const Color(0xFFA0A0A0);
  Color greyC4C4C4 = const Color(0xFFC4C4C4);

  //Color grey5 = Color(0xFFC0C2C3);
  //Color black2 = Color(0xFF4B4B4B);

  //endregion
  //region Button Colors
  Color enabledButtonColor = const Color(0xFF2E353A);
  Color disabledButtonColor = const Color(0xFFC8C7CC);
//endregion
}
//endregion

//region Text Themes
class _AppTextThemes {
  static const String _fontFamily = "Cairo";
  late TextStyle _textStyle;

  ///Commonly used text style in the app.

  late TextStyle subtitle1 = _textStyle.copyWith(fontSize: 10.sp(), fontWeight: FontWeight.normal);
  late TextStyle subtitle2 = _textStyle.copyWith(fontSize: 12.sp(), fontWeight: FontWeight.normal);
  late TextStyle bodyText1 = _textStyle.copyWith(fontSize: 14.sp(), fontWeight: FontWeight.normal);
  late TextStyle bodyText2 = _textStyle.copyWith(fontSize: 16.sp(), fontWeight: FontWeight.normal);
  late TextStyle headline1 = _textStyle.copyWith(fontSize: 16.sp(), fontWeight: FontWeight.bold);
  late TextStyle headline2 = _textStyle.copyWith(fontSize: 18.sp(), fontWeight: FontWeight.bold);
  late TextStyle headline3 = _textStyle.copyWith(fontSize: 24.sp(), fontWeight: FontWeight.bold);
  late TextStyle headline4 = _textStyle.copyWith(fontSize: 32.sp(), fontWeight: FontWeight.bold);

  Color primaryTextColor;

  _AppTextThemes({required this.primaryTextColor}) {
    _textStyle = GoogleFonts.quicksand().copyWith(color: primaryTextColor);
  }
}
//endregion

//region App backgrounds
class _AppShapes {
  static const double _borderRadius = 8;
  static const double _dialogBorderRadius = 16;

  double get dialogBorderRadius => _dialogBorderRadius;

  double get borderRadius => _borderRadius;

  RoundedRectangleBorder cardShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius));
  BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 20,
    offset: const Offset(0, -5),
    spreadRadius: 0,
  );
}
//endregion
