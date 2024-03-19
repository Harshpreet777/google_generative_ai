import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/model/chat_model.dart';
import 'package:gemini_demo/core/viewmodel/chats_view_model.dart';
import 'package:gemini_demo/ui/views/base_view.dart';
import 'package:gemini_demo/ui/widgets/common_text_form_field.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  ChatView({super.key});
  ChatViewModel? model;

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return SafeArea(child: Scaffold(body: chatMethod()));
      },
    );
  }

  Widget chatMethod() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: model?.scrollController,
            shrinkWrap: true,
            itemCount: model?.msgList.length,
            itemBuilder: (context, index) {
              ChatModel? data;
              if (model?.msgList[index] != null) {
                data = model?.msgList[index];
              }
              return Align(
                alignment: data?.role == 'user'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: data?.role == 'user'
                          ? ColorConstants.blue
                          : ColorConstants.green,
                      child: Text(
                        data?.text ?? "",
                        style: TextStyle(
                            color: ColorConstants.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormFieldWidget(
                  onEditingComplete: () {
                    if (model?.messageController.text.isNotEmpty ?? false) {
                      model?.getData(model?.messageController.text ?? '');
                    }
                    model?.messageController.clear();
                  },
                  controller: model?.messageController),
            ),
            model?.isLoading == true
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      if (model?.messageController.text.isNotEmpty ?? false) {
                        model?.getData(model?.messageController.text ?? '');
                      }
                      model?.messageController.clear();
                    },
                    icon: const Icon(Icons.send)),
          ],
        )
      ],
    );
  }
}
