using Microsoft.EntityFrameworkCore;
using QuizServer.Models.DBModels;

namespace QuizServer.Data;

public class QuizDbContext(DbContextOptions<QuizDbContext> options) : DbContext(options)
{
    public DbSet<Quiz> Quizzes { get; set; }
    public DbSet<Question> Questions { get; set; }
    public DbSet<QuestionOption> QuestionOptions { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<PlayerAnswer> PlayerAnswers { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        
    }
}