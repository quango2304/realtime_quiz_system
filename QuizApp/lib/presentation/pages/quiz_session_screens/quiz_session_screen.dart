import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/application/cubits/quiz_session_cubit/quiz_session_cubit.dart';
import 'package:quizz_app/application/cubits/user_cubit/user_cubit.dart';
import 'package:quizz_app/domain/models/result_response.dart';
import 'package:quizz_app/presentation/pages/quiz_session_screens/question_screen.dart';
import 'package:quizz_app/presentation/pages/quiz_session_screens/question_result_screen.dart';
import 'package:quizz_app/injectable_config.dart';
import 'package:quizz_app/presentation/pages/quiz_session_screens/quiz_end_screen.dart';
import 'package:quizz_app/presentation/pages/quiz_session_screens/waiting_screen.dart';

class QuizSessionScreen extends StatefulWidget {
  final int quizId;

  const QuizSessionScreen({super.key, required this.quizId});

  @override
  State<QuizSessionScreen> createState() => _QuizSessionScreenState();
}

class _QuizSessionScreenState extends State<QuizSessionScreen> {
  var cubit = getIt<QuizSessionCubit>();
  List<String> selectedOptionIds = [];

  @override
  void initState() {
    super.initState();
    final user = getIt.get<UserCubit>().getCurrentUserName();
    cubit.startQuizSession(widget.quizId, user);
  }

  void _submitAnswer(List<String> selectedOptionIds) async {
    this.selectedOptionIds = selectedOptionIds;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizSessionCubit>(
      create: (context) => cubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quiz Session',
                  style: TextStyle(color: Colors.white)),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            body: BlocBuilder<QuizSessionCubit, QuizSessionState>(
              builder: (context, state) {
                Widget stateWidget = const SizedBox();
                Widget leaderBoardWidget = buildLeaderBoard(state);
                if (state is QuizSessionQuestionReceived) {
                  stateWidget = QuestionScreen(
                    question: state.question,
                    submitAnswer: _submitAnswer,
                  );
                } else if (state is QuizSessionResultsReceived) {
                  stateWidget = QuestionResultScreen(
                    results: state.results,
                    selectedOptionIds: selectedOptionIds,
                  );
                } else if (state is QuizSessionEnded) {
                  leaderBoardWidget = const SizedBox();
                  stateWidget = QuizEndScreen(results: state.results);
                } else {
                  stateWidget = WaitingScreen(playerList: state.playerList);
                }

                return Column(
                  children: [
                    leaderBoardWidget,
                    Expanded(
                      child: stateWidget,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  ExpansionTile buildLeaderBoard(QuizSessionState state) {
    final userName = getIt<UserCubit>().getCurrentUserName();
    final currentUserScore = state.leaderboard
        .firstWhere(
          (leaderboard) => leaderboard.userName == userName,
          orElse: () => LeaderboardResponse(userName: userName, totalPoints: 0),
        )
        .totalPoints;
    var leaderBoardWidget = ExpansionTile(
      title: Text(
        'Your score: $currentUserScore, tap to view leaderboard',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      children: state.leaderboard.asMap().entries.map((entry) {
        int index = entry.key;
        var leaderboard = entry.value;

        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            child: Text('${index + 1}'),
          ),
          title: Text(
            leaderboard.userName ?? 'Unknown',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: Text(
            '${leaderboard.totalPoints ?? 0} points',
            style: const TextStyle(color: Colors.green),
          ),
        );
      }).toList(),
    );
    return leaderBoardWidget;
  }
}
