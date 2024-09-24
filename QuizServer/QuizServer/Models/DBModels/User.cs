using QuizServer.Models.DBModels;

public class User
{
    public Guid UserId { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public ICollection<Quiz> Quizzes { get; set; }
    public ICollection<PlayerAnswer> PlayerAnswers { get; set; }
}