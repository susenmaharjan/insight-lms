using InsightWorkshop.Lms.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Services.Interface
{
    public interface IInventoryService
    {
        Task<IEnumerable<Book>> GetBooks();
        Task<bool> Add(Book book);
        Task<Book> GetBookById(int id);
        Task Update(Book book);
        Task DeleteBookById(int id);
        Task BorrowBook(Records records);
        Task ApproveRecord(int recordId);
        Task ReturnBook(int recordId);
        Task<IEnumerable<ApproveRecordsData>> GetUnapprovedRecords();
        Task<IEnumerable<ApproveRecordsData>> GetApprovedRecordsByUser(int userId);
        Task<IEnumerable<ApproveRecordsData>> GetReturnedRecords();
        Task<IEnumerable<ApproveRecordsData>> SendEmails();
    }
}
