import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quizz_app/domain/repositories/quiz_repository_interface.dart';
import 'package:openapi/api.dart';
import 'package:quizz_app/infrastructure/services/quiz_session_service.dart';

part 'new_quiz_state.dart';

@injectable
class NewQuizCubit extends Cubit<NewQuizState> {
  final QuizRepositoryInterface _quizRepository;
  final QuizHubService _quizHubService;

  NewQuizCubit(this._quizRepository, this._quizHubService) : super(NewQuizInitial());

  Future<void> createQuiz(NewQuizRequest newQuizRequest) async {
    try {
      emit(NewQuizCreating());
      final quiz = await _quizRepository.createQuiz(newQuizRequest);
      if (quiz != null) {
        emit(NewQuizCreateSuccess(quiz));
      } else {
        emit(const NewQuizCreateFailure('Quiz creation failed'));
      }
    } catch (e) {
      emit(NewQuizCreateFailure(e.toString()));
    }
  }

  Future<void> listenToPlayersJoined(int quizId, String userName) async {
    await _quizHubService.startConnection();
    _quizHubService.joinQuiz(quizId, userName);
    _quizHubService.onUpdatePlayerList((playerList) {
      emit(NewQuizPlayerListUpdated(playerList));
    });
  }

  @override
  Future<void> close() async {
    _quizHubService.stopConnection();
    super.close();
  }

  Future<void> startQuiz(int quizId) async {
    try {
      emit(NewQuizStarting());
      _quizRepository.startQuiz(quizId);
      emit(NewQuizStartSuccess());
    } catch (e) {
      emit(NewQuizStartFailure(e.toString()));
    }
  }
}