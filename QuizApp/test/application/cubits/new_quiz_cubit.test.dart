import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quizz_app/application/cubits/new_quiz_cubit/new_quiz_cubit.dart';
import 'package:quizz_app/domain/repositories/quiz_repository_interface.dart';
import 'package:quizz_app/infrastructure/services/quiz_session_service.dart';
import 'package:openapi/api.dart';

class MockQuizRepository extends Mock implements QuizRepositoryInterface {}
class MockQuizHubService extends Mock implements QuizHubService {}

void main() {
  group('NewQuizCubit', () {
    late NewQuizCubit newQuizCubit;
    late MockQuizRepository mockQuizRepository;
    late MockQuizHubService mockQuizHubService;

    setUp(() {
      mockQuizRepository = MockQuizRepository();
      mockQuizHubService = MockQuizHubService();
      newQuizCubit = NewQuizCubit(mockQuizRepository, mockQuizHubService);
      when(() => mockQuizHubService.stopConnection()).thenAnswer((_) async {});
    });

    tearDown(() {
      newQuizCubit.close();
    });

    final newQuizRequest = NewQuizRequest(
      title: 'Sample Quiz',
      userId: 'user123',
      questions: [],
    );

    final quizResponse = QuizResponse(
      quizId: 1,
      title: 'Sample Quiz',
      createdAt: DateTime.now(),
      questions: [],
    );

    blocTest<NewQuizCubit, NewQuizState>(
      'emits [NewQuizCreating, NewQuizCreateSuccess] when createQuiz is successful',
      build: () {
        when(() => mockQuizRepository.createQuiz(newQuizRequest)).thenAnswer((_) => Future.value(quizResponse));
        return newQuizCubit;
      },
      act: (cubit) => cubit.createQuiz(newQuizRequest),
      expect: () => [
        NewQuizCreating(),
        NewQuizCreateSuccess(quizResponse),
      ],
    );

    blocTest<NewQuizCubit, NewQuizState>(
      'emits [NewQuizCreating, NewQuizCreateFailure] when createQuiz fails',
      build: () {
        when(() => mockQuizRepository.createQuiz(newQuizRequest)).thenThrow(Exception('Quiz creation failed'));
        return newQuizCubit;
      },
      act: (cubit) => cubit.createQuiz(newQuizRequest),
      expect: () => [
        NewQuizCreating(),
        isA<NewQuizCreateFailure>(),
      ],
    );

    blocTest<NewQuizCubit, NewQuizState>(
      'emits [NewQuizStarting, NewQuizStartSuccess] when startQuiz is successful',
      build: () {
        when(() => mockQuizRepository.startQuiz(1)).thenAnswer((_) async {});
        return newQuizCubit;
      },
      act: (cubit) => cubit.startQuiz(1),
      expect: () => [
        NewQuizStarting(),
        NewQuizStartSuccess(),
      ],
    );

    blocTest<NewQuizCubit, NewQuizState>(
      'emits [NewQuizStarting, NewQuizStartFailure] when startQuiz fails',
      build: () {
        when(() => mockQuizRepository.startQuiz(1)).thenThrow(Exception('Quiz start failed'));
        return newQuizCubit;
      },
      act: (cubit) => cubit.startQuiz(1),
      expect: () => [
        NewQuizStarting(),
        isA<NewQuizStartFailure>(),
      ],
    );

    blocTest<NewQuizCubit, NewQuizState>(
      'emits [NewQuizPlayerListUpdated] when listenToPlayersJoined is called',
      build: () {
        when(() => mockQuizHubService.startConnection()).thenAnswer((_) async {});
        when(() => mockQuizHubService.joinQuiz(1, 'user123')).thenAnswer((_) async {});
        when(() => mockQuizHubService.onUpdatePlayerList(any())).thenAnswer((invocation) {
          final callback = invocation.positionalArguments[0] as Function(List<String>);
          callback(['player1', 'player2']);
        });
        return newQuizCubit;
      },
      act: (cubit) => cubit.listenToPlayersJoined(1, 'user123'),
      expect: () => [
        const NewQuizPlayerListUpdated(['player1', 'player2']),
      ],
    );
  });
}