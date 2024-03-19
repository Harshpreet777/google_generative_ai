import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_demo/core/model/image_text_model.dart';
import 'package:gemini_demo/core/services/google_generative_service.dart';
import 'package:gemini_demo/core/viewmodel/base_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageTextViewModel extends BaseModel {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController=ScrollController();
  File? photo;
  final ImagePicker imagePicker = ImagePicker();
  String fileName = '';
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
    log(image.toString());
    imageTextList.add(ImageTextModel(
        role: 'user', text: messageController.text, photo: image));
    photo = null;
    scrollController.animateTo(scrollController.position.maxScrollExtent+80, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);

    updateUI();
    if (image != null) {
      final imageTextData =
          await GoogleGenerative.getImageText(image, messageController.text);
      imageTextList.add(ImageTextModel(
        role: imageTextData?.role ?? '',
        text: imageTextData?.text ?? '',
      ));
    } else {
      String data = await GoogleGenerative.getData(messageController.text);
      imageTextList.add(ImageTextModel(text: data));
    }
    loading(false);
    scrollController.animateTo(scrollController.position.maxScrollExtent+80, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);

    updateUI();
  }
}
