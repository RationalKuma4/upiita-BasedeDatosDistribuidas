using System;
using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class Historico
    {
        [Key]
        public int HistoricoId { get; set; }

        [Required]
        public int CitaId { get; set; }

        [Required]
        [DataType(DataType.Date)]
        public DateTime? FechaRegistro { get; set; }

        [Required]
        [DataType(DataType.Currency)]
        public decimal? Monto { get; set; }

        public virtual Cita Citas { get; set; }
    }
}