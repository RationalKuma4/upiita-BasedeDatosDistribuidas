using LabMedico.Models;
using System.Collections.Generic;
using LabMedico.ViewModels;
using System.Linq;
using System.Data.Entity;

namespace LabMedico.ReportRepository
{
    public class CItasRepository
    {
        private readonly LaboratorioDbContext _db;
        public CItasRepository()
        {
            _db = new LaboratorioDbContext();
        }

        public List<CitaEmisionViewModel> RegresaNota(int citaId = 0)
        {
            var datosCita = _db.Citas
                .Where(c => c.CitaId == citaId)
                .Include(a => a.Analisis)
                .Include(cl => cl.Clientes)
                .Include(u => u.Usuarios)
                .FirstOrDefault();

            var datosSucursal = _db.Sucursals
                .Where(s => s.SucursalId == datosCita.Usuarios.SucursalId)
                .FirstOrDefault();

            var datosTecnico = _db.TecnicoCitas
                .Where(t => t.CitaId == datosCita.CitaId)
                .Include(te => te.Tecnico)
                .FirstOrDefault();

            var datosEstudio = _db.Estudios
                .Where(e => e.EstudioId == datosCita.Analisis.EstudioId)
                .FirstOrDefault();

            var monto = _db.AnalisisSucursals
                .Where(s => s.SucursalId == datosCita.Usuarios.SucursalId && s.AnalisisId == datosCita.AnalisisId)
                .FirstOrDefault()
                .Costo;

            var citaView = new CitaEmisionViewModel
            {
                Sucursal = datosSucursal.Calle + " "
                + datosSucursal.NumeroInterior.ToString() + " " + datosSucursal.NumeroExterior.ToString() + " "
                + datosSucursal.Colonia + " " + datosSucursal.CodigoPostal.ToString() + " "
                + datosSucursal.DelegacionMunicipio + " " + datosSucursal.Telefono.ToString(),
                CitaId = datosCita.CitaId,
                FechaRegistro = datosCita.FechaRegistro,
                ClienteNombre = datosCita.Clientes.Nombre + "" + datosCita.Clientes.ApellidoPaterno + " "
                + datosCita.Clientes.ApellidoMaterno,
                ClienteId = datosCita.ClienteId,
                DatosCliente = datosCita.Clientes.Edad.ToString() + " " + datosCita.Clientes.Sexo + " "
                + datosCita.Clientes.Peso.ToString(),
                TecnicoNombre = datosTecnico.Tecnico.Nombre + " " + datosTecnico.Tecnico.ApellidoPaterno + " "
                + datosTecnico.Tecnico.ApellidoMaterno,
                TelefonoCliente = datosCita.Clientes.Telefono,
                DireccionCliente = datosCita.Clientes.Calle + " " + datosCita.Clientes.NumeroExterior.ToString() + " "
                + datosCita.Clientes.NumeroInterior.ToString() + " " + datosCita.Clientes.Colonia + " "
                + datosCita.Clientes.CodigoPostal.ToString() + " " + datosCita.Clientes.DelegacionMunicipio,
                FechaEntrega = datosCita.FechaEntrega,
                EstudioNombre = datosEstudio.Nombre,
                AnalisisNombre = datosCita.Analisis.Nombre,
                Monto = monto,
                ObservacionesRequisitos = datosCita.Analisis.Requisitos
            };

            return new List<CitaEmisionViewModel>() { citaView };
        }
    }
}