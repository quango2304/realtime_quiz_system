import 'package:openapi/api.dart';

abstract class UserRepositoryInterface {
  Future<UserResponse?> createUser(NewUserRequest newUserRequest);
}