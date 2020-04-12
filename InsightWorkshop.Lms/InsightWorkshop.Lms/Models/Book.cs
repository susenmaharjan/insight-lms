namespace InsightWorkshop.Lms.Models
{
    public class Book
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }
        public int Quantity { get; set; }
        public bool Availability { get; set; }
    }
}
