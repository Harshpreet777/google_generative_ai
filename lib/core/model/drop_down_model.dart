import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/string_constants.dart';
import 'package:gemini_demo/ui/views/chat_view.dart';
import 'package:gemini_demo/ui/views/image_text_view.dart';

class DropDownModel {
  DropDownModel(
      {required this.index, required this.title, required this.widget});
  String title;
  int index;
  Widget widget;
}
List<DropDownModel> dropDownList=[
  DropDownModel(index: 0, title:StringConstants.chat, widget: ChatView()),
  DropDownModel(index: 1, title: StringConstants.textImage, widget: ImageTextView())
];
