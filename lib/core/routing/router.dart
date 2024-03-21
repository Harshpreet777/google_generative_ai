import 'package:flutter/material.dart';
import 'package:gemini_demo/core/routing/routes.dart';
import 'package:gemini_demo/ui/views/chat_view.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.chatRoute:
        return MaterialPageRoute(builder: (context) => CharView());

      default:
        return MaterialPageRoute(
            builder: (BuildContext conktext) => const Scaffold(
                  body: Text('This Page does not Exist'),
                ));
    }
  }
}
