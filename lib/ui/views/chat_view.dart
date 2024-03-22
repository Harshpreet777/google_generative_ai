import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/constants/image_constants.dart';
import 'package:gemini_demo/core/constants/string_constants.dart';
import 'package:gemini_demo/core/model/chat_model.dart';
import 'package:gemini_demo/core/viewmodel/chat_view_model.dart';
import 'package:gemini_demo/ui/views/base_view.dart';
import 'package:gemini_demo/ui/widgets/common_emoji_icon_button.dart';
import 'package:gemini_demo/ui/widgets/pop_up_menu.dart';
import 'package:gemini_demo/ui/widgets/common_sized_box.dart';
import 'package:gemini_demo/ui/widgets/common_text.dart';
import 'package:gemini_demo/ui/widgets/message_body.dart';
import 'package:gemini_demo/ui/widgets/message_field.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class CharView extends StatelessWidget {
  CharView({super.key});
  ChatViewModel? model;

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatViewModel>(
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
            decoration: const BoxDecoration(
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
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.asset(
                  height: 45,
                  width: 45,
                  ImageConstant.googleAiIcon,
                  fit: BoxFit.fill,
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
        buildChatMessage(),
        MessageField(
            chatViewModel: model,
            onClipTap: () {
              _showPicker(context);
              model?.setEmojiPicker = false;
            },
            emojiWidget: CommonEmojiButton(
              onPressed: () {
                model?.showEmojiPicker(true);
                FocusScope.of(context).unfocus();
              },
            )),
        model?.isEmojiPicker == true
            ? Expanded(
                child: EmojiPicker(
                textEditingController: model?.messageController,
              ))
            : CommonSizedBox()
      ],
    );
  }

  Widget buildChatMessage() {
    return Expanded(
      child: ListView.builder(
        controller: model?.scrollController,
        shrinkWrap: true,
        itemCount: model?.chatList.length,
        itemBuilder: (context, index) {
          int last = (model?.chatList.length ?? 0);
          ChatModel? data;
          if (model?.chatList[index] != null) {
            data = model?.chatList[index];
          }
          bool isLoading = index + 1 == last &&
              data?.role != StringConstants.user &&
              data?.text == '';
          return MessageBody(chatModel: data, isLoading: isLoading);
        },
      ),
    );
  }

  _showPicker(context) {
    showModalBottomSheet(
        backgroundColor: ColorConstants.transparent,
        context: context,
        builder: (BuildContext context) {
          return PopUpMenuWidget(
            onTapCamera: () {
              model?.imgFromDevice(ImageSource.camera);
              Navigator.pop(context);
            },
            onTapGalley: () {
              model?.imgFromDevice(ImageSource.gallery);
              Navigator.pop(context);
            },
          );
        });
  }
}
