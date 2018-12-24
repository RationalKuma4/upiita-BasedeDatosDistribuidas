using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class AnalisisSucursal
    {
        [Key]
        public int AnalisisSucursalId { get; set; }

        [Required]
        [Display(Name = "Sucursal")]
        public int SucursalId { get; set; }

        [Required]
        [Display(Name = "Analisis")]
        public int AnalisisId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Costo del analisis")]
        [DataType(DataType.Currency)]
        public decimal? Costo { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estatus")]
        [StringLength(3, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Estatus { get; set; } = "";

        public virtual Analisis Analisis { get; set; }
        public virtual Sucursal Sucursales { get; set; }
    }
}