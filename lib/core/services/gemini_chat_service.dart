import 'dart:developer';

import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService{
  static Future geminiData()async{
  final gemini=Gemini.instance;
    gemini.streamGenerateContent('Utilizing Google Ads in Flutter')
  .listen((value) {
    log(value.output.toString());
  }).onError((e) {
    log('streamGenerateContent exception', error: e);
  });

  }
}