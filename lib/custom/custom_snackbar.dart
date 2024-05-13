// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:agritool/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//SnackBar
void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText(text: content),
    ),
  );
}

//Image Picker

Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }

  return image;
}
