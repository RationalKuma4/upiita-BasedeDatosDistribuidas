using System;

namespace LabMedico.ViewModels
{
    public class CitaEmisionViewModel
    {
        public string Sucursal { get; set; }
        public int? CitaId { get; set; }
        public DateTime? FechaRegistro { get; set; }
        public int? ClienteId { get; set; }
        public string ClienteNombre { get; set; }
        public string DatosCliente { get; set; }
        public string TelefonoCliente { get; set; }
        public string DireccionCliente { get; set; }
        public int? TecnicoId { get; set; }
        public string TecnicoNombre { get; set; }
        public DateTime? FechaEntrega { get; set; }
        public DateTime? FechaAplicacion { get; set; }
        public string HoraAplicacion { get; set; }
        public string Usuario { get; set; }
        public string EstudioNombre { get; set; }
        public string AnalisisNombre { get; set; }
        public decimal? Monto { get; set; }
        public string ObservacionesRequisitos { get; set; }
    }
}