using AutoMapper;
using QuizServer.Data;
using QuizServer.Models.Dtos;
using QuizServer.Models.Dtos.Responses;
using Swashbuckle.AspNetCore.Annotations;

namespace QuizServer.EndPoints;

public static class UserEndpoints
{
    public static void MapUserEndpoints(this IEndpointRouteBuilder routes)
    {
        routes.MapPost("/users", async (NewUserRequest newUserRequest, QuizDbContext dbContext, IMapper mapper) =>
        {
            var user = new User
            {
                UserId = Guid.NewGuid(),
                Name = newUserRequest.Name,
                Email = newUserRequest.Email
            };

            dbContext.Users.Add(user);
            await dbContext.SaveChangesAsync();

            var userResponse = mapper.Map<UserResponse>(user);
            return Results.Created($"/users/{user.UserId}", userResponse);
        })
        .WithName("CreateUser")
        .WithTags("User")
        .WithMetadata(new SwaggerOperationAttribute(summary: "Create a new user", description: "Creates a new user and returns the user details."))
        .Produces<UserResponse>(StatusCodes.Status201Created)
        .Produces(StatusCodes.Status400BadRequest);
    }
}