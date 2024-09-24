using AutoMapper;
using Microsoft.EntityFrameworkCore;
using QuizServer.Data;
using QuizServer.Hubs;
using QuizServer.Models.Dtos.Responses;

namespace QuizServer.BackgroundServices;

using Microsoft.AspNetCore.SignalR;
using System.Threading;
using System.Threading.Tasks;

public class QuizSessionService(IHubContext<QuizHub> hubContext) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            // This service will run indefinitely; it's paused and resumed when a quiz starts
            await Task.Delay(Timeout.Infinite, stoppingToken);
        }
    }

    public async Task StartQuizSession(int quizId, CancellationToken cancellationToken, QuizDbContext dbContext,
        IMapper mapper)
    {
        var quiz = await dbContext.Quizzes
            .Include(q => q.Questions.OrderBy(q => q.Order))
            .ThenInclude(q => q.Options)
            .Include(q => q.Questions)
            .ThenInclude(q => q.PlayerAnswers)
            .FirstOrDefaultAsync(q => q.QuizId == quizId, cancellationToken: cancellationToken);

        if (quiz?.Questions == null || quiz.Questions.Count == 0)
        {
            throw new Exception("Quiz or questions not found.");
        }

        var questionIndex = 0;

        while (questionIndex < quiz.Questions.Count && !cancellationToken.IsCancellationRequested)
        {
            var question = quiz.Questions.ElementAt(questionIndex);
            var questionResponse = mapper.Map<QuestionResponse>(question);
            await hubContext.Clients.Group(quizId.ToString())
                .SendAsync("ReceiveQuestion", questionResponse, cancellationToken: cancellationToken);

            await Task.Delay(TimeSpan.FromSeconds(20), cancellationToken); // Wait for users to answer

            // Calculate results and send leaderboard
            var allOptions = question.Options;

            var playerAnswers = await dbContext.PlayerAnswers
                .Where(pa => pa.QuestionId == question.QuestionId)
                .ToListAsync(cancellationToken);

            var optionStatistics = allOptions.Select(option => new OptionStatistics
            {
                OptionText = option.Text,
                Percentage = playerAnswers.Count == 0
                    ? 0
                    : playerAnswers.Count(pa => pa.SelectedOptions.Contains(option.Id)) /
                      (double)playerAnswers.Count,
                IsCorrect = option.IsCorrect,
                OptionId = option.Id
            }).ToList();
            var leaderboard = await GetLeaderboard(quizId, dbContext);

            var resultsResponse = new ResultsResponse
            {
                Leaderboard = leaderboard,
                OptionStatistics = optionStatistics
            };

            await hubContext.Clients.Group(quizId.ToString())
                .SendAsync("ReceiveResults", resultsResponse, cancellationToken: cancellationToken);

            await Task.Delay(TimeSpan.FromSeconds(10), cancellationToken); // Wait before next question

            questionIndex++;
        }

        // Notify users that the quiz has ended
        // Update the QuizEnded notification to include the leaderboard
        var finalLeaderboard = await GetLeaderboard(quizId, dbContext);
        await hubContext.Clients.Group(quizId.ToString())
            .SendAsync("QuizEnded", finalLeaderboard, cancellationToken: cancellationToken);
    }

    private async Task<List<LeaderboardResponse>> GetLeaderboard(int quizId, QuizDbContext dbContext)
    {
        // Fetch and calculate points for each user
        var leaderboard = await dbContext.PlayerAnswers
            .Where(pa => pa.Question.QuizId == quizId)
            .GroupBy(pa => pa.User)
            .Select(group => new LeaderboardResponse()
            {
                UserName = group.Key.Name,
                TotalPoints = group.Sum(pa => pa.Point)
            })
            .OrderByDescending(entry => entry.TotalPoints)
            .ToListAsync();

        return leaderboard;
    }
}