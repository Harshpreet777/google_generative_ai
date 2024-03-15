import 'package:gemini_demo/core/viewmodel/base_model.dart';

class HomeViewModel extends BaseModel{
  int indexNumber=0;
  changeValue(int value){
    indexNumber=value;
    updateUI();
  }
}