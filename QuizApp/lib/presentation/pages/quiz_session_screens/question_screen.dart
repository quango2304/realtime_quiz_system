import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/application/cubits/quiz_session_cubit/quiz_session_cubit.dart';
import 'package:openapi/api.dart';
import 'package:quizz_app/application/cubits/user_cubit/user_cubit.dart';
import 'package:quizz_app/injectable_config.dart';

class QuestionScreen extends StatefulWidget {
  final QuestionResponse question;
  final Function(List<String> selectedOptionIds) submitAnswer;

  const QuestionScreen({super.key, required this.question, required this.submitAnswer});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String? _selectedOptionId;
  bool submitted = false;
  final List<String> _selectedOptionIds = [];
  int _remainingTime = 20;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
        _submitAnswer();
      }
    });
  }

  void _submitAnswer() async {
    if (submitted) {
      return;
    }
    final quizSessionCubit = context.read<QuizSessionCubit>();
    final user = getIt.get<UserCubit>().getCurrentUserId();
    final answerRequest = AnswerRequest(
      questionId: widget.question.questionId,
      userId: user,
      selectedOptions: widget.question.type == 'single' ? [_selectedOptionId!] : _selectedOptionIds,
    );
    widget.submitAnswer(widget.question.type == 'single' ? [_selectedOptionId!] : _selectedOptionIds);
    final isSuccess = await quizSessionCubit.submitAnswer(widget.question.quizId!, answerRequest);
    if (isSuccess) {
      setState(() {
        submitted = true;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              '$_remainingTime',
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Text(
              '${widget.question.order}. ${widget.question.text!}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (widget.question.type == 'single') ...widget.question.options!.map((option) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RadioListTile<String>(
                  title: Text(option.text!, style: const TextStyle(color: Colors.black)),
                  value: option.id!,
                  groupValue: _selectedOptionId,
                  onChanged: (value) {
                    if (submitted) {
                      return;
                    }
                    setState(() {
                      _selectedOptionId = value;
                    });
                  },
                ),
              );
            }),
            if (widget.question.type == 'multi') ...widget.question.options!.map((option) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CheckboxListTile(
                  title: Text(option.text!, style: const TextStyle(color: Colors.black)),
                  value: _selectedOptionIds.contains(option.id),
                  onChanged: (value) {
                    if (submitted) {
                      return;
                    }
                    setState(() {
                      if (value == true) {
                        _selectedOptionIds.add(option.id!);
                      } else {
                        _selectedOptionIds.remove(option.id);
                      }
                    });
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitted ? null : _submitAnswer,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Submit Answer', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            if (submitted) ...[
              const SizedBox(height: 20),
              const Text('Submitted!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ],
        ),
      ),
    );
  }
}