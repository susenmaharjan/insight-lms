using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Repositories.Interface;
using InsightWorkshop.Lms.Services.Interface;
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

        public async Task DeleteBookById(int id)
        {
            await _repo.DeleteBookById(id);
        }

        public async Task<Book> GetBookById(int id)
        {
            return await _repo.GetBookById(id);
        }

        public async Task<IEnumerable<Book>> GetBooks()
        {
            return await _repo.GetBooks();
        }

        public async Task Update(Book book)
        {
            await _repo.Update(book);
        }
    }
}
