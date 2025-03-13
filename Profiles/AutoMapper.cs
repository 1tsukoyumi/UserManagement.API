using AutoMapper;
using UserManagement.API.Models;
using UserManagement.API.Models.DTOs;

namespace UserManagement.API.Profiles
{
    public class UserProfile : Profile
    {
        public UserProfile()
        {
            // Source -> Target
            CreateMap<User, UserReadDto>();
            CreateMap<UserCreateDto, User>();
            CreateMap<UserUpdateDto, User>();
        }
    }
}