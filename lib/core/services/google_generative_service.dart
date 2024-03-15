import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';

class GoogleGenerative {
  static const apiKey = 'AIzaSyAJmsxI7u2G96u2S9bj8us3lfXU5CwGsdc';

  static Future<String> getData(String message) async {
    try {
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final prompts = message;
      final content = [Content.text(prompts)];
      final response = await model.generateContent(content);

      return response.text ?? '';
    } catch (e) {
      log("Error is $e");
    }
    return '';
  }
}
