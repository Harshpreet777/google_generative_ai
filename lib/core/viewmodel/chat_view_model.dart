import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_demo/core/model/image_text_model.dart';
import 'package:gemini_demo/core/services/google_generative_service.dart';
import 'package:gemini_demo/core/viewmodel/base_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageTextViewModel extends BaseModel {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  File? _photo;
  ImagePicker _imagePicker = ImagePicker();
  String _fileName = '';
  List<ImageTextModel> _imageTextList = [];
  bool _isTyping = false;
  bool _isEmojiPicker = false;

  bool get isEmojiPicker => _isEmojiPicker;
  bool get isTyping => _isTyping;
  List<ImageTextModel> get imageTextList => _imageTextList;
  File? get photo => _photo;
  String get fileName => _fileName;
  ImagePicker get imagePicker => _imagePicker;

  set setImagePicker(ImagePicker setImagePicker) {
    _imagePicker = imagePicker;
  }

  set setFileName(String setFileName) {
    _fileName = setFileName;
  }

  set setPhoto(File? setPhoto) {
    _photo = setPhoto;
  }

  set setEmojiPicker(bool setEmojiPicker) {
    _isEmojiPicker = setEmojiPicker;
  }

  set setTyping(bool setTyping) {
    _isTyping = setTyping;
  }

  set setImageTextList(List<ImageTextModel> setImageTextList) {
    _imageTextList = setImageTextList;
  }

  Future imgFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setPhoto = File(pickedFile.path);
      setFileName = basename(photo?.path ?? '');
      updateUI();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setPhoto = File(pickedFile.path);
      setFileName = basename(photo?.path ?? "");
      updateUI();
    } else {
      debugPrint('No image selected.');
    }
  }

  keyboardAppear(bool value) {
    setTyping = value;

    updateUI();
  }

  showEmojiPicker(bool value) {
    setEmojiPicker = value;
    updateUI();
  }

  scrollAnimation() {
    scrollController.animateTo(scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 5), curve: Curves.easeOut);
  }

  getImageText() async {
    File? image = photo;
    log(image.toString());
    imageTextList.add(ImageTextModel(
        role: 'user', text: messageController.text, photo: image));
    scrollAnimation();
    updateUI();
    setPhoto = null;
    imageTextList.add(ImageTextModel(role: 'model', text: '', photo: null));
    scrollAnimation();
    updateUI();

    int index = imageTextList.length - 1;
    if (image != null) {
      final imageTextData =
          await GoogleGenerative.getImageText(image, messageController.text);
      imageTextList.removeAt(index);
      imageTextList.add(ImageTextModel(
        role: imageTextData?.role ?? '',
        text: imageTextData?.text ?? '',
      ));
    } else {
      String data = await GoogleGenerative.getData(messageController.text);
      imageTextList.removeAt(index);
      imageTextList.add(ImageTextModel(text: data, role: 'model'));
      updateUI();
    }
    scrollAnimation();
    updateUI();
  }
}
