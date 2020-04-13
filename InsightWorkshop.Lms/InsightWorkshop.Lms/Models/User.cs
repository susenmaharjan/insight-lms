﻿namespace InsightWorkshop.Lms.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public string Email { get; set; }
    }

    public enum UserEnum
    {
        Admin = 1,
        User = 2
    }
}
