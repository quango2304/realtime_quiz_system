import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:quizz_app/application/cubits/new_quiz_cubit/new_quiz_cubit.dart';
import 'package:quizz_app/application/cubits/user_cubit/user_cubit.dart';
import 'package:quizz_app/injectable_config.dart';
import 'package:quizz_app/presentation/pages/start_quiz_screen.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final TextEditingController _quizTitleController = TextEditingController();
  final List<QuestionDto> _questions = [];
  final newQuizCubit = getIt<NewQuizCubit>();

  void _addQuestion() {
    setState(() {
      _questions.add(QuestionDto(
        text: "",
        options: [QuestionOptionDto(text: "", isCorrect: false)],
        type: "single",
        order: _questions.length + 1,
        maxPoint: 100,
      ));
    });
  }

  void _addOption(QuestionDto question) {
    question.options ??= [];
    setState(() {
      question.options!.add(QuestionOptionDto(text: "", isCorrect: false));
    });
  }

  void _submitQuiz() async {
    String quizTitle = _quizTitleController.text;
    if (quizTitle.isEmpty || _questions.isEmpty) {
      showErrorDialog('Quiz title and questions are required');
      return;
    }

    for (var question in _questions) {
      if (!(question.options ?? []).any((option) => option.isCorrect ?? false)) {
        showErrorDialog('All question should have a correct answer');
        return;
      }
    }

    var userCubit = getIt.get<UserCubit>();
    var userId = userCubit.getCurrentUserId();
    if (userId.isEmpty) {
      showErrorDialog('user info not found');
      return;
    }

    NewQuizRequest newQuizRequest = NewQuizRequest(
      title: quizTitle,
      questions: _questions.map((q) => QuestionDto(
        text: q.text,
        order: q.order,
        options: (q.options ?? []).map((o) => QuestionOptionDto(
          text: o.text,
          isCorrect: o.isCorrect,
        )).toList(),
        type: q.type,
        maxPoint: q.maxPoint,
      )).toList(),
      userId: userId,
    );
    var user = getIt.get<UserCubit>().getCurrentUserId();
    newQuizCubit.createQuiz(newQuizRequest);
  }

  void showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error),
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewQuizCubit, NewQuizState>(
      listener: (context, state) {
        if (state is NewQuizCreateSuccess) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => StartQuizScreen(quizId: state.quiz.quizId!),
          ));
        } else if (state is NewQuizCreateFailure) {
          showErrorDialog(state.error);
        }
      },
      bloc: newQuizCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create New Quiz', style: TextStyle(color: Colors.white)),
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _quizTitleController,
                  decoration: InputDecoration(
                    labelText: 'Quiz Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  QuestionDto question = _questions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Question ${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Question',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            onChanged: (value) {
                              question.text = value;
                            },
                          ),
                          const SizedBox(height: 10),
                          DropdownButton<String>(
                            value: question.type,
                            items: <String>['single', 'multi'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                question.type = newValue;
                                if (newValue == 'single') {
                                  for (var option in question.options!) {
                                    option.isCorrect = false;
                                  }
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => const SizedBox(height: 10),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: question.options?.length ?? 0,
                            itemBuilder: (context, optionIndex) {
                              var option = question.options![optionIndex];
                              return Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Option',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      ),
                                      onChanged: (value) {
                                        option.text = value;
                                      },
                                    ),
                                  ),
                                  if (question.type == 'single')
                                    Radio<bool>(
                                      value: true,
                                      groupValue: option.isCorrect,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          for (var opt in question.options!) {
                                            opt.isCorrect = false;
                                          }
                                          option.isCorrect = value!;
                                        });
                                      },
                                    )
                                  else
                                    Checkbox(
                                      value: option.isCorrect,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          option.isCorrect = value!;
                                        });
                                      },
                                    ),
                                ],
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () => _addOption(question),
                            child: const Text('Add Option'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _questions.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _addQuestion,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: const Text('Add Question', style: TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitQuiz,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text('Submit Quiz', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}