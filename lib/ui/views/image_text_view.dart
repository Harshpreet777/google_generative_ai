import 'dart:io';

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
  ImageTextViewModel? model;
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
            controller: model?.scrollController,
            shrinkWrap: true,
            itemCount: model?.imageTextList.length,
            itemBuilder: (context, index) {
              ImageTextModel? data;
              if (model?.imageTextList[index] != null) {
                data = model?.imageTextList[index];
              }
              return Align(
                alignment: data?.role == 'user'
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
                        crossAxisAlignment: data?.role == 'user'
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: data?.role == 'user'
                                ? const EdgeInsets.symmetric(horizontal: 20)
                                : const EdgeInsets.all(0),
                            child: Text(
                              data?.text ?? '',
                              style: TextStyle(
                                  color: ColorConstants.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          data?.photo != null
                              ? Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.file(
                                      data?.photo ?? File(''),
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
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorConstants.black),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    model?.photo != null
                        ? TextFormFieldWidget(
                            onEditingComplete: () {
                              if (model?.messageController.text.isNotEmpty ??
                                  false) {
                                model?.getImageText();
                                model?.messageController.clear();
                              }
                            },
                            controller: model?.messageController)
                        : const SizedBox(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: model?.photo != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.file(
                                    model?.photo ?? File(''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        model?.photo == null
                            ? Expanded(
                                child: TextFormFieldWidget(
                                    onEditingComplete: () {
                                      if (model?.messageController.text
                                              .isNotEmpty ??
                                          false) {
                                        model?.getImageText();
                                        model?.messageController.clear();
                                      }
                                    },
                                    controller: model?.messageController),
                              )
                            : const SizedBox(),
                        IconButton(
                            onPressed: () {
                              _showPicker(context);
                            },
                            icon: Icon(
                              Icons.photo,
                              color: ColorConstants.black,
                            )),
                        model?.isLoading == true
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  if (model
                                          ?.messageController.text.isNotEmpty ??
                                      false) {
                                    model?.getImageText();
                                    model?.messageController.clear();
                                  }
                                },
                                icon: const Icon(Icons.send)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                        model?.imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text(StringConstants.camera),
                    onTap: () {
                      model?.imgFromCamera();

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
