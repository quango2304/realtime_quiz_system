namespace QuizServer.Models.Dtos.Responses;
public class UserResponse
{
    public Guid UserId { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
}