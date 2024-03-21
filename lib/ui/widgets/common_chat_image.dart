import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonChatImage extends StatelessWidget {
  CommonChatImage({super.key, required this.file});
  File file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: Image.file(
          file,
          height: 200,
          width: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
