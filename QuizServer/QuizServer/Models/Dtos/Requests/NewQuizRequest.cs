namespace QuizServer.Models.Dtos;

public class NewQuizRequest
{
    public string Title { get; set; }
    public Guid UserId { get; set; }
    public List<QuestionDto> Questions { get; set; }
}

public class QuestionDto
{
    public string Text { get; set; }
    public int Order { get; set; }
    public List<QuestionOptionDto> Options { get; set; }
    public int MaxPoint { get; set; }
    public string Type { get; set; }
}

public class QuestionOptionDto
{
    public string Text { get; set; }
    public bool IsCorrect { get; set; }
}