import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quizz_app/application/cubits/user_cubit/user_cubit.dart';
import 'package:quizz_app/domain/repositories/user_repository_interface.dart';
import 'package:openapi/api.dart';

class MockUserRepository extends Mock implements UserRepositoryInterface {}

void main() {
  group('UserCubit', () {
    late UserCubit userCubit;
    late MockUserRepository mockUserRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      userCubit = UserCubit(mockUserRepository);
    });

    tearDown(() {
      userCubit.close();
    });

    final newUserRequest = NewUserRequest(
      name: 'John Doe',
      email: 'john.doe@example.com',
    );

    final userResponse = UserResponse(
      userId: 'user123',
      name: 'John Doe',
      email: 'john.doe@example.com',
    );

    blocTest<UserCubit, UserState>(
      'emits [UserLoading, UserSuccess] when createUser is successful',
      build: () {
        when(() => mockUserRepository.createUser(newUserRequest)).thenAnswer((_) async => userResponse);
        return userCubit;
      },
      act: (cubit) => cubit.createUser(newUserRequest),
      expect: () => [
        UserLoading(),
        UserSuccess(userResponse),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserLoading, UserFailure] when createUser fails',
      build: () {
        when(() => mockUserRepository.createUser(newUserRequest)).thenThrow(Exception('User creation failed'));
        return userCubit;
      },
      act: (cubit) => cubit.createUser(newUserRequest),
      expect: () => [
        UserLoading(),
        isA<UserFailure>(),
      ],
    );
  });
}