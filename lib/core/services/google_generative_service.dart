import 'dart:developer';
import 'dart:io';

import 'package:gemini_demo/core/model/image_text_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GoogleGenerative {
  static const apiKey = 'AIzaSyAJmsxI7u2G96u2S9bj8us3lfXU5CwGsdc';

  static Future<String> getData(String message) async {
    String result = '';
    try {
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
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

  static Future<ImageTextModel?> getImageText(
      File photo, String message) async {
    try {
      final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);

      final prompt = TextPart(message);
      final imageParts = [
        DataPart('image/jpeg', await photo.readAsBytes()),
      ];
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);
      log(response.text.toString());
      return ImageTextModel(
          role: response.candidates.first.content.role.toString(),
          text: response.text.toString());
    } catch (e) {
      log("Error is $e");
    }
    return null;
  }
}
