using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class Analisis
    {
        public Analisis()
        {
            AnalisisSucursal = new HashSet<AnalisisSucursal>();
            Citas = new HashSet<Cita>();
        }

        [Key]
        public int AnalisisId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Nombre de Analisis")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string Nombre { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Descripción Analisis")]
        [StringLength(1000, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.MultilineText)]
        public string Descripcion { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Requisitos para el analisis")]
        [StringLength(5000, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.MultilineText)]
        public string Requisitos { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estatus")]
        [StringLength(3, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Estatus { get; set; } = "";

        [Required]
        [Display(Name = "Tipo de estudio")]
        public int EstudioId { get; set; }

        public virtual Estudio Estudios { get; set; }
        public virtual ICollection<AnalisisSucursal> AnalisisSucursal { get; set; }
        public virtual ICollection<Cita> Citas { get; set; }
    }
}