using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Repositories.Interface;
using InsightWorkshop.Lms.Services.Interface;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Services.Service
{
    public class InventoryService : IInventoryService
    {
        private readonly IInventoryRepository _repo;

        public InventoryService(IInventoryRepository repo)
        {
            _repo = repo;
        }

        public async Task<bool> Add(Book book)
        {
            return await _repo.Add(book);
        }

        public async Task ApproveRecord(int recordId)
        {
            var record = await _repo.GetRecordById(recordId);

            record.ApprovedOn = DateTime.Now;
            record.Expiry = DateTime.Now.AddDays(2);

            await _repo.ApproveRecord(record);

            //minimize quantity
            var book = await _repo.GetBookById(record.BookId);
            book.Quantity--;

            //update book records
            await _repo.Update(book);
        }

        public async Task BorrowBook(Records records)
        {
            await _repo.BorrowBook(records);
        }

        public async Task DeleteBookById(int id)
        {
            await _repo.DeleteBookById(id);
        }

        public async Task<IEnumerable<ApproveRecordsData>> GetApprovedRecordsByUser(int userId)
        {
            return await _repo.GetApprovedRecordsByUser(userId);
        }

        public async Task<Book> GetBookById(int id)
        {
            return await _repo.GetBookById(id);
        }

        public async Task<IEnumerable<Book>> GetBooks()
        {
            return await _repo.GetBooks();
        }

        public async Task<IEnumerable<ApproveRecordsData>> GetUnapprovedRecords()
        {
            return await _repo.GetUnapprovedRecords();
        }

        public async Task ReturnBook(int recordId)
        {
            var record = await _repo.GetRecordById(recordId);

            record.ReturnStatus = true;

            await _repo.ReturnBook(record);

            var book = await _repo.GetBookById(record.BookId);
            book.Quantity++;

            await _repo.Update(book);
        }

        public async Task Update(Book book)
        {
            await _repo.Update(book);
        }
    }
}
