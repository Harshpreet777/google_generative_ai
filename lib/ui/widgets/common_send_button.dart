import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';

// ignore: must_be_immutable
class CommonIconSendButton extends StatelessWidget {
  CommonIconSendButton({super.key, required this.onPressed});
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.send,
          color: ColorConstants.white38,
        ));
  }
}
