using Dapper;
using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Repositories.Interface;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Repositories.Repository
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

        public async Task ApproveRecord(Records record)
        {
            await _db.ExecuteAsync("procApproveBook", new
            {
                record.Id,
                record.ApprovedOn,
                record.Expiry
            }, commandType: CommandType.StoredProcedure);
        }

        public async Task BorrowBook(Records records)
        {
            await _db.ExecuteAsync("procBorrowBook", new
            {
                records.UserId,
                records.BookId
            }, commandType: CommandType.StoredProcedure);
        }

        public async Task DeleteBookById(int id)
        {
            await _db.ExecuteAsync("procDeleteBookById", new { Id = id }, commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<ApproveRecordsData>> GetApprovedRecordsByUser(int userId)
        {
            IEnumerable<ApproveRecordsData> records;
            records = await _db.QueryAsync<ApproveRecordsData>("procGetApprovedRecordsByUser", new { UserId = userId }, commandType: CommandType.StoredProcedure);

            return records;
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

        public async Task<Records> GetRecordById(int recordId)
        {
            Records record;
            record = await _db.QueryFirstOrDefaultAsync<Records>("procGetRecordById", new { Id = recordId }, commandType: CommandType.StoredProcedure);
            return record;
        }

        public async Task<IEnumerable<ApproveRecordsData>> GetUnapprovedRecords()
        {
            IEnumerable<ApproveRecordsData> records;
            records = await _db.QueryAsync<ApproveRecordsData>("procGetUnapprovedRecords", commandType: CommandType.StoredProcedure);

            return records;
        }

        public async Task ReturnBook(Records record)
        {
            await _db.ExecuteAsync("procReturnBook", new
            {
                record.Id,
                record.ReturnStatus
            }, commandType: CommandType.StoredProcedure);
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
