using Microsoft.AspNet.Identity.EntityFramework;

namespace LabMedico.Models.CustomUser
{
    public class CustomRole : IdentityRole<int, CustomUserRole>
    {
        public CustomRole() { }
        public CustomRole(string name) { Name = name; }
    }
}