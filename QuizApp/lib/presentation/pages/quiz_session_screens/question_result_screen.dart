import 'package:flutter/material.dart';
import 'package:quizz_app/domain/models/result_response.dart';
import 'dart:async';

class QuestionResultScreen extends StatefulWidget {
  final ResultsResponse results;
  final List<String> selectedOptionIds;

  const QuestionResultScreen({super.key, required this.results, required this.selectedOptionIds});

  @override
  State<QuestionResultScreen> createState() => _QuestionResultScreenState();
}

class _QuestionResultScreenState extends State<QuestionResultScreen> {
  int _remainingTime = 9;
  Timer? _timer;
  double _barWidth = 1.0;

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
          _barWidth = _remainingTime / 10;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  bool _areSelectedOptionsCorrect() {
    final correctOptionIds = widget.results.optionStatistics!
        .where((option) => option.isCorrect == true)
        .map((option) => option.optionId)
        .toSet();
    final selectedOptionIds = widget.selectedOptionIds.toSet();
    return correctOptionIds.difference(selectedOptionIds).isEmpty &&
        selectedOptionIds.difference(correctOptionIds).isEmpty;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final areSelectedOptionsCorrect = _areSelectedOptionsCorrect();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: 5,
                  width: MediaQuery.of(context).size.width * _barWidth,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              areSelectedOptionsCorrect
                  ? 'Your selection is correct'
                  : 'Your selection is wrong',
              style: TextStyle(
                fontSize: 18,
                color: areSelectedOptionsCorrect ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Question Results:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...widget.results.optionStatistics!.map((option) {
              return Card(
                color: option.isCorrect == true ? Colors.green[100] : Colors.red[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(option.optionText ?? '', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 4),
                      Text(
                        '${((option.percentage ?? 0) * 100).toStringAsFixed(0)}% players selected',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}