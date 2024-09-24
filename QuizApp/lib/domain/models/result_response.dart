class ResultsResponse {
  List<OptionStatistics>? optionStatistics;
  List<LeaderboardResponse>? leaderboard;

  ResultsResponse({this.optionStatistics, this.leaderboard});

  factory ResultsResponse.fromJson(Map<String, dynamic> json) {
    return ResultsResponse(
      optionStatistics: (json['optionStatistics'] as List<dynamic>?)
          ?.map((e) => OptionStatistics.fromJson(e as Map<String, dynamic>))
          .toList(),
      leaderboard: (json['leaderboard'] as List<dynamic>?)
          ?.map((e) => LeaderboardResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionStatistics': optionStatistics?.map((e) => e.toJson()).toList(),
      'leaderboard': leaderboard?.map((e) => e.toJson()).toList(),
    };
  }
}

class OptionStatistics {
  String? optionText;
  double? percentage;
  bool? isCorrect;
  String? optionId;

  OptionStatistics({
    this.optionText,
    this.percentage,
    this.isCorrect,
    this.optionId,
  });

  factory OptionStatistics.fromJson(Map<String, dynamic> json) {
    return OptionStatistics(
      optionText: json['optionText'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      isCorrect: json['isCorrect'] as bool?,
      optionId: json['optionId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionText': optionText,
      'percentage': percentage,
      'isCorrect': isCorrect,
    };
  }
}

class LeaderboardResponse {
  String? userName;
  int? totalPoints;

  LeaderboardResponse({this.userName, this.totalPoints});

  factory LeaderboardResponse.fromJson(Map<String, dynamic> json) {
    return LeaderboardResponse(
      userName: json['userName'] as String?,
      totalPoints: json['totalPoints'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'totalPoints': totalPoints,
    };
  }
}
