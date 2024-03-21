import 'package:gemini_demo/core/repositories/api_services.dart';
import 'package:gemini_demo/core/viewmodel/chat_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
setUpLocator() {
  locator.registerLazySingleton(() => ChatViewModel());
  locator.registerLazySingleton(() => GoogleGenerativeServices());
}
