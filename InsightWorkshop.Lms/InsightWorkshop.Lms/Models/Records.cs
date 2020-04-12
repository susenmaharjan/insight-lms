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
    }
}
