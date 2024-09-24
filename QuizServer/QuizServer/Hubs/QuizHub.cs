namespace QuizServer.Hubs;

using Microsoft.AspNetCore.SignalR;
using System.Collections.Generic;
using System.Threading.Tasks;

public class QuizHub : Hub
{
    private static readonly Dictionary<int, List<string>> QuizPlayers = new();

    public async Task JoinQuiz(int quizId, string userName)
    {
        await Groups.AddToGroupAsync(Context.ConnectionId, quizId.ToString());

        if (!QuizPlayers.ContainsKey(quizId))
        {
            QuizPlayers[quizId] = new List<string>();
        }

        QuizPlayers[quizId].Add(userName);
        await Clients.Group(quizId.ToString()).SendAsync("UpdatePlayerList", QuizPlayers[quizId]);
    }
}