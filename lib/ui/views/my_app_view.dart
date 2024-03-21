import 'package:flutter/material.dart';
import 'package:gemini_demo/core/routing/router.dart';
import 'package:gemini_demo/core/routing/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: PageRouter.generateRoute,
      initialRoute: Routes.chatRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
