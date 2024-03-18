import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      this.suffixWidget,
      this.widget,
      required this.onEditingComplete,
      required this.controller});
  void Function()? onEditingComplete;
  TextEditingController controller;
  Widget? widget;
  Widget? suffixWidget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixWidget,
            prefixIcon: widget,
            filled: true,
            fillColor: ColorConstants.white,
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
      ),
    );
  }
}
