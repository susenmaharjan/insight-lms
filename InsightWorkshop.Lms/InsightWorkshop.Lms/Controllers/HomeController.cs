using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using InsightWorkshop.Lms.Models;
using System.Threading.Tasks;
using InsightWorkshop.Lms.Services.Interface;
using Microsoft.AspNetCore.Authentication;
using System.Collections.Generic;
using System.Security.Claims;
using System;
using Microsoft.AspNetCore.Authentication.Cookies;

namespace InsightWorkshop.Lms.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IUserService _userService;

        public HomeController(ILogger<HomeController> logger, IUserService userService)
        {
            _logger = logger;
            _userService = userService;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> LoginUser(User user)
        {
            try
            {
                var result = await _userService.Login(user);

                if (result.Success)
                {
                    string role;
                    if (result.User.RoleId == (int)UserEnum.Admin)
                    {
                        role = "Admin";
                    }
                    else if (result.User.RoleId == (int)UserEnum.User)
                    {
                        role = "User";
                    }
                    else
                    {
                        throw new Exception();
                    }

                    var userClaims = new List<Claim>()
                {
                    new Claim(ClaimTypes.Name, result.User.Username),
                    new Claim(ClaimTypes.Email, result.User.Email),
                    new Claim(ClaimTypes.Role, role),
                    new Claim(ClaimTypes.NameIdentifier, result.User.Id.ToString()
                    )
                };
                    var identity = new ClaimsIdentity(userClaims, "UserIdentity");
                    var userPrincipal = new ClaimsPrincipal(new[] { identity });
                    await HttpContext.SignInAsync(userPrincipal);

                    return RedirectToAction("Index", "Inventory");
                }
                else
                {
                    return View("Index", result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.StackTrace);
                throw;
            }

        }

        public async Task<IActionResult> Logout()
        {
            try
            {
                await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.StackTrace);
                throw;
            }
        }

        [HttpGet]
        public IActionResult Registration()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Registration(User user)
        {
            try
            {
                var result = await _userService.Register(user);
                if (result.Success)
                {
                    return View("Index");
                }
                else
                {
                    return View(result);
                }

            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                throw;
            }
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
