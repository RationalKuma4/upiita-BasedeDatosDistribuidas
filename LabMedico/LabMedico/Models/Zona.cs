using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class Zona
    {
        [Key]
        public int ZonaId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Nombre de Zona")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string ZonaNombre { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Descripción Zona")]
        [StringLength(500, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.MultilineText)]
        public string Descripcion { get; set; } = "";
    }
}