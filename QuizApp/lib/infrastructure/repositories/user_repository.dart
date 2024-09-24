import 'package:openapi/api.dart';
import 'package:injectable/injectable.dart';
import 'package:quizz_app/domain/repositories/user_repository_interface.dart';

@LazySingleton(as: UserRepositoryInterface)
class UserRepositoryImpl implements UserRepositoryInterface {
  final UserApiClient _userApiClient;

  UserRepositoryImpl(this._userApiClient);

  @override
  Future<UserResponse?> createUser(NewUserRequest newUserRequest) async {
    return await _userApiClient.createUser(newUserRequest);
  }
}