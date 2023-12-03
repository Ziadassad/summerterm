import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SelectMedia {

  Future getSingleImage(context, imageResource, bool background) async {
    File? imageFile;
    XFile? image;

    try {
      image = (await ImagePicker().pickImage(source: imageResource));
      imageFile = File(image!.path);
      imageFile = await cropImage(imageFile, context, background);
      print(imageFile);
    } on PlatformException {
      print("Field pik image");
    }

    if (image == null) return;

    return imageFile;
  }


  late File croppedFile;

  cropImage(File image, BuildContext context, bool background) async {
    File? cropImage;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: background ? const CropAspectRatio(ratioX: 200, ratioY: 100) : null,
      cropStyle: background? CropStyle.rectangle : CropStyle.circle,
      aspectRatioPresets: [

      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          // lockAspectRatio: ,
        ),
        IOSUiSettings(
          aspectRatioLockDimensionSwapEnabled: true,
          resetAspectRatioEnabled: true,
          aspectRatioLockEnabled: true,
          title: 'Cropper',
          minimumAspectRatio: 1/2,
        ),
      ],
    );
    if (croppedFile != null) {
      cropImage = File(croppedFile.path);
    }
    return cropImage;
  }
}