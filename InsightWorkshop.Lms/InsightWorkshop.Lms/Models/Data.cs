namespace InsightWorkshop.Lms.Models
{
    public class Data
    {
        public bool Success { get; set; }
        public string Message { get; set; }
    }

    public class EmailDetails
    {
        public string MailAddress { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string RecordExpiryInDay { get; set; }
    }

    public class AppSettings
    {
        public EmailDetails EmailDetails { get; set; }
    }
}
