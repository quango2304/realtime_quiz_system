import 'package:openapi/api.dart';
import 'package:quizz_app/domain/models/result_response.dart';
import 'package:signalr_netcore/signalr_client.dart';

class QuizHubService {
  final String hubUrl;
  HubConnection? _hubConnection;

  QuizHubService(this.hubUrl);

  Future<void> startConnection() async {
    _hubConnection = HubConnectionBuilder().withUrl(hubUrl).build();
    await _hubConnection?.start();
  }

  Future<void> stopConnection() async {
    await _hubConnection?.stop();
  }

  Future<void> joinQuiz(int quizId, String userName) async {
    await _hubConnection?.invoke('JoinQuiz', args: [quizId, userName]);
  }

  void onReceiveQuestion(Function(QuestionResponse?) callback) {
    _hubConnection?.on('ReceiveQuestion', (arguments) {
      final results = QuestionResponse.fromJson(arguments![0] as Map<String, dynamic>);
      callback(results);
    });
  }

  void onReceiveResults(Function(ResultsResponse) callback) {
    _hubConnection?.on('ReceiveResults', (arguments) {
      final results = ResultsResponse.fromJson(arguments![0] as Map<String, dynamic>);
      callback(results);
    });
  }

  void onReceiveLeaderboard(Function(List<LeaderboardResponse>) callback) {
    _hubConnection?.on('ReceiveLeaderboard', (arguments) {
      final leaderboardResponse = (arguments![0] as List<dynamic>)
          .map((e) => LeaderboardResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      callback(leaderboardResponse);
    });
  }

  void onQuizEnded(Function(List<LeaderboardResponse>) callback) {
    _hubConnection?.on('QuizEnded', (arguments) {
      final leaderboardResponse = (arguments![0] as List<dynamic>)
          .map((e) => LeaderboardResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      callback(leaderboardResponse);
    });
  }

  void onUpdatePlayerList(Function(List<String>) callback) {
    _hubConnection?.on('UpdatePlayerList', (arguments) {
      print("UpdatePlayerList: $arguments");
      final players = (arguments![0] as List<dynamic>)
          .map((e) => e as String)
          .toList();
      callback(players);
    });
  }
}