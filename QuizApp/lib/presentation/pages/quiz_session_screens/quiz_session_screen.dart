import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/application/cubits/quiz_session_cubit/quiz_session_cubit.dart';
import 'package:quizz_app/application/cubits/user_cubit/user_cubit.dart';
import 'package:quizz_app/presentation/pages/quiz_session_screens/question_screen.dart';
import 'package:quizz_app/presentation/pages/quiz_session_screens/question_result_screen.dart';
import 'package:quizz_app/injectable_config.dart';
import 'package:quizz_app/presentation/pages/quiz_session_screens/quiz_end_screen.dart';

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
                if (state is QuizSessionQuestionReceived) {
                  return QuestionScreen(
                    question: state.question,
                    submitAnswer: _submitAnswer,
                  );
                } else if (state is QuizSessionResultsReceived) {
                  return QuestionResultScreen(
                    results: state.results,
                    selectedOptionIds: selectedOptionIds,
                  );
                } else if (state is QuizSessionEnded) {
                  return QuizEndScreen(results: state.results);
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Waiting for quiz to start...',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      ),
                      const SizedBox(height: 20),
                      if (state.playerList.isNotEmpty) ...[
                        const Text(
                          'Players joined:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        ...state.playerList.map((player) => Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.person,
                                            color: Colors.blueAccent),
                                        const SizedBox(width: 10),
                                        Text(
                                          player,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.check_circle,
                                        color: Colors.green),
                                    // Optional: Indicates the player is active
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ],
                  ));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
