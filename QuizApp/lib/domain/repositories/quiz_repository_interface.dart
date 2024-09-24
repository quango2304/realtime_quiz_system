import 'package:openapi/api.dart';

abstract class QuizRepositoryInterface {
  Future<QuizResponse?> createQuiz(NewQuizRequest newQuizRequest);
  Future<void> startQuiz(int quizId);
  Future<void> submitAnswer(int quizId, AnswerRequest answerRequest);
}