import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/constants/image_constants.dart';
import 'package:gemini_demo/ui/widgets/common_sized_box.dart';

// ignore: must_be_immutable
class CommonMenuButton extends StatelessWidget {
  CommonMenuButton({super.key, required this.onTap});
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CommonSizedBox(
      height: 22,
      width: 22,
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          ImageConstant.clipIcon,
          color: ColorConstants.white38,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
