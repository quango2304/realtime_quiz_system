part of 'quiz_session_cubit.dart';

abstract class QuizSessionState extends Equatable {
  final List<String> playerList;
  final List<LeaderboardResponse> leaderboard;

  const QuizSessionState({
    this.playerList = const [],
    this.leaderboard = const [],
  });

  QuizSessionState copyWith({
    List<String>? playerList,
    List<LeaderboardResponse>? leaderboard,
  });

  @override
  List<Object> get props => [playerList, leaderboard];
}

class QuizSessionInitial extends QuizSessionState {
  const QuizSessionInitial({super.playerList, List<LeaderboardResponse>? leaderboard})
      : super(leaderboard: leaderboard ?? const []);

  @override
  QuizSessionInitial copyWith({
    List<String>? playerList,
    List<LeaderboardResponse>? leaderboard,
  }) {
    return QuizSessionInitial(
      playerList: playerList ?? this.playerList,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }
}

class QuizSessionLoading extends QuizSessionState {
  const QuizSessionLoading({super.playerList, List<LeaderboardResponse>? leaderboard})
      : super(leaderboard: leaderboard ?? const []);

  @override
  QuizSessionLoading copyWith({
    List<String>? playerList,
    List<LeaderboardResponse>? leaderboard,
  }) {
    return QuizSessionLoading(
      playerList: playerList ?? this.playerList,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }
}

class QuizSessionQuestionReceived extends QuizSessionState {
  final QuestionResponse question;

  const QuizSessionQuestionReceived(
      this.question, {
        super.playerList,
        List<LeaderboardResponse>? leaderboard,
      }) : super(leaderboard: leaderboard ?? const []);

  @override
  QuizSessionQuestionReceived copyWith({
    QuestionResponse? question,
    List<String>? playerList,
    List<LeaderboardResponse>? leaderboard,
  }) {
    return QuizSessionQuestionReceived(
      question ?? this.question,
      playerList: playerList ?? this.playerList,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }

  @override
  List<Object> get props => [question, ...super.props];
}

class QuizSessionResultsReceived extends QuizSessionState {
  final ResultsResponse results;

  const QuizSessionResultsReceived(
      this.results, {
        super.playerList,
        List<LeaderboardResponse>? leaderboard,
      }) : super(leaderboard: leaderboard ?? const []);

  @override
  QuizSessionResultsReceived copyWith({
    ResultsResponse? results,
    List<String>? playerList,
    List<LeaderboardResponse>? leaderboard,
  }) {
    return QuizSessionResultsReceived(
      results ?? this.results,
      playerList: playerList ?? this.playerList,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }

  @override
  List<Object> get props => [results, ...super.props];
}

class QuizSessionEnded extends QuizSessionState {
  final List<LeaderboardResponse> results;

  const QuizSessionEnded(
      this.results, {
        super.playerList,
        List<LeaderboardResponse>? leaderboard,
      }) : super(leaderboard: leaderboard ?? const []);

  @override
  QuizSessionEnded copyWith({
    List<LeaderboardResponse>? results,
    List<String>? playerList,
    List<LeaderboardResponse>? leaderboard,
  }) {
    return QuizSessionEnded(
      results ?? this.results,
      playerList: playerList ?? this.playerList,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }

  @override
  List<Object> get props => [results, ...super.props];
}