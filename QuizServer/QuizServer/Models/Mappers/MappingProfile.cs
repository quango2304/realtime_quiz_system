using AutoMapper;
using QuizServer.Models.DBModels;
using QuizServer.Models.Dtos.Responses;

namespace QuizServer.Models.Mappers
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<User, UserResponse>();
            CreateMap<Quiz, QuizResponse>();
            CreateMap<Question, QuestionResponse>();
            CreateMap<QuestionOption, QuestionOptionResponse>();
        }
    }
}