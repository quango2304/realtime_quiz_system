namespace QuizServer.Models.Dtos;

public class AnswerRequest
{
    public Guid QuestionId { get; set; }
    public Guid UserId { get; set; }
    public List<Guid> SelectedOptions { get; set; }
}