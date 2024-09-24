part of 'quiz_session_cubit.dart';

abstract class QuizSessionState extends Equatable {
  final List<String> playerList;

  const QuizSessionState({this.playerList = const []});

  QuizSessionState copyWith({List<String>? playerList});
  @override
  List<Object> get props => [playerList];
}

class QuizSessionInitial extends QuizSessionState {
  const QuizSessionInitial({super.playerList});

  @override
  QuizSessionInitial copyWith({List<String>? playerList}) {
    return QuizSessionInitial(playerList: playerList ?? this.playerList);
  }
}

class QuizSessionLoading extends QuizSessionState {
  const QuizSessionLoading({super.playerList});

  @override
  QuizSessionLoading copyWith({List<String>? playerList}) {
    return QuizSessionLoading(playerList: playerList ?? this.playerList);
  }
}

class QuizSessionQuestionReceived extends QuizSessionState {
  final QuestionResponse question;

  const QuizSessionQuestionReceived(this.question, {super.playerList});

  @override
  QuizSessionQuestionReceived copyWith({QuestionResponse? question, List<String>? playerList}) {
    return QuizSessionQuestionReceived(
      question ?? this.question,
      playerList: playerList ?? this.playerList,
    );
  }

  @override
  List<Object> get props => [question, playerList];
}

class QuizSessionResultsReceived extends QuizSessionState {
  final ResultsResponse results;

  const QuizSessionResultsReceived(this.results, {super.playerList});

  @override
  QuizSessionResultsReceived copyWith({ResultsResponse? results, List<String>? playerList}) {
    return QuizSessionResultsReceived(
      results ?? this.results,
      playerList: playerList ?? this.playerList,
    );
  }

  @override
  List<Object> get props => [results, playerList];
}

class QuizSessionEnded extends QuizSessionState {
  final List<LeaderboardResponse> results;

  const QuizSessionEnded(this.results, {super.playerList});

  @override
  QuizSessionEnded copyWith({List<LeaderboardResponse>? results, List<String>? playerList}) {
    return QuizSessionEnded(
      results ?? this.results,
      playerList: playerList ?? this.playerList,
    );
  }

  @override
  List<Object> get props => [results, playerList];
}