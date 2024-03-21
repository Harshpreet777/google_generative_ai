import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/constants/string_constants.dart';
import 'package:gemini_demo/ui/widgets/common_pop_up_items.dart';

// ignore: must_be_immutable
class PopUpMenuWidget extends StatelessWidget {
  PopUpMenuWidget({super.key, required this.onTapGalley,required this.onTapCamera});
  void Function()? onTapGalley;
  void Function()? onTapCamera;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
        child: Container(
          decoration: const BoxDecoration(
              color: ColorConstants.green3D4354,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonPopUpItems(
                  text: StringConstants.galley,
                  onTap: onTapGalley,
                  colorsList: [
                    ColorConstants.blueAccent700,
                    ColorConstants.blue
                  ],
                  icon: Icons.photo_library),
              CommonPopUpItems(
                  text: StringConstants.camera,
                  onTap: onTapCamera,
                  colorsList: const [
                    ColorConstants.pinkAccent,
                    ColorConstants.red
                  ],
                  icon: Icons.photo_camera),
            ],
          ),
        ),
      ),
    );
  }
}
