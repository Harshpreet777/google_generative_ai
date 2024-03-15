import 'package:flutter/material.dart';
import 'package:gemini_demo/core/model/drop_down_model.dart';
import 'package:gemini_demo/core/viewmodel/home_view_model.dart';
import 'package:gemini_demo/ui/views/base_view.dart';
import 'package:gemini_demo/ui/views/chat_view.dart';
import 'package:gemini_demo/ui/views/image_text_view.dart';
import 'package:gemini_demo/ui/views/text_view.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  late HomeViewModel model;
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return dropDownMethod();
      },
    );
  }

  SafeArea dropDownMethod() {
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
        DropdownButton<int>(
            value: model.indexNumber,
            icon: const Icon(Icons.arrow_downward),
            onChanged: (value) {
              model.changeValue(value ?? 0);
            },
            items: List.generate(
                dropDownList.length,
                (index) => DropdownMenuItem<int>(
                    value: index, child: Text(dropDownList[index].title)))),
        Expanded(
            child: IndexedStack(
                index: model.indexNumber,
                children: [ChatView(), const TextView(), ImageTextView()]))
      ])),
    );
  }
}
