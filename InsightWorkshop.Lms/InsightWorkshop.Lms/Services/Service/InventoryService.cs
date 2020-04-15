using InsightWorkshop.Lms.Models;
using InsightWorkshop.Lms.Repositories.Interface;
using InsightWorkshop.Lms.Services.Interface;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Mail;
using System.Reflection;
using System.Threading.Tasks;

namespace InsightWorkshop.Lms.Services.Service
{
    public class InventoryService : IInventoryService
    {
        private readonly IInventoryRepository _repo;

        public InventoryService(IInventoryRepository repo, IConfiguration configuration)
        {
            _repo = repo;
        }

        public async Task<bool> Add(Book book)
        {
            return await _repo.Add(book);
        }

        public async Task ApproveRecord(int recordId)
        {
            var appSetting = GetAppSettingData();

            int expiryDay = 2;
            int.TryParse(appSetting.EmailDetails.RecordExpiryInDay, out expiryDay);

            var record = await _repo.GetRecordById(recordId);

            record.ApprovedOn = DateTime.Now;
            record.Expiry = DateTime.Now.AddDays(expiryDay);

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

        public async Task<IEnumerable<ApproveRecordsData>> GetReturnedRecords()
        {
            return await _repo.GetReturnedRecords();
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

        public async Task<IEnumerable<ApproveRecordsData>> SendEmails()
        {
            var appSettings = GetAppSettingData();

            int expiryDay = 2;
            int.TryParse(appSettings.EmailDetails.RecordExpiryInDay, out expiryDay);

            var records = await _repo.GetLateRecordsByDate(DateTime.Now.AddDays(-expiryDay));

            foreach (var record in records)
            {
                using (var mail = new MailMessage())
                {
                    SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                    mail.From = new MailAddress(appSettings.EmailDetails.MailAddress);
                    mail.To.Add(record.Email);
                    mail.Subject = "Return date expired";
                    mail.Body = $"Dear {record.Username}, \n Your date to return {record.BookTitle} has expired, Please return book as soon as possible. \n Regards,\n Admin";

                    SmtpServer.Port = 587;
                    SmtpServer.UseDefaultCredentials = false;
                    SmtpServer.Credentials = new System.Net.NetworkCredential(appSettings.EmailDetails.Username, appSettings.EmailDetails.Password);
                    SmtpServer.EnableSsl = true;
                    try
                    {
                        SmtpServer.Send(mail);
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                }
            }

            return records;
        }

        public async Task Update(Book book)
        {
            await _repo.Update(book);
        }

        private AppSettings GetAppSettingData()
        {
            string executableLocation = Path.GetDirectoryName(
                    Assembly.GetExecutingAssembly().Location);
            string appSettingLocation = Path.Combine(executableLocation, "appsettings.json");
            var json = File.ReadAllText(appSettingLocation);
            var data = JsonConvert.DeserializeObject<AppSettings>(json);
            return data;
        }
    }
}
