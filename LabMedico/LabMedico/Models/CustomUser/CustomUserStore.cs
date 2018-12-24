using Microsoft.AspNet.Identity.EntityFramework;

namespace LabMedico.Models.CustomUser
{
    public class CustomUserStore : UserStore<LaboratorioUser, CustomRole, int,
    CustomUserLogin, CustomUserRole, CustomUserClaim>
    {
        public CustomUserStore(LaboratorioDbContext context)
            : base(context)
        {
        }
    }
}