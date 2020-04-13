using System;
using System.Security.Claims;
using System.Threading.Tasks;
using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Services.Interface;
using InsightWorkshop.Lms.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InsightWorkshop.Lms.Controllers
{
    [Authorize]
    public class InventoryController : Controller
    {
        private readonly IInventoryService _service;
        private readonly IHttpContextAccessor _context;
        private readonly string username;
        private readonly int userId;
        public UserEnum UserRole { get; set; }

        public InventoryController(IInventoryService service, IHttpContextAccessor httpContextAccessor)
        {
            _service = service;
            _context = httpContextAccessor;

            var userRole = _context.HttpContext.User.FindFirst(ClaimTypes.Role).Value;
            username = _context.HttpContext.User.FindFirst(ClaimTypes.Name).Value;
            userId = int.Parse(_context.HttpContext.User.FindFirst(ClaimTypes.NameIdentifier).Value);

            if (userRole.Equals("admin", StringComparison.OrdinalIgnoreCase))
            {
                UserRole = UserEnum.Admin;
            }
            else
            {
                UserRole = UserEnum.User;
            }


        }


        public async Task<IActionResult> Index()
        {
            var viewModel = new InventoryViewModel
            {
                Role = UserRole,
                Books = await _service.GetBooks()
            };

            if (UserRole == UserEnum.Admin)
            {
                viewModel.Records = await _service.GetUnapprovedRecords();
            }
            else if (UserRole == UserEnum.User)
            {
                viewModel.Records = await _service.GetApprovedRecordsByUser(userId);
            }

            return View(viewModel);
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

        [Authorize(Roles = "User")]
        public async Task<IActionResult> Borrow(Records record)
        {
            record.UserId = userId;

            await _service.BorrowBook(record);

            return View("Message", new Data() { Message = "Borrow request has been sent!" });
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Approve(int recordId)
        {
            await _service.ApproveRecord(recordId);
            return View("Message", new Data() { Message = "Approved succesfully!" });
        }

        [Authorize(Roles = "User")]
        public async Task<IActionResult> Return(int recordId)
        {
            await _service.ReturnBook(recordId);
            return View("Message", new Data() { Message = "Returned succesfully!" });
        }

    }
}