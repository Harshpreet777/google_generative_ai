import 'dart:developer';

import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static Future<String> geminiData(String message) async {
    try {
      final gemini = Gemini.instance;

      String data =
          await gemini.text(message).then((value) => value?.output ?? '');
      return data;
    } catch (e) {
      log("Error is $e");
    }
    return '';
  }
}
