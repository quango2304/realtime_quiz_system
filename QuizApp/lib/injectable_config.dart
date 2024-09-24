import 'dart:io';

import "package:get_it/get_it.dart";
import 'package:injectable/injectable.dart';
import 'package:openapi/api.dart';
import 'package:quizz_app/infrastructure/services/quiz_session_service.dart';
import 'package:quizz_app/injectable_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  ApiClient apiClient() => ApiClient(
      basePath: 'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:5045');

  @lazySingleton
  QuizApiClient quizClient(ApiClient apiClient) => QuizApiClient(apiClient);

  @lazySingleton
  UserApiClient userClient(ApiClient apiClient) => UserApiClient(apiClient);

  @injectable
  QuizHubService quizHubService() => QuizHubService(
      'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:5045/quizHub');
}
