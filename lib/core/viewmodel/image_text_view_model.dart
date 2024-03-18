import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_demo/core/model/image_text_model.dart';
import 'package:gemini_demo/core/services/google_generative_service.dart';
import 'package:gemini_demo/core/viewmodel/base_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageTextViewModel extends BaseModel {
  TextEditingController messageController = TextEditingController();
  File? photo;
  final ImagePicker imagePicker = ImagePicker();
  String fileName = '';
  String message = '';
  List<ImageTextModel> imageTextList = [];
  bool isLoading = false;

  Future imgFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      fileName = basename(photo?.path ?? '');
      updateUI();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      fileName = basename(photo?.path ?? "");
      updateUI();
    } else {
      debugPrint('No image selected.');
    }
  }

  loading(bool value) {
    isLoading = value;
    updateUI();
  }

  getImageText() async {
    loading(true);
    File? image = photo;
    imageTextList.add(ImageTextModel(
        role: 'user', text: messageController.text, photo: image));
    photo = null;
    updateUI();
    final imageTextData =
        await GoogleGenerative.getImageText(image!, messageController.text);
    imageTextList.add(ImageTextModel(
      role: imageTextData?.role ?? '',
      text: imageTextData?.text ?? '',
    ));
    loading(false);
    updateUI();
  }
}
