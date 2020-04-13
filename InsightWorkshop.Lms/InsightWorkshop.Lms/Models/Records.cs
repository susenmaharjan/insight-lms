using System;

namespace InsightWorkshop.Lms.Models
{
    public class Records
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int BookId { get; set; }
        public DateTime? ApprovedOn { get; set; }
        public DateTime? Expiry { get; set; }
        public bool ReturnStatus { get; set; }
    }

    public class ApproveRecordsData
    {
        public int RecordId { get; set; }
        public int UserId { get; set; }
        public int BookId { get; set; }
        public string BookTitle { get; set; }
        public string Username { get; set; }

    }
}
