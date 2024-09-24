import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quizz_app/application/cubits/quiz_session_cubit/quiz_session_cubit.dart';
import 'package:quizz_app/domain/repositories/quiz_repository_interface.dart';
import 'package:openapi/api.dart';
import 'package:quizz_app/infrastructure/services/quiz_session_service.dart';

class MockQuizRepository extends Mock implements QuizRepositoryInterface {}
class MockQuizHubService extends Mock implements QuizHubService {}

void main() {
  group('QuizSessionCubit', () {
    late QuizSessionCubit quizSessionCubit;
    late MockQuizRepository mockQuizRepository;
    late MockQuizHubService mockQuizHubService;

    setUp(() {
      mockQuizRepository = MockQuizRepository();
      mockQuizHubService = MockQuizHubService();
      quizSessionCubit = QuizSessionCubit(mockQuizHubService, mockQuizRepository);
      when(() => mockQuizHubService.stopConnection()).thenAnswer((_) async {});
    });

    tearDown(() {
      quizSessionCubit.close();
    });

    final answerRequest = AnswerRequest(
      questionId: 'question123',
      userId: 'user123',
      selectedOptions: ['option1'],
    );

    blocTest<QuizSessionCubit, QuizSessionState>(
      'returns true when submitAnswer is successful',
      build: () {
        when(() => mockQuizRepository.submitAnswer(1, answerRequest)).thenAnswer((_) async => Future.value());
        return quizSessionCubit;
      },
      act: (cubit) async {
        final result = await cubit.submitAnswer(1, answerRequest);
        expect(result, true);
      },
    );
  });
}