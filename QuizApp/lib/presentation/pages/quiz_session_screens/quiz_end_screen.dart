import 'package:flutter/material.dart';
import 'package:quizz_app/domain/models/result_response.dart';

class QuizEndScreen extends StatefulWidget {
  final List<LeaderboardResponse> results;

  const QuizEndScreen({super.key, required this.results});

  @override
  State<QuizEndScreen> createState() => _QuizEndScreenState();
}

class _QuizEndScreenState extends State<QuizEndScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('End quiz, here is leaderboard:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...widget.results.asMap().entries.map((entry) {
              int index = entry.key;
              var leaderboardEntry = entry.value;
              return Card(
                color: Colors.blue[100],
                child: ListTile(
                  leading: Text('${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  title: Text(leaderboardEntry.userName ?? '', style: const TextStyle(fontSize: 18)),
                  trailing: Text('${leaderboardEntry.totalPoints} points', style: const TextStyle(fontSize: 18)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}