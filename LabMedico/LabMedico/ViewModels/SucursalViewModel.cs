using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace LabMedico.ViewModels
{
    public class SucursalViewModel
    {
        public int SucursalId { get; set; }

        [Display(Name = "Nombre de Sucursal")]
        public string Nombre { get; set; } = "";

        [Display(Name = "Delegacion o Municipio")]
        public string DelegacionMunicipio { get; set; } = "";

        [Display(Name = "Codigo Postal")]
        public int? CodigoPostal { get; set; } = 0;

        [Display(Name = "Telefono")]
        public string Telefono { get; set; } = "";

        [Display(Name = "Horario")]
        public string Horario { get; set; } = "";

        [Display(Name = "ZonaId")]
        public int ZonaId { get; set; }

        [Display(Name = "Zona")]
        public string ZonaNombre { get; set; }
    }
}