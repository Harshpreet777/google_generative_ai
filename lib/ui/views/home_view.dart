import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gemini_demo/core/model/drop_down_model.dart';
import 'package:gemini_demo/core/viewmodel/home_view_model.dart';
import 'package:gemini_demo/ui/views/base_view.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
   HomeViewModel? model;
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return SafeArea(child: Scaffold(body: dropDownMethod()));
      },
    );
  }

  Widget dropDownMethod() {
    return Column(children: [
      DropdownButton<int>(
          value: model?.indexNumber,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (value) {
            model?.changeValue(value ?? 0);
          },
          items: List.generate(
              dropDownList.length,
              (index) => DropdownMenuItem<int>(
                  value: index, child: Text(dropDownList[index].title)))),
      Expanded(
          child: IndexedStack(
              index: model?.indexNumber,
              children:dropDownList.map((value)=>value.widget).toList()
              ))
    ]);
  }
}
