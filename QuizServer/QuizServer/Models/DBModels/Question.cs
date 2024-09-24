using QuizServer.Models.DBModels;

public class Question
{
    public Guid QuestionId { get; set; }
    public string Text { get; set; }
    public int Order { get; set; }
    public int QuizId { get; set; }
    public Quiz Quiz { get; set; }
    public List<QuestionOption> Options { get; set; }
    public int MaxPoint { get; set; }
    public string Type { get; set; }
    public ICollection<PlayerAnswer> PlayerAnswers { get; set; }
}
