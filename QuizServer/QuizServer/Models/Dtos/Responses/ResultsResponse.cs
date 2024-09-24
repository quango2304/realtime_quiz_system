namespace QuizServer.Models.Dtos.Responses;

public class ResultsResponse
{
    public List<OptionStatistics> OptionStatistics { get; set; }
    public List<LeaderboardResponse> Leaderboard { get; set; }
}

public class OptionStatistics
{
    public string OptionText { get; set; }
    
    public Guid OptionId { get; set; }
    public double Percentage { get; set; }
    public bool IsCorrect { get; set; }
}
public class LeaderboardResponse
{
    public string UserName { get; set; }
    public int TotalPoints { get; set; }
}