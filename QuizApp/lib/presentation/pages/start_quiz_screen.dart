// lib/presentation/pages/start_quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/application/cubits/new_quiz_cubit/new_quiz_cubit.dart';
import 'package:quizz_app/injectable_config.dart';

class StartQuizScreen extends StatefulWidget {
  final int quizId;

  const StartQuizScreen({super.key, required this.quizId});

  @override
  State<StartQuizScreen> createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends State<StartQuizScreen> {
  final newQuizCubit = getIt<NewQuizCubit>();
  @override
  void initState() {
    super.initState();
    newQuizCubit.listenToPlayersJoined(widget.quizId, 'Admin');
  }

  @override
  void dispose() {
    newQuizCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void startQuiz() {
      newQuizCubit.startQuiz(widget.quizId);
    }

    return BlocListener<NewQuizCubit, NewQuizState>(
      listener: (context, state) {
        if (state is NewQuizStartSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Quiz started'),
            ),
          );
        } else if (state is NewQuizStartFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.error),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      bloc: newQuizCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Quiz Created',
            style: TextStyle(color: Colors.white),
          ),
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Quiz ID: ${widget.quizId}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: startQuiz,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Start Quiz',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                BlocBuilder<NewQuizCubit, NewQuizState>(
                  builder: (context, state) {
                    if (state is NewQuizPlayerListUpdated) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Players:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...state.playerList.map((player) => Card(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.person, color: Colors.blueAccent),
                                      const SizedBox(width: 10),
                                      Text(
                                        player,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const Icon(Icons.check_circle, color: Colors.green), // Optional: Indicates active status
                                ],
                              ),
                            ),
                          )),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  bloc: newQuizCubit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
