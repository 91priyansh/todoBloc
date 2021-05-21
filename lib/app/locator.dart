import 'package:bloc_example/app/appConfig.dart';
import 'package:get_it/get_it.dart';

GetIt _getIt = GetIt.instance;

void setup(AppConfig config) {
  _getIt.registerSingleton<AppConfig>(config);
}
