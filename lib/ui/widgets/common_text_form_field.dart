import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/constants/string_constants.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      this.suffixIconWidget,
      this.prefixIconWidget,
      required this.onEditingComplete,
      this.controller});
  void Function()? onEditingComplete;
  TextEditingController? controller;
  Widget? prefixIconWidget;
  Widget? suffixIconWidget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        style: TextStyle(color: ColorConstants.black),
        onEditingComplete: onEditingComplete,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixIconWidget,
            prefixIcon: prefixIconWidget,
            filled: true,
            hintText: StringConstants.textFieldHint,
            fillColor: ColorConstants.white,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)))),
      ),
    );
  }
}
