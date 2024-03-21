import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/constants/image_constants.dart';
import 'package:gemini_demo/core/viewmodel/chat_view_model.dart';
import 'package:gemini_demo/ui/widgets/common_chat_image.dart';
import 'package:gemini_demo/ui/widgets/common_image_asset.dart';
import 'package:gemini_demo/ui/widgets/common_send_button.dart';
import 'package:gemini_demo/ui/widgets/common_sized_box.dart';
import 'package:gemini_demo/ui/widgets/common_text_form_field.dart';

// ignore: must_be_immutable
class MessageField extends StatelessWidget {
  MessageField(
      {super.key,
      required this.imageTextViewModel,
      required this.onClipTap,
      required this.emojiWiget});
  ImageTextViewModel? imageTextViewModel;
  void Function()? onClipTap;
  Widget emojiWiget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: ColorConstants.black),
                color: ColorConstants.modelColor,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                imageTextViewModel?.photo != null
                    ? CommonTextFormField(
                        onEditingComplete: () {
                          if (imageTextViewModel
                                  ?.messageController.text.isNotEmpty ??
                              false) {
                            imageTextViewModel?.getImageText();
                            imageTextViewModel?.messageController.clear();
                          }
                        },
                        controller: imageTextViewModel?.messageController)
                    : CommonSizedBox(),
                Align(
                  alignment: Alignment.topLeft,
                  child: imageTextViewModel?.photo != null
                      ? CommonChatImage(
                          file: imageTextViewModel?.photo ?? File(''),
                        )
                      : CommonSizedBox(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    imageTextViewModel?.photo == null
                        ? Expanded(
                            child: CommonTextFormField(
                                onTap: () {
                                  imageTextViewModel?.keyboardAppear(true);
                                  imageTextViewModel?.showEmojiPicker(false);
                                },
                                suffixIconWidget: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CommonSizedBox(
                                      height: 22,
                                      width: 22,
                                      child: InkWell(
                                          onTap: onClipTap,
                                          child: CommonImageAssetWidget(
                                            color: ColorConstants.white38,
                                            image: ImageConstant.clipIcon,
                                          )),
                                    ),
                                    CommonSizedBox(
                                      width: 10,
                                    ),
                                    CommonIconSendButton(
                                      onPressed: () {
                                        if (imageTextViewModel
                                                ?.messageController
                                                .text
                                                .isNotEmpty ??
                                            false) {
                                          imageTextViewModel?.getImageText();
                                          imageTextViewModel?.messageController
                                              .clear();
                                        }
                                      },
                                    )
                                  ],
                                ),
                                prefixIconWidget: emojiWiget,
                                onEditingComplete: () {
                                  if (imageTextViewModel
                                          ?.messageController.text.isNotEmpty ??
                                      false) {
                                    imageTextViewModel?.getImageText();
                                    imageTextViewModel?.messageController
                                        .clear();
                                  }
                                },
                                controller:
                                    imageTextViewModel?.messageController),
                          )
                        : CommonSizedBox(),
                  ],
                ),
                imageTextViewModel?.photo != null
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          emojiWiget,
                          CommonSizedBox(
                            width: 10,
                          ),
                          CommonSizedBox(
                            height: 22,
                            width: 22,
                            child: InkWell(
                              onTap: onClipTap,
                              child: CommonImageAssetWidget(
                                image: ImageConstant.clipIcon,
                                color: ColorConstants.white38,
                              ),
                            ),
                          ),
                          CommonSizedBox(
                            width: 10,
                          ),
                          CommonIconSendButton(
                            onPressed: () {
                              if (imageTextViewModel
                                      ?.messageController.text.isNotEmpty ??
                                  false) {
                                imageTextViewModel?.getImageText();
                                imageTextViewModel?.messageController.clear();
                              }
                            },
                          ),
                        ],
                      )
                    : CommonSizedBox()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
