// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:openapi/api.dart' as _i940;
import 'package:quizz_app/application/cubits/new_quiz_cubit/new_quiz_cubit.dart'
    as _i96;
import 'package:quizz_app/application/cubits/quiz_session_cubit/quiz_session_cubit.dart'
    as _i729;
import 'package:quizz_app/application/cubits/user_cubit/user_cubit.dart'
    as _i381;
import 'package:quizz_app/domain/repositories/quiz_repository_interface.dart'
    as _i715;
import 'package:quizz_app/domain/repositories/user_repository_interface.dart'
    as _i678;
import 'package:quizz_app/infrastructure/repositories/quiz_repository.dart'
    as _i244;
import 'package:quizz_app/infrastructure/repositories/user_repository.dart'
    as _i820;
import 'package:quizz_app/infrastructure/services/quiz_session_service.dart'
    as _i668;
import 'package:quizz_app/injectable_config.dart' as _i107;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i668.QuizHubService>(() => registerModule.quizHubService());
    gh.lazySingleton<_i940.ApiClient>(() => registerModule.apiClient());
    gh.lazySingleton<_i940.QuizApiClient>(
        () => registerModule.quizClient(gh<_i940.ApiClient>()));
    gh.lazySingleton<_i940.UserApiClient>(
        () => registerModule.userClient(gh<_i940.ApiClient>()));
    gh.lazySingleton<_i678.UserRepositoryInterface>(
        () => _i820.UserRepositoryImpl(gh<_i940.UserApiClient>()));
    gh.lazySingleton<_i715.QuizRepositoryInterface>(
        () => _i244.QuizRepository(gh<_i940.QuizApiClient>()));
    gh.lazySingleton<_i381.UserCubit>(
        () => _i381.UserCubit(gh<_i678.UserRepositoryInterface>()));
    gh.factory<_i729.QuizSessionCubit>(() => _i729.QuizSessionCubit(
          gh<_i668.QuizHubService>(),
          gh<_i715.QuizRepositoryInterface>(),
        ));
    gh.factory<_i96.NewQuizCubit>(() => _i96.NewQuizCubit(
          gh<_i715.QuizRepositoryInterface>(),
          gh<_i668.QuizHubService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i107.RegisterModule {}
