using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using LabMedico.Models.CustomUser;
using System.Collections.Generic;

namespace LabMedico.Models
{
    public class LaboratorioUser : IdentityUser<int, CustomUserLogin, CustomUserRole, CustomUserClaim>
    {
        public string Usuario { get; set; }
        public string Nombre { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string Calle { get; set; }
        public int? NumeroInterior { get; set; }
        public int? NumeroExterior { get; set; }
        public string Colonia { get; set; }
        public string DelegacionMunicipio { get; set; }
        public int? CodigoPostal { get; set; }
        public string Estado { get; set; }
        public int? Edad { get; set; }
        public string Sexo { get; set; }
        public string Notas { get; set; }
        public int? SucursalId { get; set; }
        public string Estatus { get; set; }

        
        public virtual ICollection<Cita> Citas { get; set; }
        public virtual Sucursal Sucursales { get; set; }

        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<LaboratorioUser, int> manager)
        {
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            return userIdentity;
        }
    }
}