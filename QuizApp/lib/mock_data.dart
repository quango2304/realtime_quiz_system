import 'package:openapi/api.dart';
import 'package:quizz_app/domain/models/result_response.dart';

final mockQuestionResult = ResultsResponse(
  optionStatistics: [
    OptionStatistics(
      optionText: 'Option A',
      percentage: 0.1,
      isCorrect: true,
      optionId: '1',
    ),
    OptionStatistics(
      optionText: 'Option B',
      percentage: 0.2,
      isCorrect: false,
      optionId: '2',
    ),
  ],
  leaderboard: [
    LeaderboardResponse(
      userName: 'John Doe',
      totalPoints: 100,
    ),
    LeaderboardResponse(
      userName: 'Jane Doe',
      totalPoints: 50,
    ),
  ],
);

final mockQuestion = QuestionResponse(
  questionId: 'sda',
  text: 'What is the capital of Nigeria?',
  order: 1,
  quizId: 256,
  type: 'single',
  maxPoint: 100,
  options: [
    QuestionOptionResponse(
      id: '1',
      text: 'Abuja',
    ),
    QuestionOptionResponse(
      id: '2',
      text: 'Lagos',
    ),
    QuestionOptionResponse(
      id: '3',
      text: 'Kano',
    ),
    QuestionOptionResponse(
      id: '4',
      text: 'Ibadan',
    ),
  ],
);