import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';

// ignore: must_be_immutable
class CommonPopUpMenu extends StatelessWidget {
  CommonPopUpMenu({super.key, required this.widget});
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
        child: Container(
            decoration: BoxDecoration(
                color: ColorConstants.green3D4354,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            height: 150,
            child: widget),
      ),
    );
  }
}
