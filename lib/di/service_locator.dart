import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:test_contact_us/data/repository.dart';
import 'package:test_contact_us/main_viewmodel.dart';

import '../data/api_service.dart';
import '../domain/use_case/send_data_use_case.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => ApiService(locator<Dio>()));
  locator.registerLazySingleton(() => Repository(locator<ApiService>()));
  locator.registerLazySingleton(() => SendDataUseCase(locator<Repository>()));
  locator.registerFactory(() => MainViewModel(
    sendDataUseCase: locator<SendDataUseCase>(),
  ));
}