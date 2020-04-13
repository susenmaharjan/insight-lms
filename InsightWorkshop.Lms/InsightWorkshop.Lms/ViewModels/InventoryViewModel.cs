using InsightWorkshop.Lms.Models;
using System.Collections.Generic;

namespace InsightWorkshop.Lms.ViewModels
{
    public class InventoryViewModel
    {
        public IEnumerable<Book> Books { get; set; }
        public IEnumerable<ApproveRecordsData> Records { get; set; }
        public UserEnum Role { get; set; }
    }
}
