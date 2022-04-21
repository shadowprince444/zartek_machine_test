import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/utils/theme/app_theme.dart';

class ProfileAvatar extends StatelessWidget {
  final double imageSize, outerBorderWidth;
  final String imagePath;
  final Color outerContainerColor;
  final Function()? onTapAddPhoto;
  final bool isEditable;

  const ProfileAvatar({
    Key? key,
    required this.imageSize,
    required this.imagePath,
    this.outerBorderWidth = 3,
    this.outerContainerColor = Colors.white,
    this.isEditable = false,
    this.onTapAddPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: imagePath,
              imageBuilder: (context, imageProvider) {
                debugPrint(imagePath);
                return Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    color: AppTheme.appColors.appPrimaryColorWhite,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: outerContainerColor,
                      width: outerBorderWidth.vdp(),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              // placeholder: (context, url) => CircularProgressIndicator(),
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      color: AppTheme.appColors.appPrimaryColorWhite,
                      shape: BoxShape.circle,
                      border: Border.all(color: outerContainerColor, width: outerBorderWidth.vdp(), style: BorderStyle.solid),
                    ),
                    child: CircularProgressIndicator(color: Colors.grey, value: downloadProgress.progress));
              },
              errorWidget: (context, url, error) => Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  color: AppTheme.appColors.appPrimaryColorWhite,
                  shape: BoxShape.circle,
                  border: Border.all(color: outerContainerColor, width: outerBorderWidth.vdp(), style: BorderStyle.solid),
                ),
                child: Icon(
                  Icons.person,
                  size: imageSize / 2,
                  color: AppTheme.appColors.greyIconColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Visibility(
              visible: isEditable && (imagePath.isEmpty),
              child: GestureDetector(
                onTap: isEditable ? onTapAddPhoto : null,
                child: Center(
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: imageSize / 8,
                    color: AppTheme.appColors.appPrimaryColorWhite,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
