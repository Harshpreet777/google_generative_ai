
import 'dart:io';

class ImageTextModel {
  String text;
  String role;
  File? photo;
  ImageTextModel({this.photo,required this.role, required this.text});
}
