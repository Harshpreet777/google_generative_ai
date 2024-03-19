import 'package:gemini_demo/core/services/google_generative_service.dart';
import 'package:gemini_demo/core/viewmodel/chats_view_model.dart';
import 'package:gemini_demo/core/viewmodel/home_view_model.dart';
import 'package:gemini_demo/core/viewmodel/image_text_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
setUpLocator() {
  locator.registerLazySingleton(() => ChatViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(()=>ImageTextViewModel());
  locator.registerLazySingleton(() => GoogleGenerative());
}
