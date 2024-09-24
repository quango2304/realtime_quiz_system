using Microsoft.EntityFrameworkCore;

namespace QuizServer.Data;

public static class MigrationManager
{
    public static WebApplication ApplyMigrations(this WebApplication app)
    {
        using var scope = app.Services.CreateScope();
        var dbContext = scope.ServiceProvider.GetRequiredService<QuizDbContext>();
        dbContext.Database.Migrate();
        return app;
    }
}