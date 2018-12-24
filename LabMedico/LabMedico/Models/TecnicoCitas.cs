using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class TecnicoCitas
    {
        public TecnicoCitas()
        {
        }

        [Key]
        public int TecnicoCitasId { get; set; }
        public int TecnicoId { get; set; }
        public int CitaId { get; set; }

        public virtual Tecnico Tecnico { get; set; }
    }
}