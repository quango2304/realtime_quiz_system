import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/api.dart';
import 'package:quizz_app/domain/repositories/user_repository_interface.dart';

part 'user_state.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  final UserRepositoryInterface _userRepository;

  UserCubit(this._userRepository) : super(UserInitial());

  Future<void> createUser(NewUserRequest newUserRequest) async {
    try {
      emit(UserLoading());
      final user = await _userRepository.createUser(newUserRequest);
      if (user != null) {
        emit(UserSuccess(user));
      } else {
        emit(const UserFailure('User creation failed'));
      }
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  String getCurrentUserId() {
    final state = this.state;
    if (state is UserSuccess) {
      return state.user.userId!;
    }
    return '';
  }

  String getCurrentUserName() {
    final state = this.state;
    if (state is UserSuccess) {
      return state.user.name!;
    }
    return '';
  }
}