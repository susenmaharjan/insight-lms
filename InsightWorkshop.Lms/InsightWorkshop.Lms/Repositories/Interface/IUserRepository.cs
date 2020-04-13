using InsightWorkshop.Lms.Models;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Repositories.Interface
{
    public interface IUserRepository
    {
        Task<User> AuthorizeUser(User user);
        Task RegisterUser(User user);
    }
}
