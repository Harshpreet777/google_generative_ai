import 'package:flutter/material.dart';
import 'package:gemini_demo/core/model/chat_model.dart';
import 'package:gemini_demo/core/services/google_generative_service.dart';
import 'package:gemini_demo/core/viewmodel/base_model.dart';

class ChatViewModel extends BaseModel {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<ChatModel> msgList = [];
  bool isLoading = false;

  loading(bool value) {
    isLoading = value;
    updateUI();
  }

  getData(String message) async {
    loading(true);
    msgList.add(ChatModel(role: 'user', text: messageController.text));
    scrollController.animateTo(scrollController.position.maxScrollExtent+80,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    updateUI();

    String data = await GoogleGenerative.getData(message);
    msgList.add(ChatModel(role: 'model', text: data));

    loading(false);
    scrollController.animateTo(scrollController.position.maxScrollExtent+80,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
updateUI();
  }
}
