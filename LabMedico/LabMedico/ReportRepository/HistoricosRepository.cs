using System;
using System.Collections.Generic;
using System.Linq;
using LabMedico.Models;
using LabMedico.ViewModels;
using System.Data.Entity;

namespace LabMedico.ReportRepository
{
    public class HistoricosRepository
    {
        private readonly LaboratorioDbContext _db;
        public HistoricosRepository()
        {
            _db = new LaboratorioDbContext();
        }

        public List<HistoricoSucursalViewModel> HistoricoxSucursal(int id = 0)
        {
            var regsitros = _db.Historicoes
                .Include(c => c.Citas)
                .Include(u => u.Citas.Usuarios)
                .Include(s => s.Citas.Usuarios.Sucursales)
                .Include(a => a.Citas.Analisis)
                .Where(p => p.Citas.Usuarios.SucursalId == id)
                .ToList();

            var historicoLista = new List<HistoricoSucursalViewModel>();

            regsitros.ForEach(r =>
            historicoLista.Add(
                new HistoricoSucursalViewModel
                {
                    SucursalId = r.Citas.Usuarios.Sucursales.SucursalId,
                    NombreSucursal = r.Citas.Usuarios.Sucursales.Nombre,
                    CitaId = r.CitaId,
                    AnalaisisId = r.Citas.Analisis.AnalisisId,
                    NombreAnalisis = r.Citas.Analisis.Nombre,
                    Monto = Convert.ToDecimal(r.Monto),
                    FechaRegistro = Convert.ToDateTime(r.FechaRegistro)
                }));

            return historicoLista;
        }

        public List<HistoricoSucursalViewModel> HistoricoAnual()
        {
            var regsitros = _db.Historicoes
                .Include(c => c.Citas)
                .Include(u => u.Citas.Usuarios)
                .Include(s => s.Citas.Usuarios.Sucursales)
                .Include(a => a.Citas.Analisis)
                .Where(h => h.FechaRegistro.Value.Year == DateTime.Now.Year)
                .ToList();

            var historicoLista = new List<HistoricoSucursalViewModel>();

            regsitros.ForEach(r =>
            historicoLista.Add(
                new HistoricoSucursalViewModel
                {
                    SucursalId = r.Citas.Usuarios.Sucursales.SucursalId,
                    NombreSucursal = r.Citas.Usuarios.Sucursales.Nombre,
                    CitaId = r.CitaId,
                    AnalaisisId = r.Citas.Analisis.AnalisisId,
                    NombreAnalisis = r.Citas.Analisis.Nombre,
                    Monto = Convert.ToDecimal(r.Monto),
                    FechaRegistro = Convert.ToDateTime(r.FechaRegistro)
                }));

            return historicoLista;
        }
    }
}