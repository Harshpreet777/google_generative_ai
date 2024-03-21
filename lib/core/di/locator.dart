import 'package:gemini_demo/core/services/google_generative_service.dart';
import 'package:gemini_demo/core/viewmodel/chat_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
setUpLocator() {
  locator.registerLazySingleton(()=>ImageTextViewModel());
  locator.registerLazySingleton(() => GoogleGenerative());
}
