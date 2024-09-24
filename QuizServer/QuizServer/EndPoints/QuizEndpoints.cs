using AutoMapper;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using QuizServer.BackgroundServices;
using QuizServer.Data;
using QuizServer.Hubs;
using QuizServer.Models.Dtos.Responses;
using Swashbuckle.AspNetCore.Annotations;

namespace QuizServer.EndPoints;

using Models.DBModels;
using Models.Dtos;
using Microsoft.AspNetCore.SignalR;

public static class QuizEndpoints
{
    public static void MapQuizEndpoints(this IEndpointRouteBuilder routes)
    {
        routes.MapPost("/quizzes", async (NewQuizRequest quizDto, QuizDbContext dbContext, IMapper mapper) =>
            {
                var user = await dbContext.Users.FindAsync(quizDto.UserId);
                if (user == null)
                {
                    return Results.NotFound("User not found");
                }

                var quiz = new Quiz
                {
                    Title = quizDto.Title,
                    CreatedAt = DateTime.UtcNow,
                    UserId = quizDto.UserId,
                    User = user,
                    Questions = quizDto.Questions.Select(q => new Question
                    {
                        QuestionId = Guid.NewGuid(),
                        Text = q.Text,
                        Order = q.Order,
                        Options = q.Options.Select(o => new QuestionOption
                        {
                            Id = Guid.NewGuid(),
                            Text = o.Text,
                            IsCorrect = o.IsCorrect
                        }).ToList(),
                        MaxPoint = q.MaxPoint,
                        Type = q.Type
                    }).ToList()
                };

                dbContext.Quizzes.Add(quiz);
                await dbContext.SaveChangesAsync();

                var quizResponse = mapper.Map<QuizResponse>(quiz);
                return Results.Created($"/quizzes/{quiz.QuizId}", quizResponse);
            })
            .WithName("CreateQuiz")
            .WithTags("Quiz")
            .WithMetadata(new SwaggerOperationAttribute(summary: "Create a new quiz",
                description: "Creates a new quiz with questions and returns the quiz details."))
            .Produces<QuizResponse>(StatusCodes.Status201Created)
            .Produces(StatusCodes.Status404NotFound)
            .Produces(StatusCodes.Status400BadRequest);

        routes.MapPost("/quizzes/{quizId}/start",
            async (int quizId, QuizDbContext dbContext, IServiceProvider serviceProvider, IMapper mapper) =>
            {
                var quizSessionService = serviceProvider.GetRequiredService<QuizSessionService>();
                var cancellationTokenSource = new CancellationTokenSource();
                await quizSessionService.StartQuizSession(quizId, cancellationTokenSource.Token, dbContext, mapper);
                return Results.Ok();
            }).WithTags("Quiz");

        routes.MapPost("/quizzes/{quizId}/submit-answer",
                async (int quizId, AnswerRequest answerDto, QuizDbContext dbContext) =>
                {
                    // Retrieve the quiz and the related question
                    var quiz = await dbContext.Quizzes
                        .Include(q => q.Questions).ThenInclude(question => question.Options)
                        .FirstOrDefaultAsync(q => q.QuizId == quizId);

                    if (quiz == null)
                    {
                        return Results.NotFound("Quiz not found");
                    }

                    var question = quiz.Questions.FirstOrDefault(q => q.QuestionId == answerDto.QuestionId);
                    if (question == null)
                    {
                        return Results.NotFound("Question not found");
                    }

                    // Find the user
                    var user = await dbContext.Users.FindAsync(answerDto.UserId);
                    if (user == null)
                    {
                        return Results.NotFound("User not found");
                    }

                    // Check if the answer is correct
                    var correctOptions = question.Options.Where(o => o.IsCorrect).Select(o => o.Id).ToList();
                    bool isCorrect = !correctOptions.Except(answerDto.SelectedOptions).Any() && !answerDto.SelectedOptions.Except(correctOptions).Any();
                    int points = isCorrect ? question.MaxPoint : 0;

                    // Save the player's answer
                    var playerAnswer = new PlayerAnswer
                    {
                        PlayerAnswerId = Guid.NewGuid(),
                        QuestionId = question.QuestionId,
                        Question = question,
                        UserId = user.UserId,
                        User = user,
                        SelectedOptions = answerDto.SelectedOptions,
                        IsCorrect = isCorrect,
                        Point = points
                    };

                    dbContext.PlayerAnswers.Add(playerAnswer);
                    await dbContext.SaveChangesAsync();

                    return Results.Ok();
                })
            .WithName("SubmitAnswer")
            .WithTags("Quiz")
            .Produces(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .Produces(StatusCodes.Status400BadRequest);
    }
}