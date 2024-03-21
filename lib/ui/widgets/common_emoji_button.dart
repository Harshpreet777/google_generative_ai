
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonEmojiPicker extends StatelessWidget {
  CommonEmojiPicker(
      {super.key, required this.controller, required this.onEmojiSelected});
  TextEditingController? controller;
  void Function(Category?, Emoji)? onEmojiSelected;

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
        textEditingController: controller, onEmojiSelected: onEmojiSelected);
  }
}
