// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zartek_machine_test/controllers/sign_in_controller.dart';
// import 'package:zartek_machine_test/utils/app_utils.dart';
// import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
// import 'package:zartek_machine_test/utils/theme/app_theme.dart';
// import 'package:zartek_machine_test/utils/widgets/spacing_widgets.dart';
// import 'package:zartek_machine_test/views/screens/home/home_screen.dart';
// import 'package:zartek_machine_test/views/widgets/app_custom_button.dart';
// import 'package:zartek_machine_test/views/widgets/circular_profile_avatar.dart';
//
// class AddProfileWidget extends StatelessWidget {
//   const AddProfileWidget({Key? key, required this.child}) : super(key: key);
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     SignInController signInController = Provider.of<SignInController>(context, listen: false);
//     return Column(
//       children: [
//         const Expanded(
//           flex: 1,
//           child: SizedBox(),
//         ),
//         child,
//         const VSpace(32),
//         Consumer<SignInController>(builder: (context, controller, _) {
//           return ProfileAvatar(
//             imageSize: 120.vdp(),
//             imagePath: controller.imageUrl,
//             isEditable: true,
//             onTapAddPhoto: () async {
//               final image = await AppUtils.selectAndCropImage();
//               if (image != null) {
//                 await controller.uploadUserImage(image);
//               }
//             },
//           );
//         }),
//         const VSpace(8),
//         Text(
//           "Add profile image",
//           style: AppTheme.textThemes.bodyText1,
//         ),
//         const VSpace(16),
//         TextFormField(
//           onChanged: (s) => signInController.onNameFieldChanged(s),
//           style: AppTheme.textThemes.bodyText2,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
//               borderRadius: BorderRadius.circular(AppTheme.borderRadius),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
//               borderRadius: BorderRadius.circular(AppTheme.borderRadius),
//             ),
//             // labelText: "Na",
//             // labelStyle: TextStyle(
//             //   // backgroundColor: Colors.transparent,
//             //   color: AppTheme.appColors.hintTextColor,
//             // ),
//             // suffixIcon: suffixIcon,
//             counterText: "",
//             //border: InputBorder.none,
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: AppTheme.appColors.hintTextColor, width: 1.0),
//               borderRadius: BorderRadius.circular(AppTheme.borderRadius),
//             ),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: "Please enter your name",
//             hintStyle: AppTheme.textThemes.bodyText1.copyWith(
//               color: AppTheme.appColors.hintTextColor,
//             ),
//             contentPadding: EdgeInsets.only(
//               top: 0.vdp(),
//               left: 20.hdp(),
//               right: 20.hdp(),
//               bottom: 0.hdp(),
//             ),
//             // errorBorder: OutlineInputBorder(
//             //   borderSide: BorderSide(color: AppTheme.appColors.appPrimaryColorRed, width: 1.0),
//             //   borderRadius: BorderRadius.circular(AppTheme.borderRadius),
//             // ),
//           ),
//         ),
//         const Expanded(
//           flex: 1,
//           child: SizedBox(),
//         ),
//         AppCustomButton(
//           bgColor: AppTheme.appColors.appPrimaryColorGreen,
//           textColor: Colors.white,
//           title: "Submit",
//           onTap: () async {
//             bool isComplete = await signInController.addUserData();
//             if (isComplete) {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const HomeScreen(),
//                 ),
//                 (route) => false,
//               );
//             }
//           },
//         ),
//         const Expanded(
//           flex: 2,
//           child: SizedBox(),
//         ),
//       ],
//     );
//   }
// }
