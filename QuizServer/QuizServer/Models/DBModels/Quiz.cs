namespace QuizServer.Models.DBModels;

public class Quiz
{
    public int QuizId { get; set; }
    public string Title { get; set; }
    public DateTime CreatedAt { get; set; }
    public Guid UserId { get; set; }
    public DateTime EndAt { get; set; }
    public User User { get; set; }
    public ICollection<Question> Questions { get; set; }
}