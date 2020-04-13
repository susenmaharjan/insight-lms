using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.ViewModels;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Services.Interface
{
    public interface IUserService
    {
        public Task<LoginViewModel> Login(User user);
        public Task<LoginViewModel> Register(User user);
    }
}
