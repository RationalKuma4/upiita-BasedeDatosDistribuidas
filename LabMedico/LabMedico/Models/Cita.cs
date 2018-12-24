using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class Cita
    {
        public Cita()
        {
            Historicos = new HashSet<Historico>();
        }

        [Key]
        public int CitaId { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [ScaffoldColumn(false)]
        public DateTime? FechaRegistro { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [ScaffoldColumn(false)]
        public DateTime? FechaEntrega { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Fecha de Aplicación")]
        [DataType(DataType.Date)]
        public DateTime? FechaAplicacion { get; set; }

        [Required]
        [Display(Name = "Hora de Aplicación")]
        public string HoraAplicacion { get; set; }

        [Required]
        [ScaffoldColumn(false)]
        public int Id { get; set; }

        [Required]
        [Display(Name = "Cliente")]
        public int ClienteId { get; set; }

        [Required]
        [Display(Name = "Analisis")]
        public int AnalisisId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estatus")]
        [StringLength(3, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Estatus { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Monto")]
        [DataType(DataType.Currency)]
        [ScaffoldColumn(false)]
        public decimal? Monto { get; set; } = 0;

        public virtual Analisis Analisis { get; set; }
        public virtual Cliente Clientes { get; set; }
        public virtual LaboratorioUser Usuarios { get; set; }
        public virtual ICollection<Historico> Historicos { get; set; }
    }
}