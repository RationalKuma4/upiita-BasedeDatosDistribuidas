using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class Estudio
    {
        public Estudio()
        {
            Analisis = new HashSet<Analisis>();
            Tecnicos = new HashSet<Tecnico>();
        }

        [Key]
        public int EstudioId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Nombre de Estudio")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string Nombre { get; set; } = "";
        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Descripcion de Estudio")]
        [StringLength(500, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.MultilineText)]
        public string Descripcion { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estatus")]
        [StringLength(3, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Estatus { get; set; }

        public virtual ICollection<Analisis> Analisis { get; set; }
        public virtual ICollection<Tecnico> Tecnicos { get; set; }
    }
}