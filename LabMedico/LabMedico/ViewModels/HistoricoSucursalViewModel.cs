using System;

namespace LabMedico.ViewModels
{
    public class HistoricoSucursalViewModel
    {
        public int SucursalId { get; set; }
        public string NombreSucursal { get; set; }
        public int CitaId { get; set; }
        //public int EstudioId { get; set; }
        //public string NombreEstudio { get; set; }
        public int AnalaisisId { get; set; }
        public string NombreAnalisis { get; set; }
        public decimal Monto { get; set; }
        public DateTime FechaRegistro { get; set; }
    }
}