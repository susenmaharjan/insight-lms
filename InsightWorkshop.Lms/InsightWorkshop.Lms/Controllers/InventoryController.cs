using System.Threading.Tasks;
using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace InsightWorkshop.Lms.Controllers
{
    public class InventoryController : Controller
    {
        private readonly IInventoryService _service;

        public InventoryController(IInventoryService service)
        {
            _service = service;
        }


        public async Task<IActionResult> Index()
        {
            var books = await _service.GetBooks();

            return View(books);
        }

        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create(Book book)
        {
            await _service.Add(book);
            var books = await _service.GetBooks();
            return View("Index", books);
        }

        [HttpGet]
        public async Task<IActionResult> Update(int id)
        {
            var book = await _service.GetBookById(id);
            return View(book);
        }

        [HttpPost]
        public async Task<IActionResult> Update(Book book)
        {
            await _service.Update(book);
            var model = await _service.GetBookById(book.Id);
            return View("Details", model);
        }

        public async Task<IActionResult> Details(int id)
        {
            var book = await _service.GetBookById(id);
            return View(book);
        }

        public async Task<IActionResult> Delete(int id)
        {
            await _service.DeleteBookById(id);
            var books = await _service.GetBooks();
            return View("Index", books);
        }
    }
}