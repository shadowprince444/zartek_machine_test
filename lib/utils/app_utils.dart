import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class AppUtils {
  static Future<File?> selectAndCropImage() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      // allowedExtensions: ['jpg', 'png'],
    );
    if (file != null) {
      if (file.isSinglePick) {
        var path = file.files[0].path;

        return await ImageCropper().cropImage(
          sourcePath: path ?? "",
          compressFormat: ImageCompressFormat.jpg,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          iosUiSettings: const IOSUiSettings(
            title: 'Cropper',
          ),
        );
      }
    }
    return null;
  }
}
