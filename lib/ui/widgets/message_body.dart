import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/constants/string_constants.dart';
import 'package:gemini_demo/core/model/chat_model.dart';
import 'package:gemini_demo/ui/widgets/common_image.dart';
import 'package:gemini_demo/ui/widgets/common_sized_box.dart';
import 'package:gemini_demo/ui/widgets/common_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class MessageBody extends StatelessWidget {
  MessageBody({super.key, required this.chatModel, required this.isLoading});
  ChatModel? chatModel;
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatModel?.role == StringConstants.user
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: chatModel?.role == StringConstants.user
                ? const EdgeInsets.only(top: 10, right: 15, left: 70)
                : const EdgeInsets.only(
                    left: 15, right: 70, top: 10, bottom: 10),
            child: ClipRRect(
              borderRadius: chatModel?.role == StringConstants.user
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
                color: chatModel?.role == StringConstants.user
                    ? ColorConstants.grey7A8194
                    : ColorConstants.green373E4E,
                child: isLoading == true
                    ? LoadingAnimationWidget.waveDots(
                        color: ColorConstants.white, size: 30)
                    : CommonText(
                        text: chatModel?.text ?? '',
                        color: ColorConstants.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
              ),
            ),
          ),
          chatModel?.photo != null
              ? CommonImages(
                  bottomLeft: 20,
                  topLeft: 20,
                  bottomRight: 20,
                  file: chatModel?.photo ?? File(''),
                )
              : CommonSizedBox()
        ],
      ),
    );
  }
}
