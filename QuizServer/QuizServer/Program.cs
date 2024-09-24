using Microsoft.EntityFrameworkCore;
using QuizServer.BackgroundServices;
using QuizServer.Data;
using QuizServer.EndPoints;
using QuizServer.Hubs;
using QuizServer.Models.Mappers;

var builder = WebApplication.CreateBuilder(args);

//config swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.EnableAnnotations();
});

//config db
builder.Services.AddDbContext<QuizDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

//config automapper
builder.Services.AddAutoMapper(typeof(MappingProfile));

builder.Services.AddSignalR();

builder.Services.AddSingleton<QuizSessionService>();

var app = builder.Build();

app.ApplyMigrations();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapUserEndpoints();
app.MapQuizEndpoints();

app.MapHub<QuizHub>("/quizHub");

app.Run();