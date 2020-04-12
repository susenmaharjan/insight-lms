using Dapper;
using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Repositories.Interface;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Repositories.Service
{
    public class InventoryRepository : IInventoryRepository
    {
        private readonly IDbConnection _db;

        public InventoryRepository(IDbConnection db)
        {
            _db = db;
        }

        public async Task<bool> Add(Book book)
        {
            string query = @"INSERT INTO [dbo].Books ([Title], [Author], [Quantity], [Availability]) VALUES(@Title, @Author, @Quantity, @Availability)";
            await _db.ExecuteAsync(query, new
            {
                book.Title,
                book.Author,
                book.Quantity,
                book.Availability
            });
            return true;
        }

        public async Task DeleteBookById(int id)
        {
            await _db.ExecuteAsync("procDeleteBookById", new { Id = id }, commandType: CommandType.StoredProcedure);
        }

        public async Task<Book> GetBookById(int id)
        {
            Book book;
            book = await _db.QueryFirstOrDefaultAsync<Book>("procGetBookById", new { Id = id }, commandType: CommandType.StoredProcedure);
            return book;
        }

        public async Task<IEnumerable<Book>> GetBooks()
        {
            IEnumerable<Book> books;
            books = await _db.QueryAsync<Book>("procGetBooks", commandType: CommandType.StoredProcedure);

            return books;
        }

        public async Task Update(Book book)
        {
            await _db.ExecuteAsync("procUpdateBook", new
            {
                book.Id,
                book.Author,
                book.Availability,
                book.Quantity,
                book.Title
            },
            commandType: CommandType.StoredProcedure
            );
        }
    }
}
