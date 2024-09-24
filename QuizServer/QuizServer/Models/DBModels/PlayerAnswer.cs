namespace QuizServer.Models.DBModels;

public class PlayerAnswer
{
    public Guid PlayerAnswerId { get; set; }
    public Guid QuestionId { get; set; }
    public Question Question { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; }
    public List<Guid> SelectedOptions { get; set; }
    public bool IsCorrect { get; set; }
    public int Point { get; set; }
}