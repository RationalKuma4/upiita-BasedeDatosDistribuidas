using Microsoft.AspNet.Identity.EntityFramework;

namespace LabMedico.Models.CustomUser
{
    public class CustomRoleStore : RoleStore<CustomRole, int, CustomUserRole>
    {
        public CustomRoleStore(LaboratorioDbContext context)
            : base(context)
        {
        }
    }
}