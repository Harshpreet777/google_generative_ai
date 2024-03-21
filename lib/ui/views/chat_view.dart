import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/constants/image_constants.dart';
import 'package:gemini_demo/core/constants/string_constants.dart';
import 'package:gemini_demo/core/model/image_text_model.dart';
import 'package:gemini_demo/core/viewmodel/chat_view_model.dart';
import 'package:gemini_demo/ui/views/base_view.dart';
import 'package:gemini_demo/ui/widgets/common_emoji_button.dart';
import 'package:gemini_demo/ui/widgets/common_emoji_icon_button.dart';
import 'package:gemini_demo/ui/widgets/common_image_asset.dart';
import 'package:gemini_demo/ui/widgets/common_pop_up_image.dart';
import 'package:gemini_demo/ui/widgets/common_pop_up_menu.dart';
import 'package:gemini_demo/ui/widgets/common_sized_box.dart';
import 'package:gemini_demo/ui/widgets/common_text.dart';
import 'package:gemini_demo/ui/widgets/message_body.dart';
import 'package:gemini_demo/ui/widgets/message_field.dart';

// ignore: must_be_immutable
class ImageTextView extends StatelessWidget {
  ImageTextView({super.key});
  ImageTextViewModel? model;

  @override
  Widget build(BuildContext context) {
    return BaseView<ImageTextViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return SafeArea(
            child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            model.keyboardAppear(false);
            model.showEmojiPicker(false);
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      ImageConstant.backGroundImage,
                    ))),
            child: Scaffold(
              backgroundColor: ColorConstants.transparent,
              body: buildBody(context),
            ),
          ),
        ));
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        CommonSizedBox(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CircleAvatar(
                radius: 27,
                child: CommonImageAssetWidget(
                  image: ImageConstant.avatarImg,
                ),
              ),
            ),
            CommonText(
              text: StringConstants.chatAppTitle,
              color: ColorConstants.white,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        CommonSizedBox(height: 20),
        chatMessageBuilder(),
        MessageField(
            imageTextViewModel: model,
            onClipTap: () {
              _showPicker(context);
              model?.setEmojiPicker = false;
            },
            emojiWiget: emojiButtonBuild(context)),
        model?.isEmojiPicker == true
            ? Expanded(child: emojiPicker(context))
            : CommonSizedBox()
      ],
    );
  }

  CommonEmojiButton emojiButtonBuild(BuildContext context) {
    return CommonEmojiButton(
      onPressed: () {
        model?.showEmojiPicker(true);
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget chatMessageBuilder() {
    return Expanded(
      child: ListView.builder(
        controller: model?.scrollController,
        shrinkWrap: true,
        itemCount: model?.imageTextList.length,
        itemBuilder: (context, index) {
          int last = (model?.imageTextList.length ?? 0);
          ImageTextModel? data;
          if (model?.imageTextList[index] != null) {
            data = model?.imageTextList[index];
          }
          bool isLoading =
              index + 1 == last && data?.role != 'user' && data?.text == '';
          return MessageBody(imageTextModel: data, isLoading: isLoading);
        },
      ),
    );
  }

  Widget emojiPicker(BuildContext context) {
    return CommonEmojiPicker(
      controller: model?.messageController,
      onEmojiSelected: (Category? category, Emoji emoji) {
        (model?.messageController.text ?? '') + emoji.emoji;
      },
    );
  }

  _showPicker(context) {
    showModalBottomSheet(
        backgroundColor: ColorConstants.transparent,
        context: context,
        builder: (BuildContext context) {
          return CommonPopUpMenu(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CommonPopUpImage(
                    text: StringConstants.galley,
                    onTap: () {
                      model?.imgFromGallery();
                      Navigator.of(context).pop();
                    },
                    colorsList: [
                      ColorConstants.blueAccent700,
                      ColorConstants.blue
                    ],
                    icon: Icons.photo_library),
                CommonPopUpImage(
                    text: StringConstants.camera,
                    onTap: () {
                      model?.imgFromCamera();
                      Navigator.pop(context);
                    },
                    colorsList: [ColorConstants.pinkAccent, ColorConstants.red],
                    icon: Icons.photo_camera),
              ],
            ),
          );
        });
  }
}
