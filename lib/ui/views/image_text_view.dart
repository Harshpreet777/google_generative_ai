import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/viewmodel/image_text_view_model.dart';
import 'package:gemini_demo/ui/views/base_view.dart';
import 'package:gemini_demo/ui/widgets/common_text_form_field.dart';

// ignore: must_be_immutable
class ImageTextView extends StatelessWidget {
  ImageTextView({super.key});
  late ImageTextViewModel model;
  @override
  Widget build(BuildContext context) {
    return BaseView<ImageTextViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return SafeArea(
            child: Scaffold(
          body: buildBody(),
        ));
      },
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: ColorConstants.blue,
                      child: Text(
                        'hello',
                        style: TextStyle(
                            color: ColorConstants.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormFieldWidget(
                  onEditingComplete: () {
                    model.messageController.clear();
                  },
                  controller: model.messageController),
            ),
            // model.isLoading == true
            //     ? const Padding(
            //       padding:  EdgeInsets.symmetric(horizontal: 5),
            //       child:  Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //     )
            // :
            IconButton(
                onPressed: () {
                  model.messageController.clear();
                },
                icon: const Icon(Icons.send)),
          ],
        )
      ],
    );
  }
}
