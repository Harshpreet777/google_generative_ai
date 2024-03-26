import 'dart:developer';
import 'dart:io';

import 'package:gemini_demo/core/constants/api_constants.dart';
import 'package:gemini_demo/core/model/chat_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GoogleGenerativeServices {
  Future<String> getText(String message) async {
    String result = '';
    try {
      final model =
          GenerativeModel(model: 'gemini-pro', apiKey: ApiConstant.apiToken);
      final prompts = message;
      final content = [Content.text(prompts)];
      final response = await model.generateContent(content);
      content.first.role;

      result = response.text ?? '';
      return result;
    } catch (e) {
      log("Error is $e");
    }
    return '';
  }

  Future<ChatModel?> getTextFromImage(File photo, String message) async {
    try {
      final model = GenerativeModel(
          model: 'gemini-pro-vision', apiKey: ApiConstant.apiToken);

      final prompt = TextPart(message);
      final imageParts = [
        DataPart('image/jpeg', await photo.readAsBytes()),
      ];
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);
      log(response.text.toString());
      return ChatModel(
          role: response.candidates.first.content.role.toString(),
          text: response.text.toString());
    } catch (e) {
      log("Error is $e");
    }
    return null;
  }
}
