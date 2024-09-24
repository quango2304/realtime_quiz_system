import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/api.dart';
import 'package:quizz_app/domain/models/result_response.dart';
import 'package:quizz_app/domain/repositories/quiz_repository_interface.dart';
import 'package:quizz_app/infrastructure/services/quiz_session_service.dart';

part 'quiz_session_state.dart';

@injectable
class QuizSessionCubit extends Cubit<QuizSessionState> {
  final QuizHubService _quizHubService;
  final QuizRepositoryInterface _quizRepository;

  QuizSessionCubit(this._quizHubService, this._quizRepository) : super(const QuizSessionInitial());

  Future<void> startQuizSession(int quizId, String userName) async {
    emit(const QuizSessionLoading());

    await _quizHubService.startConnection();
    _quizHubService.onReceiveQuestion((question) {
      if (question != null) {
        emit(QuizSessionQuestionReceived(question, playerList: state.playerList));
      }
    });

    _quizHubService.onReceiveResults((results) {
      emit(QuizSessionResultsReceived(results, playerList: state.playerList));
    });

    _quizHubService.onUpdatePlayerList((playerList) {
      emit(state.copyWith(playerList: playerList));
    });

    _quizHubService.onQuizEnded((results) {
      emit(QuizSessionEnded(results, playerList: state.playerList));
    });

    await _quizHubService.joinQuiz(quizId, userName);
  }

  Future<bool> submitAnswer(int quizId, AnswerRequest answerRequest) async {
    try {
      await _quizRepository.submitAnswer(quizId, answerRequest);
      return true;
    } catch (e, s) {
      print('Error submitting answer: $e $s');
      return false;
    }
  }

  @override
  Future<void> close() async {
    await _quizHubService.stopConnection();
    super.close();
  }
}