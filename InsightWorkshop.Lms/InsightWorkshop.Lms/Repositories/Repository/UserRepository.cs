using Dapper;
using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Repositories.Interface;
using System;
using System.Data;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Repositories.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly IDbConnection _db;

        public UserRepository(IDbConnection db)
        {
            _db = db;
        }

        public async Task<User> AuthorizeUser(User user)
        {
            var result = await _db.QueryFirstOrDefaultAsync<User>("procAuthorizeUser", new
            {
                Username = user.Username,
                Password = user.Password
            },
            commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task RegisterUser(User user)
        {
            await _db.ExecuteAsync("procRegisterUser", new
            {
                user.Username,
                user.Password,
                user.Email
            }, commandType: CommandType.StoredProcedure);
        }
    }
}
