import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/model/image_text_model.dart';
import 'package:gemini_demo/ui/widgets/common_chat_image.dart';
import 'package:gemini_demo/ui/widgets/common_sized_box.dart';
import 'package:gemini_demo/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class MessageBody extends StatelessWidget {
  MessageBody(
      {super.key, required this.imageTextModel, required this.isLoading});
  ImageTextModel? imageTextModel;
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: imageTextModel?.role == 'user'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: imageTextModel?.role == 'user'
                ? const EdgeInsets.only(top: 10, right: 15)
                : const EdgeInsets.only(
                    left: 15, right: 70, top: 10, bottom: 10),
            child: ClipRRect(
              borderRadius: imageTextModel?.role == 'user'
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: imageTextModel?.role == 'user'
                    ? ColorConstants.userColor
                    : ColorConstants.modelColor,
                child: isLoading == true
                    ? LoadingAnimationWidget.waveDots(
                        color: ColorConstants.white, size: 30)
                    : CommonText(
                        text: imageTextModel?.text ?? '',
                        color: ColorConstants.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
              ),
            ),
          ),
          imageTextModel?.photo != null
              ? CommonChatImage(file: imageTextModel?.photo ?? File(''))
              : CommonSizedBox()
        ],
      ),
    );
  }
}
