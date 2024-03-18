import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gemini_demo/core/constants/color_constant.dart';
import 'package:gemini_demo/core/constants/string_constants.dart';
import 'package:gemini_demo/core/model/image_text_model.dart';
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
          body: buildBody(context),
        ));
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: model.imageTextList.length,
            itemBuilder: (context, index) {
              ImageTextModel data = model.imageTextList[index];
              log(data.role);
              return Align(
                alignment: data.role == 'user'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: ColorConstants.blue,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: data.role == 'user'
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.text,
                            style: TextStyle(
                                color: ColorConstants.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          data.photo != null
                              ? Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.file(
                                      data.photo!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
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
                  suffixWidget: model.photo != null
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(
                              model.photo!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(),
                  widget: IconButton(
                      onPressed: () {
                        _showPicker(context);
                      },
                      icon: Icon(
                        Icons.photo,
                        color: ColorConstants.black,
                      )),
                  onEditingComplete: () {
                    model.getImageText();
                    model.messageController.clear();
                  },
                  controller: model.messageController),
            ),
            model.isLoading == true
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      model.getImageText();
                      model.messageController.clear();
                    },
                    icon: const Icon(Icons.send)),
          ],
        )
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              child: Wrap(
                children: [
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text(StringConstants.galley),
                      onTap: () {
                        model.imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text(StringConstants.camera),
                    onTap: () {
                      model.imgFromCamera();

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
