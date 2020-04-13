using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Repositories.Interface;
using InsightWorkshop.Lms.Services.Interface;
using InsightWorkshop.Lms.ViewModels;
using System;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Services.Service
{
    public class UserService : IUserService
    {
        public readonly IUserRepository _repo;

        public UserService(IUserRepository repo)
        {
            _repo = repo;
        }

    
        public async Task<LoginViewModel> Login(User user)
        {
            var viewModel = new LoginViewModel();

            var result = await _repo.AuthorizeUser(user);

            if (result != null)
            {
                viewModel.User = result;
                viewModel.Success = true;

            }
            else
            {
                viewModel.Success = false;
                viewModel.Message = "Unauthorized";
            }
            return viewModel;
        }

        public async Task<LoginViewModel> Register(User user)
        {

            try
            {
                await _repo.RegisterUser(user);
                return new LoginViewModel
                {
                    Success = true
                };
            }
            catch (Exception ex)
            {
                return new LoginViewModel
                {
                    Success = false,
                    Message = ex.Message,
                    User = user
                };
            }

        }
    }
}
