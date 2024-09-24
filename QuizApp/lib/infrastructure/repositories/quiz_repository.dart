import 'package:injectable/injectable.dart';
import 'package:openapi/api.dart';
import 'package:quizz_app/domain/repositories/quiz_repository_interface.dart';

@LazySingleton(as: QuizRepositoryInterface)
class QuizRepository implements QuizRepositoryInterface {
  final QuizApiClient quizApiClient;

  QuizRepository(this.quizApiClient);

  @override
  Future<QuizResponse?> createQuiz(NewQuizRequest newQuizRequest) async {
    return await quizApiClient.createQuiz(newQuizRequest);
  }

  @override
  Future<void> startQuiz(int quizId) async {
    await quizApiClient.quizzesQuizIdStartPost(quizId);
  }

  @override
  Future<void> submitAnswer(int quizId, AnswerRequest answerRequest) async {
    await quizApiClient.submitAnswer(quizId, answerRequest);
  }
}