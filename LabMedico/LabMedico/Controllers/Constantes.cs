using System.Collections.Generic;
using System.Web.Mvc;

namespace LabMedico.Controllers
{
    public class Constantes
    {
        public static readonly IReadOnlyCollection<SelectListItem> estatus = new List<SelectListItem>
        {
            new SelectListItem {Text="Activo", Value="Act" },
            new SelectListItem {Text="Inactivo", Value="Inc" }
        };
    }
}