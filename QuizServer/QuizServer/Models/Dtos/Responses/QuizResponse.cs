namespace QuizServer.Models.Dtos.Responses;
public class QuizResponse
{
    public int QuizId { get; set; }
    public string Title { get; set; }
    public DateTime CreatedAt { get; set; }
    public List<QuestionResponse> Questions { get; set; }
}

public class QuestionResponse
{
    public Guid QuestionId { get; set; }
    public string Text { get; set; }
    public int Order { get; set; }
    public int QuizId { get; set; }
    public List<QuestionOptionResponse> Options { get; set; }
    public int MaxPoint { get; set; }
    public string Type { get; set; }
}

public class QuestionOptionResponse
{
    public Guid Id { get; set; }
    public string Text { get; set; }
    public Guid QuestionId { get; set; }
}

