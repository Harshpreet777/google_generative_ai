import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonImageAssetWidget extends StatelessWidget {
  CommonImageAssetWidget({super.key, required this.image, this.color});
  String image;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      color: color,
      fit: BoxFit.fill,
    );
  }
}
